import argparse
from .cache import DatabasesCache, NotCachedError, parse_key
from .creator import create_database, get_codeql_version
import logging

log = logging.getLogger("cache-cli")

def do_cache_key(cache: DatabasesCache, key: str):
    try:
        _, cached_db = cache.get(key)
        log.info("Cached! %s", cached_db)
    except NotCachedError:
        log.info("Not cached, creating db")
        parsed_key = parse_key(key)
        caching_dir = create_database(parsed_key, cache)
        log.info("Created! %s", caching_dir)


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument(
        "--list", help="File list from where to read keys to cache.", required=False, type=str)
    parser.add_argument(
        "--key", help="Key of the database to create", required=False, type=str)
    parser.add_argument("--cache-root", dest="cache_root",
                        help="Cache root dir", required=True, type=str)
    args = parser.parse_args()

    codeql_version = get_codeql_version().rstrip('\n')
    log.info("Using CodeQL version %s", codeql_version)
    cache = DatabasesCache(args.cache_root, codeql_version)
    if args.list is not None:
        with open(args.list, 'r') as f:
            for key in f.readlines():
                # Clear key from trailing newline
                key = key.rstrip('\n')
                do_cache_key(cache, key)
    elif args.key != "":
        do_cache_key(cache, args.key)
    else:
        log.error("list and key cannot be both empty!")
