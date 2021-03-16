import sys
import os
import argparse
from pathlib import Path
import subprocess
import shutil

def parseArguments():
    parser = argparse.ArgumentParser()
    parser.add_argument("--query-name", dest="query_name", required=True, type=str,
                        choices=["NoSql", "Sql", "Xss", "TaintedPath"],
                        help="Name of the query to solve")
    parser.add_argument("--project-list", dest="projectList", required=True, type=str, 
                        help="Run all steps on the project passed on this list")
    parser.add_argument("--CodeQL-executable", dest="CodeQLExecutable", required=True, type=str, 
                        help="Path to the location of the CodeQL executable")
    parser.add_argument("--QL-source-code", dest="QLSourceCode", required=True, type=str, 
                        help="Path to the location of the QL source code (queries)")
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

def databasePath(database_name, project_dir):
    return os.path.join(f'{project_dir}', f'{database_name}')

def databaseExists(database_name, project_dir):
    return os.path.exists(databasePath(database_name, project_dir))

def fetchDatabaseCommand(database_name, project_dir):
    # We assume that the database_name is stored as a .zip file on blob store
    database_path = databasePath(database_name, project_dir)
    command = "azcopy copy " + f'"https://atmcodeqldata.blob.core.windows.net/atm/javascript-databases/nosql_800_no_evaluation/{database_name}' + "?" + "${SAS_TOKEN}\"" + f' "{database_path}"' + ' --overwrite=true --check-md5 FailIfDifferent --from-to=BlobLocal --recursive'
    return command

def fetchDatabase(database_name, project_dir):
    # Conditionally fetch the database
    full_database_name = database_name + ".zip"
    if not databaseExists(full_database_name, project_dir):
        '''
        We need to ensure that the unzip folder name is the same as the zipped folder name.
        We can't guarantee this, so we unzip to a clean temporary directory first before
        copying to unzipped contents to their final location with a correct name
        '''
        tempUnzipDirectory = os.path.join(project_dir, "tmp")
        shutil.rmtree(tempUnzipDirectory, ignore_errors=True)
        os.makedirs(tempUnzipDirectory)
        # Fetch from Azure blob store
        command = fetchDatabaseCommand(full_database_name, project_dir)
        try:
            print(f'-Fetching {database_name}')
            subprocess.check_call(command, text=True, shell=True)
            if not databaseExists(full_database_name, project_dir):
                print(f'-Failed to fetch {database_name}')
                print(f'-Failing command is:')
                print("\t" + command)
                return False
            print(f'-Unzipping {database_name}')
            # unzip into tmp directory
            subprocess.check_call(f'unzip {databasePath(full_database_name, project_dir)} -d {tempUnzipDirectory}', text=True, shell=True)
            # move (and rename) to correct location
            subprocess.check_call(f'cp -r {tempUnzipDirectory}/* {project_dir}/{database_name}', text=True, shell=True)
        except subprocess.CalledProcessError as e:
            print(e.output)
            return False
        return True
    else:
        print(f'-Skipping fetch because {database_name} exists')
    return True

def listDatabases(project_list):
    with open(project_list) as f:
        databases = f.readlines()
    databases = [x.strip() for x in databases]
    return databases

def runTSM(projectList, codeQLExecutable, QLSourceCode, query_name, clean):
    # Get absolute paths
    workingDirectory = str(Path(__file__).parent.absolute() / "workingDirectory")
    resultsDirectory = str(Path(__file__).parent.absolute() / "results")
    resultsLogDirectory = str(Path(__file__).parent.absolute() / "results" / "logs")
    logDirectory = str(Path(__file__).parent.absolute() / "logs")
    projectDirectory = str(Path(__file__).parent.absolute() / "databases")
    # Create results and working folders
    if clean:
        print("-Cleaning local state")
        shutil.rmtree(workingDirectory, ignore_errors=True)
        shutil.rmtree(resultsDirectory, ignore_errors=True)
        shutil.rmtree(projectDirectory, ignore_errors=True)
    os.makedirs(workingDirectory, exist_ok = True)
    os.makedirs(resultsDirectory, exist_ok = True)
    os.makedirs(resultsLogDirectory, exist_ok=True)
    shutil.rmtree(logDirectory, ignore_errors=True)
    os.makedirs(logDirectory)
    os.makedirs(projectDirectory, exist_ok = True)
    # Fetch databases
    databases = listDatabases(projectList)
    for database in databases:
        fetchDatabase(database, projectDirectory)
    # Write config.json file
    config = "{\n"
    config = config + f'"codeQLExecutable": "{codeQLExecutable}",\n'
    config = config + f'"codeQLSourcesRoot": "{QLSourceCode}",\n'
    config = config + f'"workingDirectory": "{workingDirectory}",\n'
    config = config + f'"resultsDirectory": "{resultsDirectory}",\n'
    config = config + f'"searchPath": ".",\n' # TODO: is this redundant?
    config = config + f'"worseLibSearchPath": "{QLSourceCode}",\n'
    config = config + f'"logsDirectory": "{logDirectory}"\n'
    config = config + "}"
    with open("config.json", "w") as text_file:
        print(f"{config}", file=text_file)
    # Invoke TSM
    effective_query_name, query_type = convertQueryName(query_name)
    tsm_path = str(Path(__file__).absolute().parent.parent / "code" / "main.py")
    command = ["python3", tsm_path, "--project-dir", f'{projectDirectory}',
        "--results-dir", f'{resultsDirectory}', "--working-dir", f'{workingDirectory}',
        "--query-name", f'{effective_query_name}', "--query-type", f'{query_type}',
        "--solver=CBC", "--project-list", f'{projectList}',
        "--steps=generate_entities,generate_model,optimize", "run"]
    print("-Invoking TSM on specified projects: " + ' '.join(command))
    subprocess.check_call(command, text=True)
    print("-Combining TSM results")
    combine_scores_path = str(Path(__file__).absolute().parent.parent / "code" / "misc" / "combinescores.py")
    # N.B. --project-dir parameter is misnamed, it's value should be results-dir
    command = ["python3", combine_scores_path, "--project-dir", f'{resultsDirectory}', "--query-name", effective_query_name]
    subprocess.check_call(command, text=True)
    print(f'-Completed: final output is allscores_{effective_query_name}_avg.txt')

def main():
    parsed_arguments = parseArguments()
    runTSM(parsed_arguments.projectList, parsed_arguments.CodeQLExecutable, parsed_arguments.QLSourceCode, parsed_arguments.query_name, parsed_arguments.clean)

if __name__ == '__main__':
    main()
