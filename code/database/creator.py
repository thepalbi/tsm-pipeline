from .cache import Parsedkey, DatabasesCache
import tempfile
import os
import shutil
import requests
from utils.process import run_process
from utils.clis import getenv_or_default
from utils.logging import get_stdout_logger
from clients.cli import CLIClient


class GHRepoNotExistentException(Exception):
    pass


log = get_stdout_logger("database-creator")

# quick solution to get temp filenames
temp_filenames = tempfile._get_candidate_names()
local_tmp = getenv_or_default("TSM_TMP", "/tesis/tmp")


def get_temp_filename() -> str:
    return next(temp_filenames)


def try_upgrade(path: str, cli_version: str):
    cli_client = CLIClient(version=cli_version)
    cli_client.database_upgrade(path)


def create_database(parsed_key: Parsedkey, cache: DatabasesCache, cli_version: str):
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

    cli_client = CLIClient(version=cli_version, cwd=temp_dir)
    cli_client.database_create(cached_entry_path, "javascript")

    log.info(
        "database created at [%s]", cached_entry_path)
    shutil.rmtree(temp_dir)

    return cached_entry_path
