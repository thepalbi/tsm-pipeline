import argparse
from .cache import DatabasesCache, NotCachedError, parse_key
from .creator import create_database
from utils.logging import get_stdout_logger
from multiprocessing import Pool

log = get_stdout_logger("cache-cli")


def do_cache_key(cache: DatabasesCache, key: str, cli_version: str):
    try:
        _, cached_db = cache.get(key)
        log.info("Cached! %s", cached_db)
    except NotCachedError:
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
    args = parser.parse_args()

    codeql_version = args.cli_version
    log.info("Using CodeQL version %s", codeql_version)
    cache = DatabasesCache(args.cache_root, codeql_version)
    # Helper function for parallel execution
    def parallel_cache(k): return do_cache_key(cache, k, codeql_version)
    if args.list is not None:
        keys = []
        with open(args.list, 'r') as f:
            for key in f.readlines():
                # Clear key from trailing newline
                key = key.rstrip('\n')
                keys.append(key)
        if args.parallel:
            log.info("Parallel execution enabled! Things going 🏎")
            with Pool(processes=2) as pool:
                # Map with thread pool
                pool.map(parallel_cache, keys)

        else:
            log.info("Sequential execution enabled... This might take a while")
            for key in keys:
                do_cache_key(cache, key, codeql_version)
    elif args.key != "":
        do_cache_key(cache, args.key, codeql_version)
    else:
        log.error("list and key cannot be both empty!")
