import argparse
import logging
import os
import glob
import datetime

from typing import TextIO, Iterator

from orchestration.orchestrator import Orchestrator
from orchestration import global_config
from database.cache import DatabasesCache as ProjectDatabaseCache, NotCachedError
from utils.process import run_process

logging_format = "[%(levelname)s\t%(asctime)s] %(name)s\t%(message)s"

def create_logging_file_appender():
    new_log_file = os.path.join(global_config.logs_directory, f"tsm_log_{int(datetime.datetime.now().timestamp())}.log")
    file_appender = logging.FileHandler(new_log_file)
    file_appender.setFormatter(logging.Formatter(logging_format))
    file_appender.setLevel(logging.DEBUG)
    return file_appender

logging.basicConfig(level=logging.INFO, format=logging_format)

# Add file handler to root logger
logging.getLogger().addHandler(create_logging_file_appender())

LIST_FILE_COMMENT_SYMBOL = "#"

# Parse the project list file, yielding trimmed project identifiers.
def parse_project_list(list_file: TextIO) -> Iterator[str]:
    for line in list_file.readlines():
        if line.startswith(LIST_FILE_COMMENT_SYMBOL):
            continue
        yield line.replace('\r', '').replace('\n', '')


def create_project_list(projectListFile, cache: ProjectDatabaseCache):
    resultingProjects = [] 

    with open(projectListFile) as list_file:
        for project in parse_project_list(list_file):
            if cache is None:
                # Find project the old way, without using the project cache
                logging.info(f"Project name: {project}")
                projectPrefix =  os.path.join(project_dir, project.replace("/","_"))
                logging.info(f"Prefix: {projectPrefix}")
                ## To-do: improve. The project list could be a list of projec names or project folders
                # I'd better to include a cmd line option
                if("/" in project):
                    projectCandidate = glob.glob(projectPrefix+"*", recursive=True)
                else:
                    projectCandidate = glob.glob(projectPrefix, recursive=True)
                    
                if len(projectCandidate)>0:
                    candidate = projectCandidate[0]
                    logging.info("Project candidate: %s", candidate)
                    resultingProjects.append(candidate)
            else:
                try:
                    _, resolved_dir = cache.get(project)
                except NotCachedError:
                    raise

                resultingProjects.append(resolved_dir)

    return resultingProjects

all_steps = "ALL"

run_separate_on_multiple_projects = True

parser = argparse.ArgumentParser()

parser.add_argument("--single-step", dest="single_step", type=str, default=all_steps, metavar="STEP",
                    help="DEPRECATED. USE --steps. Runs a single step of the orchestrator named STEP")

parser.add_argument("--steps", dest="steps", type=str, default=all_steps, metavar="STEPS",
                    help="Runs all orchestrator steps in the comma-separated list STEPS")

parser.add_argument("--project-dir", dest="project_dir", required=False, type=str,
                    help="Directory of the CodeQL database")
parser.add_argument("--query-type", dest="query_type", required=True, type=str, choices=["Xss", "NoSql", "Sql", "Sel", "Path"],
                    help="Type of the query to solve")
