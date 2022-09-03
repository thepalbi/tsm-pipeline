import sys
import os
import argparse
from pathlib import Path
import requests
import subprocess
import shutil
from fetch_database import fetchDatabase

def parseArguments():
    parser = argparse.ArgumentParser()
    parser.add_argument("--query-name", dest="query_name", required=True, type=str,
                        choices=["NoSql", "Sql", "Xss", "TaintedPath"],
                        help="Name of the query to run")
    parser.add_argument("--project-list", dest="project_list", required=True, type=str,
                        help="File containing a list of projects to analyze (either as LGTM.com slugs or as database names to be downloaded from Azure blob storage)")
    parser.add_argument("--CodeQL-executable", dest="codeql_cli", required=True, type=str,
                        help="Location of the CodeQL executable")
    parser.add_argument("--QL-source-code", dest="tsm_ql", required=True, type=str,
                        help="Location of the CodeQL queries and libraries for TSM")
    parser.add_argument("--clean", dest="clean", default=False, required=False, 
                        help="Set to True to perform a clean run")
    parsed_arguments = parser.parse_args()
    return parsed_arguments

def convertQueryName(query_name):
    if query_name == "NoSql":
        return "NosqlInjectionWorse", "NoSql"
    elif query_name == "Sql":
        return "SqlInjectionWorse", "Sql"
    elif query_name == "Xss":
        return "DomBasedXssWorse", "Xss" 
    elif query_name == "TaintedPath":
        return "TaintedPathWorse", "Path"
    else:
        sys.exit(f'Unknown query name {query_name}')

def listDatabases(project_list):
    with open(project_list) as f:
        databases = f.readlines()
    return [x.strip() for x in databases]

def runTSM(project_list, codeql_cli, tsm_ql, query_name, clean):
    # Get absolute paths
    workingDirectory = str(Path(__file__).parent.absolute() / "workingDirectory")
    resultsDirectory = str(Path(__file__).parent.absolute() / "results")
    resultsLogDirectory = str(Path(__file__).parent.absolute() / "results" / "logs")
    logDirectory = str(Path(__file__).parent.absolute() / "logs")
    databasesDirectory = str(Path(__file__).parent.absolute() / "databases")
    # Create results and working folders
    if clean:
        print("-Cleaning local state")
        shutil.rmtree(workingDirectory, ignore_errors=True)
        shutil.rmtree(resultsDirectory, ignore_errors=True)
        shutil.rmtree(databasesDirectory, ignore_errors=True)
    os.makedirs(workingDirectory, exist_ok = True)
    os.makedirs(resultsDirectory, exist_ok = True)
    os.makedirs(resultsLogDirectory, exist_ok=True)
    shutil.rmtree(logDirectory, ignore_errors=True)
    os.makedirs(logDirectory)
    os.makedirs(databasesDirectory, exist_ok = True)
    # Fetch databases
    databases = listDatabases(project_list)
    for database in databases:
        fetchDatabase(database, databasesDirectory, query_name)
    # Write config.json file
    config = "{\n"
    config = config + f'"codeQLExecutable": "{codeql_cli}",\n'
    config = config + f'"codeQLSourcesRoot": "{tsm_ql}",\n'
    config = config + f'"workingDirectory": "{workingDirectory}",\n'
    config = config + f'"resultsDirectory": "{resultsDirectory}",\n'
    config = config + f'"worseLibSearchPath": "{tsm_ql}",\n'
    config = config + f'"logsDirectory": "{logDirectory}"\n'
    config = config + "}"
    with open("config.json", "w") as text_file:
        print(f"{config}", file=text_file)
    # Invoke TSM
    effective_query_name, query_type = convertQueryName(query_name)
    tsm_path = str(Path(__file__).absolute().parent.parent / "code" / "main.py")
    command = ["python3", tsm_path, "--project-dir", f'{databasesDirectory}',
        "--results-dir", f'{resultsDirectory}', "--working-dir", f'{workingDirectory}',
        "--query-name", f'{effective_query_name}', "--query-type", f'{query_type}',
        "--solver=CBC", "--project-list", f'{project_list}',
        "--steps=generate_entities,generate_model,optimize", "run"]
    print("-Invoking TSM on specified projects: " + ' '.join(command))
    try:
        subprocess.check_output(command, text=True, stderr=subprocess.STDOUT)
    except subprocess.CalledProcessError as e:
        print(f"TSM failed with error code {e.returncode}, producing the following output:\n{e.output}")
        sys.exit(e.returncode)
    print("-Combining TSM results")
    combine_scores_path = str(Path(__file__).absolute().parent.parent / "code" / "misc" / "combinescores.py")
    # N.B. --project-dir parameter is misnamed, its value should be results-dir
    command = ["python3", combine_scores_path, "--project-dir", f'{resultsDirectory}', "--query-name", effective_query_name]
    subprocess.check_call(command, text=True)
    print(f'-Completed: final output is allscores_{effective_query_name}_avg.txt')

def main():
    parsed_arguments = parseArguments()
    runTSM(parsed_arguments.project_list, parsed_arguments.codeql_cli, parsed_arguments.tsm_ql, parsed_arguments.query_name, parsed_arguments.clean)

if __name__ == '__main__':
    main()
