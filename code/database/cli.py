import argparse
from .cache import DatabasesCache
from .creator import create_database
import logging
import sys

log = logging.getLogger("db-creator-cli")
log.addHandler(logging.StreamHandler(sys.stdout))
log.setLevel(logging.INFO)

if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument(
        "--key", help="Key of the database to create", required=True, type=str)
    parser.add_argument("--cache-root", dest="cache_root",
                        help="Cache root dir", required=True, type=str)
    args = parser.parse_args()

    cache = DatabasesCache(args.cache_root, "2.5.2")
    parsed_key, cached_db = cache.get(args.key)
    if cached_db is None:
        log.info("Not cached, creating db")
        # the second arg of this API sounds funny, change it
        create_database(parsed_key, cache)
        log.info("Created! %s", parsed_key.get_path(cache.root_dir))
    else:
        log.info("Cached! %s", parsed_key.get_path(cache.root_dir))
