import argparse
from utils.process import run_process
from utils.logging import get_stdout_logger
from os import path, mkdir
from clients.cli import CLIClient
import sys
from typing import Tuple, Optional
from database.cache import DatabasesCache
from multiprocessing import Pool
import dataclasses

log = get_stdout_logger("evaluate-cli")


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
    external_predicate_file: Optional[str] = None

@dataclasses.dataclass
class Evaluator:
    settings: EvaluationSettings
    cache_root: str
    dbs_path: str
    output_dir: str
    client: CLIClient
    db: str

    def evalute(self):
        """
        evalute evaluates and decodes the query result from a database.

        :param str db: The path to the CodeQL db. Assumes it's stored in a cache folder structure to retrieve it's name.
        """
        owner, name, sha = extract_db_info(self.db)
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
    cache_root: str,
    dbs_path: str,
    output_dir: str,
):
    create_dir(output_dir)

    # Configure codeql query run execution with 2 threads, and 6GB ram
    cli_client = CLIClient(version=settings.cli_version, query_run_args={
        "--threads": "2",
        "--ram": "6000",
    })
    cache = DatabasesCache(cache_root, settings.cli_version)
    dbs = []
    with open(dbs_path, 'r') as dbs_file:
        for db in dbs_file.readlines():
            db = db.rstrip('\n')
            _, db_dir = cache.get(db)
            dbs.append(db_dir)

    log.info("Starting processing with 4 processes")

    evaluators = [
        Evaluator(
            settings,
            cache_root,
            dbs_path,
            output_dir,
            cli_client,
            db
        ) for db in dbs
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
