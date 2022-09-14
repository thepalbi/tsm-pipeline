from orchestration import global_config
from .cache import Parsedkey, DatabasesCache
import subprocess
import logging
import tempfile
import os
import sys
import shutil
import requests
from utils.process import run_process, RunProcessError


class GHRepoNotExistentException(Exception):
    pass


log = logging.getLogger("database-creator")
log.addHandler(logging.StreamHandler(sys.stdout))
log.setLevel(logging.INFO)

# quick solution to get temp filenames
temp_filenames = tempfile._get_candidate_names()
# TODO: add this in config.json
local_tmp = "/tesis/tmp"


def get_temp_filename() -> str:
    return next(temp_filenames)


def create_database(parsed_key: Parsedkey, cache: DatabasesCache):
    # Check if database exists
    res = requests.get("https://github.com/%s/%s" %
                       (parsed_key.gh_user, parsed_key.gh_repo))
    if res.status_code == 404:
        raise GHRepoNotExistentException()

    # clone repository
    # https://github.com/github/codeql-cli-binaries.git
    temp_dir = os.path.join(local_tmp, get_temp_filename())
    clone_commands = [
        "git",
        "clone",
        "https://github.com/%s/%s.git" % (parsed_key.gh_user,
                                          parsed_key.gh_repo),
        temp_dir
    ]
    run_process(clone_commands)

    # checkout commit
    checkout_commands = ["git", "checkout", parsed_key.gh_commit_hash]
    run_process(checkout_commands, cwd=temp_dir)

    # create parent cache entry dir
    os.makedirs(parsed_key.get_parent_path(cache.root_dir), exist_ok=True)

    # create database in cached directory
    cached_entry_path = parsed_key.get_path(cache.root_dir)
    create_commands = [
        # TODO: Maybe this shouldn't depend of this global_config
        global_config.codeql_executable,
        "database",
        "create",
        cached_entry_path,
        # Parameterize this
        # Are this CodeQL sources used for creating the database correct?
        "--search-path=/tesis/ts-js-diego/ql:/tesis/ts-js-diego/lib-worse/codeql/javascript/ql",
        "--language=javascript"
    ]
    run_process(create_commands, cwd=temp_dir)

    log.info(
        "database created at [%s]", cached_entry_path)
    shutil.rmtree(temp_dir)

    return cached_entry_path


def get_codeql_version() -> str:
    proc = run_process("%s version --quiet" %
                       (global_config.codeql_executable))
    return proc.stdout
