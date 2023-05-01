import argparse
from utils.process import run_process
from utils.logging import get_stdout_logger
from os import path, mkdir
from clients.cli import CLIClient
import sys
from typing import Tuple, Optional, List
from database.cache import DatabasesCache, Parsedkey
from multiprocessing import Pool
import dataclasses
from .files import db_list_to_file
import logging


log = logging.getLogger(__name__)


def create_dir(dir: str):
    try:
        log.info("creating %s dir. Omitting error if already existing", dir)
        mkdir(dir)
    except FileExistsError:
        pass


@dataclasses.dataclass
class EvaluationSettings:
    search_path: str
    query_file: str
    cli_version: str
    cache_root: str
    external_predicate_file: Optional[str] = None

@dataclasses.dataclass
class Evaluator:
    settings: EvaluationSettings
    output_dir: str
    client: CLIClient
    db: str
    parsed_key: Parsedkey

    def evalute(self):
        """
        evalute evaluates and decodes the query result from a database.

        :param str db: The path to the CodeQL db. Assumes it's stored in a cache folder structure to retrieve it's name.
        """
        owner, name, sha = self.parsed_key.gh_user, self.parsed_key.gh_repo, self.parsed_key.gh_commit_hash
        log.info("Evaluating %s - %s" % (owner, name))
        bqrs_out = path.join(self.output_dir, "%s_%s_%s.bqrs" % (owner, name, sha))
        csv_out = path.join(self.output_dir, "%s_%s_%s.csv" % (owner, name, sha))
        external_preds = {}
        if self.settings.external_predicate_file != None:
            external_preds = {
                "getReprScore": self.settings.external_predicate_file
            }
        self.client.query_run(self.db, self.settings.search_path, bqrs_out,
                             self.settings.query_file, external_predicates=external_preds)
        self.client.bqrs_decode(bqrs_out, "#select", csv_out)

def do_evalute(e: Evaluator):
    e.evalute()

def evaluate(
    settings: EvaluationSettings,
    output_dir: str,
    dbs_path: Optional[str] = None,
    dbs: Optional[List[str]] = None,
):
    if dbs is None and dbs_path is None:
        raise Exception('dbs_path and dbs cannot be None')

    create_dir(output_dir)

    # Configure codeql query run execution with 2 threads, and 6GB ram
    cli_client = CLIClient(version=settings.cli_version, query_run_args={
        "--threads": "2",
        "--ram": "4000",
    })
    cache = DatabasesCache(settings.cache_root, settings.cli_version)

    # if dbs paras is not passed, get those from dbs_path file
    if dbs is None:
        dbs = []
        with open(dbs_path, 'r') as f:
            for db in f.readlines():
                db = db.rstrip('\n')
                dbs.append(db)

    # use the cache to get the directories where each compiled db is located
    dbs_from_cache = []
    for db in dbs:
        parsed_key, db_dir = cache.get(db)
        dbs_from_cache.append((parsed_key, db_dir))

    log.info("Starting processing with 4 processes")

    evaluators = [
        Evaluator(
            settings,
            output_dir,
            cli_client,
            db,
            pk,
        ) for (pk, db) in dbs_from_cache
    ]
    with Pool(processes=4) as pool:
        pool.map(do_evalute, evaluators)


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
        '--boost-results',
        type=str,
        dest='boost_results',
        required=False
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

    if pa.sources == 'worse':
        settings = EvaluationSettings(
            search_path=path.join(root_dir, 'lib-worse/codeql'),
            query_file=path.join(
                root_dir, 'tsm-atm-pipeline/src/tsm/evaluation/TaintedPathWorseTSM.ql'),
            cli_version='2.5.2',
            external_predicate_file=pa.boost_results,
        )
    else:
        settings = EvaluationSettings(
            search_path='/tesis/v0/javascript/ql/lib',
            query_file='tsm-evaluation/tsm-evaluation/src/PathEvaluation.ql',
            cli_version='2.10.5',
        )

    evaluate(
        settings=settings,
        cache_root=pa.cache_root,
        dbs_path=pa.dbs,
        output_dir=pa.output,
    )
