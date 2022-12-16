import argparse

from .cache import DatabasesCache, NotCachedError, parse_key
from .creator import create_database, try_upgrade
from utils.logging import get_stdout_logger
from multiprocessing import Pool
from os import path as lpath

log = get_stdout_logger("cache-cli")

def database_is_completed(path: str):
    try:
        f = open(lpath.join(path, 'codeql-database.yml'), 'r')
        text = f.read()
        return not 'inProgress' in text
    except Exception as e:
        log.warning('Error checking if database %s is completed: %s', path, e)
        return False


def do_cache_key(cache: DatabasesCache, key: str, cli_version: str, just_check: bool):
    try:
        _, cached_db = cache.get(key)
        # check if the database is ok by trying to upgrade it
        if database_is_completed(cached_db):
            # Only display the cached message when not checking
            if not just_check:
                log.info("Cached! %s", cached_db)
        else:
            # database was not compiled succesfully, check?
            log.warning("Database at %s was not compiled successfully", cached_db)
            # try_upgrade(cached_db, cli_version)
    except NotCachedError:
        if just_check:
            log.info("Not cached!")
        else:
            log.info("Not cached, creating db %s", key)
            parsed_key = parse_key(key)
            caching_dir = create_database(parsed_key, cache, cli_version)
            log.info("Created! %s", caching_dir)


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument(
        "--list", help="File containing a list from where to read keys to cache.", required=False, type=str)
    parser.add_argument(
        "--key", help="Key of the database to create", required=False, type=str)
    parser.add_argument("--cache-root", dest="cache_root",
                        help="Cache root dir", required=True, type=str)
    parser.add_argument(
        "--cli-version", help="CodeQL CLI version to use", required=False, type=str, dest="cli_version", default="2.5.2")
    parser.add_argument(
        "--parallel", help="Download dbs in parallel", required=False, type=bool, dest="parallel", action=argparse.BooleanOptionalAction)
    parser.add_argument(
        "--thread-count", help="If parallel enabled, number of threads that the work is pooled on.", required=False, type=int, dest="threads", default=2)
    parser.add_argument(
        "--check", help="If enabled, just check if each database is present or healthy. NOTE THAT THIS WILL JUST DISLAY FAILURES.", required=False, type=bool, dest="just_check", default=False, action=argparse.BooleanOptionalAction)
    args = parser.parse_args()

    codeql_version = args.cli_version
    log.info("Using CodeQL version %s", codeql_version)
    cache = DatabasesCache(args.cache_root, codeql_version)
    # Helper function for parallel execution
    def parallel_cache(k): return do_cache_key(cache, k, codeql_version, args.just_check)
    if args.list is not None:
        keys = []
        with open(args.list, 'r') as f:
            for key in f.readlines():
                # Clear key from trailing newline
                key = key.rstrip('\n')
                keys.append(key)
        if args.parallel:
            log.info("Parallel execution enabled! Things going 🏎")
            with Pool(processes=args.threads) as pool:
                # Map with thread pool
                pool.map(parallel_cache, keys)

        else:
            log.info("Sequential execution enabled... This might take a while")
            for key in keys:
                do_cache_key(cache, key, codeql_version, args.just_check)
    elif args.key != "":
        do_cache_key(cache, args.key, codeql_version, args.just_check)
    else:
        log.error("list and key cannot be both empty!")
