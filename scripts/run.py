import sys
import os
import argparse
from pathlib import Path
import subprocess
import shutil

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
parser.add_argument("--project-dir", dest="projectDir", required=True, type=str, 
                    help="Path to the location of CodeQL databases")

parsed_arguments = parser.parse_args()

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

if __name__ == '__main__':
    # Get absolute paths
    workingDirectory = str(Path(__file__).parent.absolute() / "workingDirectory")
    resultsDirectory = str(Path(__file__).parent.absolute() / "results")
    resultsLogDirectory = str(Path(__file__).parent.absolute() / "results" / "logs")
    logDirectory = str(Path(__file__).parent.absolute() / "logs")
    # Create results and working folders
    os.makedirs(workingDirectory, exist_ok = True)
    os.makedirs(resultsDirectory, exist_ok = True)
    os.makedirs(resultsLogDirectory, exist_ok=True)
    shutil.rmtree(logDirectory, ignore_errors=True)
    os.makedirs(logDirectory)   
    # Write config.json file
    config = "{\n"
    config = config + f'"codeQLExecutable": "{parsed_arguments.CodeQLExecutable}",\n'
    config = config + f'"codeQLSourcesRoot": "{parsed_arguments.QLSourceCode}",\n'
    config = config + f'"workingDirectory": "{workingDirectory}",\n'
    config = config + f'"resultsDirectory": "{resultsDirectory}",\n'
    config = config + f'"searchPath": ".",\n' # TODO: is this redundant?
    config = config + f'"worseLibSearchPath": "{parsed_arguments.QLSourceCode}",\n'
    config = config + f'"logsDirectory": "{logDirectory}"\n'
    config = config + "}"
    with open("config.json", "w") as text_file:
        print(f"{config}", file=text_file)
    # Invoke TSM
    query_name, query_type = convertQueryName(parsed_arguments.query_name)
    tsm_path = str(Path(__file__).absolute().parent.parent / "code" / "main.py")
    command = ["python", tsm_path, "--project-dir", f'{parsed_arguments.projectDir}',
        "--results-dir", f'{resultsDirectory}', "--working-dir", f'{workingDirectory}',
        "--query-name", f'{query_name}', "--query-type", f'{query_type}',
        "--solver=CBC", "--project-list", f'{parsed_arguments.projectList}',
        "--steps=generate_entities,generate_model,optimize", "run"]
    print("COMMAND: " + ' '.join(command))
    result = subprocess.run(command, capture_output=True, text=True)
    print("RESULT: " + result.stdout)
    print("ERROR: " + result.stderr)

'''
python ../code/main.py \
   --project-dir /home/wright/ATM-JavaScript-Databases/nosql_databases \
   --results-dir /home/wright/coding/ml-ql-taint-specification-mining/results \
   --working-dir /home/wright/coding/ml-ql-taint-specification-mining/workingDirectory \
   --query-name NosqlInjectionWorse \
   --query-type NoSql \
   --solver=CBC \
   --project-list nosql_projects.txt \
   --steps=generate_entities,generate_model,optimize \
   run
'''