parser.add_argument("--query-name", dest="query_name", required=True, type=str,
                    choices=["NosqlInjectionWorse", "SqlInjectionWorse", "DomBasedXssWorse", "SeldonWorse", "TaintedPathWorse"],
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

parser.add_argument("--no-flow", dest="no_flow", action='store_true', help='Ignore flow constraints')

parser.add_argument("--multiple-projects", dest="multiple", action='store_true', help='Combine all projects in the model')

parser.add_argument("--solver", dest="solver", required=False, type=str, choices=["gurobi", "CBC"], default="CBC", 
                    help="Specify which solver to use (default is CBC)")

# TODO: Improve naming on this
parser.add_argument("--project.cache_dir", dest="project_cache_dir", required=False, type=str,
                    help="Directory to use for the project cache. Could have already cached DBs. If this flag is configured, the " +
                    "DatabaseCache will be used for fetching project DBs.")

parser.add_argument("--progress-log", dest="progress_log", required=True, type=str,
                    help="File where to log training progress")

# Print whole global config
from pprint import pformat
logging.info("Global config dump:\n%s", pformat(vars(global_config)))

subparsers = parser.add_subparsers(dest="command", required=True)
run_parser = subparsers.add_parser("run")
clean_parser = subparsers.add_parser("clean")

parsed_arguments = parser.parse_args()

# handler used to track when databases start being processed, etc
# the idea is that this handler will have a filter just looking for 
# enriched loglines with a dbname=name pre-prended to the actual message
tracking_handler = logging.FileHandler(parsed_arguments.progress_log, encoding='utf-8', delay=True)
tracking_handler.setLevel(logging.INFO)
# re-use the same formattes as above
tracking_handler.setFormatter(logging.Formatter(logging_format))

import re
matcher = re.compile(r"dbname=.+")
def tracking_filter(record: logging.LogRecord)->bool:
    return matcher.match(record.message) is not None

tracking_handler.addFilter(tracking_filter)
from typing import Any, MutableMapping

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

logging.info(f"Results folder: {results_dir}")

project_cache = None
project_cache_dir = parsed_arguments.project_cache_dir
if project_cache_dir is not None:
    # TODO: FIXME and find a way to get the CodeQL CLI version programatically
    cli_version = run_process([
        global_config.codeql_executable,
        "version -q"
    ]).stdout.rstrip("\n")
    project_cache = ProjectDatabaseCache(project_cache_dir, cli_version)
    logging.info("Project cache enabled with dir: %s", project_cache_dir)
else:
    project_dir = os.path.normpath(parsed_arguments.project_dir)


projectListFile = parsed_arguments.projectListFile

# Given a project list, retrieve all folders where each project CodeQL database is stored.
if parsed_arguments.projectListFile is not None:
    projectList = create_project_list(projectListFile, project_cache)
else:
    projectList = [project_dir]

if parsed_arguments.multiple:
    run_separate_on_multiple_projects = False

# map used to count ocurrencies of events and do filtering
rep_counter = dict()


if __name__ == '__main__':
    all_projects = projectList
    if parsed_arguments.multiple:
        all_projects = [projectList[0]]

    hasExecuted = False

    if parsed_arguments.solver == "gurobi":
        raise Exception("gurobi is deprecated. Use CBC instead!")

    # preety print project list
    preety_project_list = ''
    for (i,project) in enumerate(all_projects):
        preety_project_list += '%d\t%s\n' % (i+1, project)
    preety_project_list += '\n'
    logging.info("Dumping project list for tracking purposes:\n%s", preety_project_list)

    for project in all_projects:       
        logging.info(f"Running orchestrator-{parsed_arguments.command} on project: {project}")
        dblogger = TrackingAdapter(logging.getLogger(), {'dbname': project})
        dblogger.info("running pipeline")

        project_name = os.path.basename(project)
        # TODO: Fix poject name, which is just becoming here the project db hash
        orchestrator = Orchestrator(project, project_name, 
                            parsed_arguments.query_type,
                            parsed_arguments.query_name, 
                            parsed_arguments.kind, 
                            working_dir, results_dir,
                            scores_file, no_flow,
                            run_separate_on_multiple_projects,
                            parsed_arguments.solver,
                            projectList, 
                            rep_counter, 
                            hasExecuted) 

        if parsed_arguments.command == "run":
            try:
                if parsed_arguments.steps != "":
                    # This should be the new `--steps` argument. --single-step should be deprecated
                    steps_to_run = parsed_arguments.steps.split(",")
                    orchestrator.run_steps(steps_to_run)
                elif parsed_arguments.single_step == all_steps:
                    orchestrator.run()
                else:
                    orchestrator.run_step(parsed_arguments.single_step)
                hasExecuted = True
                # project ended successfully
                dblogger.info("run ok")
            except Exception as inst:
                logging.error(f"Error running  project: {project}, {inst}")
                logging.exception("Fatal error occured in orchestrator execution")
                # project ended with error
                dblogger.exception("run eneded with exception")

        elif parsed_arguments.command == "clean":
            orchestrator.clean()