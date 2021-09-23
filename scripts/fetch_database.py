#! /usr/bin/env python3

import argparse
import os
import requests
import shutil
import subprocess
import tempfile

def parseArguments():
    parser = argparse.ArgumentParser()
    parser.add_argument("dest", help="The directory to download project databases to; will be created if it doesn't exist.")
    parser.add_argument("projects", metavar="project", nargs="+", help="Projects whose databases we want to download.")
    parser.add_argument("query", help="Query type from which the db belongs")
    parsed_arguments = parser.parse_args()
    return parsed_arguments

def clean(project_name):
  return project_name.replace("/", "_")

def database_archive(project_name, dest_dir):
  return os.path.join(f'{dest_dir}', f'{clean(project_name)}.zip')

def database_dir(project_name, dest_dir):
  return os.path.join(f'{dest_dir}', f'{clean(project_name)}')

def queryToFolder(query):
  if query == "NoSql":
      return "nosql_800"
  if query == "Sql":
      return "sql_96"
  if query == "TaintedPath":
      return "tainted_path_500"
  if query == "Xss":
      return "xss_3k"
  # for other cases we fallback to the folder that hipotically contains all dbs
  return "all"

def fetchDatabaseCommand(project_name, dest_dir, query):
    database_path = database_archive(project_name, dest_dir)
    # check whether project_name looks like an LGTM slug
    if "/" in project_name:
        print(f'Downloading {project_name} from LGTM.com')
        lgtm_url = f'https://lgtm.com/api/v1.0/projects/{project_name}'
        # send GET request to lgtm_url and get response as json
        response = requests.get(lgtm_url)
        response.raise_for_status()
        # get project id from the json response
        project_id = response.json()['id']
        command = (
            f'curl -X GET -L "https://lgtm.com/api/v1.0/snapshots/{project_id}/javascript" '
            f'-o {database_path}'
        )
    else:
        print(f'Downloading {project_name} from Azure blob storage')
        database_zip = project_name + ".zip"
        dbFolder = queryToFolder(query)
        command = (
            f'azcopy copy "https://atmcodeqldata.blob.core.windows.net/atm/javascript-databases/{dbFolder}/{database_zip}?${{ATM_BLOB_STORE_SAS_TOKEN}}" '
            f'{database_path} --overwrite=true '
            f'--check-md5 FailIfDifferent --from-to=BlobLocal --recursive'
        )
    return command

def fetchDatabase(project_name, dest_dir, query):
    dir = database_dir(project_name, dest_dir)
    archive = database_archive(project_name, dest_dir)
    # Conditionally fetch the database
    if not os.path.exists(dir):
        '''
        We need to ensure that the unzip folder name is the same as the zipped folder name.
        We can't guarantee this, so we unzip to a clean temporary directory first before
        copying the unzipped contents to their final location with a correct name
        '''
        temp_dir = tempfile.mkdtemp()
        # Fetch from Azure blob store or LGTM
        command = fetchDatabaseCommand(project_name, dest_dir, query)
        try:
            print(f'Fetching {project_name} using command: {command}')
            subprocess.run(command, check=True, text=True, shell=True, capture_output=True)
            if not os.path.exists(archive):
                print(f'Failed to fetch {project_name}')
                return False

            print(f'Unzipping {project_name}')
            # unzip into tmp directory
            shutil.unpack_archive(archive, temp_dir)
            contents = os.listdir(temp_dir)
            if len(contents) != 1 or not os.path.isdir(os.path.join(temp_dir, contents[0])):
              raise Exception(f'Archive for {project_name} should contain exactly one directory.')

            # the tmp directory now contains a single subdirectory; move it to the final location
            shutil.move(os.path.join(temp_dir, contents[0]), dir)

            # databases downloaded from LGTM have their source archive zipped, databases from Azure blob store don't
            # to simplify downstream handling we always zip the archive
            src_archive_dir = os.path.join(dir, 'src')
            if not os.path.exists(os.path.join(dir, 'src.zip')) and os.path.isdir(src_archive_dir):
                print(f'Zipping source archive for {project_name}')
                shutil.make_archive(os.path.join(dir, 'src'), 'zip', src_archive_dir)
                shutil.rmtree(src_archive_dir)
        except subprocess.CalledProcessError as e:
            print(f'Command {e.cmd} failed with return code {e.returncode}: {e.stderr}')
            return False
        finally:
            shutil.rmtree(temp_dir)
            if os.path.exists(archive):
              os.remove(archive)
        return True
    else:
        print(f'Skipping fetch because {project_name} exists')
    return True

if __name__ == "__main__":
  args = parseArguments()
  if not os.path.exists(args.dest):
    os.mkdir(args.dest)
  for project in args.projects:
    fetchDatabase(project, args.dest, args.query)
