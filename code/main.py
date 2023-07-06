from typing import Any, MutableMapping
import re
from pprint import pformat
import argparse
import logging
import os
import datetime

from typing import TextIO, Iterator, List
from dataclasses import dataclass

from orchestration.orchestrator import Orchestrator
from orchestration import global_config
from database.cache import DatabasesCache as ProjectDatabaseCache, NotCachedError
from utils.process import run_process
from cbc_utils.cbc_utils import EmptyModelError

logging_format = "[%(levelname)s\t%(asctime)s] %(name)s\t%(message)s"


def create_logging_file_appender():
    new_log_file = os.path.join(global_config.logs_directory,
                                f"tsm_log_{int(datetime.datetime.now().timestamp())}.log")
    file_appender = logging.FileHandler(new_log_file)
    file_appender.setFormatter(logging.Formatter(logging_format))
    file_appender.setLevel(logging.DEBUG)
    return file_appender


logging.basicConfig(level=logging.INFO, format=logging_format)

log = logging.getLogger(__name__)

# use DEBUG env var in 'true' to enable program wide debug logging
if os.getenv("DEBUG", "false") == "true":
    logging.getLogger().setLevel(logging.DEBUG)

# Add file handler to root logger
logging.getLogger().addHandler(create_logging_file_appender())

LIST_FILE_COMMENT_SYMBOL = "#"

# Parse the project list file, yielding trimmed project identifiers.


def parse_project_list(list_file: TextIO) -> Iterator[str]:
    for line in list_file.readlines():
        if line.startswith(LIST_FILE_COMMENT_SYMBOL):
            continue
        yield line.replace('\r', '').replace('\n', '')


@dataclass
class Project:
    name: str
    resolved_dir: str


def create_project_list(projectListFile, cache: ProjectDatabaseCache) -> List[Project]:
    resultingProjects = []

    with open(projectListFile) as list_file:
        for project in parse_project_list(list_file):
            if cache is None:
                raise Exception("old method deprecated. Please use dbcache")
            else:
                try:
                    parsed_key, resolved_dir = cache.get(project)
                    # use as name format the following: 'owner_repo_422f3bf2'
                    name = "%s_%s_%s" % (
                        parsed_key.gh_user, parsed_key.gh_repo, parsed_key.gh_commit_hash[0:8])
                    project = Project(name, resolved_dir)
                except NotCachedError:
                    raise

                resultingProjects.append(project)

    return resultingProjects


all_steps = "ALL"

run_separate_on_multiple_projects = True

parser = argparse.ArgumentParser()

parser.add_argument("--steps", dest="steps", type=str, default=all_steps, metavar="STEPS",
                    help="Runs all orchestrator steps in the comma-separated list STEPS")

parser.add_argument("--project-dir", dest="project_dir", required=False, type=str,
                    help="Directory of the CodeQL database")
parser.add_argument("--query-type", dest="query_type", required=True, type=str, choices=["Xss", "NoSql", "Sql", "Sel", "Path"],
                    help="Type of the query to solve")
parser.add_argument("--query-name", dest="query_name", required=True, type=str,
                    choices=["NosqlInjectionWorse", "SqlInjectionWorse",
                             "DomBasedXssWorse", "SeldonWorse", "TaintedPathWorse"],
                    help="Name of the query to solve")
parser.add_argument("--project-list", dest="projectListFile", required=False, type=str,
                    help="Run all steps on the project passed on this list")

parser.add_argument("--results-dir", dest="results_dir", required=False, type=str,
                    help="Directory where results of the analysis are placed (replaces default in config.json")

parser.add_argument("--working-dir", dest="working_dir", required=False, type=str,
                    help="Working directory (replaces default in config.json")

parser.add_argument("--kind", dest="kind", required=False, type=str, default="snk",
                    choices=["src", "snk", "san"],
                    help="Kind of spect to predict")


parser.add_argument("--scores-file", dest="scores_file", required=False, type=str,
                    help="Name of file with the scores for repr (replaces reprScores.txt")

parser.add_argument("--no-flow", dest="no_flow",
                    action='store_true', help='Ignore flow constraints')

parser.add_argument("--multiple-projects", dest="multiple",
                    action='store_true', help='Combine all projects in the model')

parser.add_argument("--solver", dest="solver", required=False, type=str, choices=["gurobi", "CBC"], default="CBC",
                    help="Specify which solver to use (default is CBC)")

# TODO: Improve naming on this
parser.add_argument("--project.cache_dir", dest="project_cache_dir", required=False, type=str,
                    help="Directory to use for the project cache. Could have already cached DBs. If this flag is configured, the " +
                    "DatabaseCache will be used for fetching project DBs.")

parser.add_argument("--progress-log", dest="progress_log", required=True, type=str,
                    help="File where to log training progress")

# Print whole global config
log.info("Global config dump:\n%s", pformat(vars(global_config)))

