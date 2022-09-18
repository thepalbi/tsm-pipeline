import argparse
from utils.process import run_process
from utils.logging import get_stdout_logger
from os import path
from clients.cli import CLIClient
import sys
from typing import Tuple, List
from database.cache import DatabasesCache

log = get_stdout_logger("evaluate-cli")


def extract_db_info(db: str) -> Tuple[str, str, str]:
    if db[-1] == "/":
        db = db[:-1]
    spllited_db_path = db.split("/")
    if len(spllited_db_path) < 3:
        raise Exception("Failed to extract naming from db path: %s" % (db))
    owner, name, sha = spllited_db_path[-3], spllited_db_path[-2], spllited_db_path[-1]
    return owner, name, sha


if __name__ == "__main__":
    args = argparse.ArgumentParser()
    args.add_argument(
        '--codeql-source',
        choices=['worse', 'v0'],
        dest='sources',
        required=True
    )
    args.add_argument(
        '--dbs',
        type=str,
        required=True,
        help='File with db keys to evaluate'
    )
    args.add_argument(
        '--cache-root',
        dest='cache_root',
        type=str,
        required=True,
        help='DBs cache root dir'
    )
    args.add_argument(
        '--output',
        type=str,
        required=True,
        help='Output folder where to saved proccessed results',
    )
    pa = args.parse_args()

    root_dir = run_process('git rev-parse --show-toplevel').stdout.rstrip('\n')
    log.info("Root dir configured to: %s" % (root_dir))

    if not path.isdir(pa.output):
        log.error("--output should be a directory")
        sys.exit(1)

    search_path = ''
    # TODO: The below just works for tainted path
    if pa.sources == 'worse':
        search_path = path.join(root_dir, 'lib-worse/codeql')
        query_file = 'tsm-atm-pipeline/src/tsm/evaluation/TaintedPathWorseTSM.ql'
        cli_version = '2.5.2'
    else:
        search_path = '/tesis/v0/javascript/ql/lib'
        query_file = 'tsm-evaluation/tsm-evaluation/src/PathEvaluation.ql'
        cli_version = '2.10.5'

    # Configure codeql query run execution with 2 threads, and 6GB ram
    cli_client = CLIClient(version=cli_version, query_run_args={
        "--threads": "2",
        "--ram": "6000",
    })
    query_file = path.join(root_dir, query_file)

    cache = DatabasesCache(pa.cache_root, cli_client.version)
    dbs = []
    with open(pa.dbs, 'r') as dbs_file:
        for db in dbs_file.readlines():
            db = db.rstrip('\n')
            _, db_dir = cache.get(db)
            dbs.append(db_dir)

    def do_evaluate_db(db: str):
        """
        do_evaluate_db evaluates and decodes the query result from a database.

        :param str db: The path to the CodeQL db. Assumes it's stored in a cache folder structure to retrieve it's name.
        """
        owner, name, sha = extract_db_info(db)
        log.info("Evaluating %s - %s" % (owner, name))
        bqrs_out = path.join(pa.output, "%s_%s_%s.bqrs" % (owner, name, sha))
        csv_out = path.join(pa.output, "%s_%s_%s.csv" % (owner, name, sha))
        cli_client.query_run(db, search_path, bqrs_out, query_file)
        cli_client.bqrs_decode(bqrs_out, "#select", csv_out)

    for db in dbs:
        do_evaluate_db(db)
