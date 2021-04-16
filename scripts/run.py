import sys
import os
import argparse
from pathlib import Path
import requests
import subprocess
import shutil

def parseArguments():
    parser = argparse.ArgumentParser()
    parser.add_argument("--query-name", dest="query_name", required=True, type=str,
                        choices=["NoSql", "Sql", "Xss", "TaintedPath"],
                        help="Name of the query to run")
    parser.add_argument("--project-list", dest="project_list", required=True, type=str,
                        help="File containing a list of projects to analyze (either as LGTM.com slugs or as database names to be downloaded from Azure blob storage)")
    parser.add_argument("--CodeQL-executable", dest="codeql_cli", required=True, type=str,
                        help="Location of the CodeQL executable")
    parser.add_argument("--QL-source-code", dest="codeql_queries", required=True, type=str,
                        help="Location of the CodeQL queries and libraries")
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

def databasePath(database_name, databases_dir):
    database_name = database_name.replace("/", "__")
    return os.path.join(f'{databases_dir}', f'{database_name}.zip')

def databaseExists(database_name, databases_dir):
    return os.path.exists(databasePath(database_name, databases_dir))

def fetchDatabaseCommand(database_name, databases_dir):
    database_path = databasePath(database_name, databases_dir)
    # check whether database_name looks like an LGTM slug
    if "/" in database_name:
        print(f'Downloading {database_name} from LGTM.com')
        lgtm_url = f'https://lgtm.com/api/v1.0/projects/{database_name}'
        # send GET request to lgtm_url and get response as json
        response = requests.get(lgtm_url)
        response.raise_for_status()
        # get project id from the json response
        project_id = response.json()['id']
        print(f'Project id for {database_name} is {project_id}')
        command = (
            f'curl -X GET -L "https://lgtm.com/api/v1.0/snapshots/{project_id}/javascript" '
            f'-o {database_path}'
        )
    else:
        print(f'Downloading {database_name} from Azure blob storage')
        database_zip = database_name + ".zip"
        command = (
            f'azcopy copy "https://atmcodeqldata.blob.core.windows.net/atm/javascript-databases/nosql_800_no_evaluation/{database_zip}?${{ATM_BLOB_STORE_SAS_TOKEN}}" '
            f'{database_path} --overwrite=true '
            f'--check-md5 FailIfDifferent --from-to=BlobLocal --recursive'
        )
    return command

def fetchDatabase(database_name, databases_dir):
    database_dir = f'{databases_dir}/{database_name.replace("/", "_")}'
    # Conditionally fetch the database
    if not os.path.exists(database_dir):
        '''
        We need to ensure that the unzip folder name is the same as the zipped folder name.
        We can't guarantee this, so we unzip to a clean temporary directory first before
        copying the unzipped contents to their final location with a correct name
        '''
        tempUnzipDirectory = os.path.join(databases_dir, "tmp")
        shutil.rmtree(tempUnzipDirectory, ignore_errors=True)
        os.makedirs(tempUnzipDirectory)
        # Fetch from Azure blob store
        command = fetchDatabaseCommand(database_name, databases_dir)
        try:
            print(f'-Fetching {database_name}')
            print(f'-using command: {command}')
            subprocess.check_call(command, text=True, shell=True)
            if not databaseExists(database_name, databases_dir):
                print(f'-Failed to fetch {database_name}')
                print(f'-Failing command is:')
                print("\t" + command)
                return False
            print(f'-Unzipping {database_name}')
            # unzip into tmp directory
            subprocess.check_call(f'unzip {databasePath(database_name, databases_dir)} -d {tempUnzipDirectory}', text=True, shell=True)
            # move (and rename) to correct location
            subprocess.check_call(f'cp -r {tempUnzipDirectory}/* {database_dir}', text=True, shell=True)
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

def runTSM(project_list, codeql_cli, codeql_queries, query_name, clean):
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
        fetchDatabase(database, databasesDirectory)
    # Write config.json file
    config = "{\n"
    config = config + f'"codeQLExecutable": "{codeql_cli}",\n'
    config = config + f'"codeQLSourcesRoot": "{codeql_queries}",\n'
    config = config + f'"workingDirectory": "{workingDirectory}",\n'
    config = config + f'"resultsDirectory": "{resultsDirectory}",\n'
    config = config + f'"searchPath": ".",\n' # TODO: is this redundant?
    config = config + f'"worseLibSearchPath": "{codeql_queries}",\n'
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
    subprocess.check_call(command, text=True)
    print("-Combining TSM results")
    combine_scores_path = str(Path(__file__).absolute().parent.parent / "code" / "misc" / "combinescores.py")
    # N.B. --project-dir parameter is misnamed, its value should be results-dir
    command = ["python3", combine_scores_path, "--project-dir", f'{resultsDirectory}', "--query-name", effective_query_name]
    subprocess.check_call(command, text=True)
    print(f'-Completed: final output is allscores_{effective_query_name}_avg.txt')

def main():
    parsed_arguments = parseArguments()
    runTSM(parsed_arguments.project_list, parsed_arguments.codeql_cli, parsed_arguments.codeql_queries, parsed_arguments.query_name, parsed_arguments.clean)

if __name__ == '__main__':
    main()