subparsers = parser.add_subparsers(dest="command", required=True)
run_parser = subparsers.add_parser("run")
clean_parser = subparsers.add_parser("clean")

parsed_arguments = parser.parse_args()

# handler used to track when databases start being processed, etc
# the idea is that this handler will have a filter just looking for
# enriched loglines with a dbname=name pre-prended to the actual message
tracking_handler = logging.FileHandler(
    parsed_arguments.progress_log, encoding='utf-8', delay=True)
tracking_handler.setLevel(logging.INFO)
# re-use the same formattes as above
tracking_handler.setFormatter(logging.Formatter(logging_format))

matcher = re.compile(r"dbname=.+")


def tracking_filter(record: logging.LogRecord) -> bool:
    return matcher.match(record.message) is not None


tracking_handler.addFilter(tracking_filter)

# define log adapter used to wrap any logger to add the dbname label
# when needing a logger with the dbname pre-prended, use:
# l = TrackingAdapter(logger, {'dbname': db})
# l.info ...


class TrackingAdapter(logging.LoggerAdapter):
    def process(self, msg: Any, kwargs: MutableMapping[str, Any]) -> tuple[Any, MutableMapping[str, Any]]:
        return 'dbname=%s %s' % (self.extra['dbname'], msg), kwargs


logging.getLogger().addHandler(tracking_handler)

# end of logging tracking configuration

results_dir = global_config.results_directory
working_dir = global_config.working_directory
scores_file = None
no_flow = False

if parsed_arguments.results_dir is not None:
    results_dir = os.path.normpath(parsed_arguments.results_dir)

if parsed_arguments.working_dir is not None:
    working_dir = os.path.normpath(parsed_arguments.working_dir)

if parsed_arguments.scores_file is not None:
    scores_file = parsed_arguments.scores_file

if parsed_arguments.no_flow:
    no_flow = True

log.info(f"Results folder: {results_dir}")

project_cache = None
project_cache_dir = parsed_arguments.project_cache_dir
if project_cache_dir is not None:
    # TODO: FIXME and find a way to get the CodeQL CLI version programatically
    cli_version = run_process([
        global_config.codeql_executable,
        "version -q"
    ]).stdout.rstrip("\n")
    project_cache = ProjectDatabaseCache(
        project_cache_dir, global_config.compiled_dbs_version)
    log.info("Project cache enabled with dir: %s", project_cache_dir)
else:
    project_dir = os.path.normpath(parsed_arguments.project_dir)


projectListFile = parsed_arguments.projectListFile

# Given a project list, retrieve all folders where each project CodeQL database is stored.
if parsed_arguments.projectListFile is not None:
    project_list = create_project_list(projectListFile, project_cache)
else:
    raise Exception("--project-dir is no longer supported, use file instead")

if parsed_arguments.multiple:
    run_separate_on_multiple_projects = False

# map used to count ocurrencies of events and do filtering
rep_counter = dict()


if __name__ == '__main__':
    if parsed_arguments.multiple:
        raise Exception("multiple not supported for the moment")

    if parsed_arguments.solver == "gurobi":
        raise Exception("gurobi is deprecated. Use CBC instead!")

    # preety print project list
    preety_project_list = ''
    for (i, db_path) in enumerate(project_list):
        preety_project_list += '%d\t%s\n' % (i+1, db_path.name)
    preety_project_list += '\n'
    log.info("Dumping project list for tracking purposes:\n%s",
             preety_project_list)

    for db_path in project_list:
        log.info(
            f"Running orchestrator-{parsed_arguments.command} on project: {db_path.name}")
        dblogger = TrackingAdapter(logging.getLogger(), {
                                   'dbname': db_path.name})
        dblogger.info("running pipeline")

        orchestrator = Orchestrator(db_path.resolved_dir, db_path.name,
                                    parsed_arguments.query_type,
                                    parsed_arguments.query_name,
                                    parsed_arguments.kind,
                                    working_dir, results_dir,
                                    scores_file, no_flow,
                                    run_separate_on_multiple_projects,
                                    parsed_arguments.solver,
                                    project_list,
                                    dblogger,
                                    rep_counter,
                                    )

        if parsed_arguments.command == "run":
            try:
                if parsed_arguments.steps != "":
                    steps_to_run = parsed_arguments.steps.split(",")
                    orchestrator.run_steps(steps_to_run)
                else:
                    log.warning("no --steps configured, running default steps")
                    orchestrator.run()
                # project ended successfully
                dblogger.info("run ok")

            except EmptyModelError as em:
                log.error("error solving model. Model was empty: %s",
                          em.model_path)
                dblogger.error(
                    "run ended because model was empty: %s", em.model_path)

            except Exception as err:
                log.error(f"Error running  project: {db_path.name}, {err}")
                log.exception("Fatal error occured in orchestrator execution")
                # project ended with error
                dblogger.exception("run eneded with unhandled exception")

        elif parsed_arguments.command == "clean":
            orchestrator.clean()
