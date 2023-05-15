import docker
from docker.types import Mount
from typing import Dict, Tuple, List, Any, Optional
import re
from dataclasses import dataclass, field
import os
import logging
from .files import db_list_to_file
from tsm.configuration import TSMConfigParser
import tempfile

from misc.combinescores import combine_scores

log = logging.getLogger(__name__)
log.setLevel(logging.INFO)


@dataclass(frozen=True)
class QueryNameAndType:
    name: str
    type: str


QUERY_TYPES: Dict[str, QueryNameAndType] = {
    'nosql': QueryNameAndType(
        type='NoSql',
        name='NosqlInjectionWorse'
    ),
    'xss': QueryNameAndType(
        type='Xss',
        name='DomBasedXssWorse',
    ),
    'sql': QueryNameAndType(
        type='Sql',
        name='SqlInjectionWorse',
    ),
    # todo(pablo): what's this? delete please
    'sel': QueryNameAndType(
        type='Sel',
        name='SeldonWorse',
    ),
    'path': QueryNameAndType(
        type='Path',
        name='TaintedPathWorse'
    )
}


def parse_bash_config(raw: str) -> Dict[str, str]:
    """
    # Directory where the CodeQL CLI binary is located
    export CLI_DIR=/tesis/clis/codeqlcli-v2.5.2
    """
    config = {}
    for line in raw.splitlines():
        # first ignore bash comments
        if line.startswith("#"):
            continue
        # parse variable exports
        result = re.fullmatch(r'^export\s([A-Z][A-Z0-9_]*)=(.+)$', line)
        if result is None or len(result.groups()) != 2:
            # ignore errors
            continue
        g = result.groups()
        config[g[0]] = g[1]
    return config


MOUNTED_LIST_FILE = '/data/list.txt'

# cq stands for CodeQL


@dataclass()
class TrainConfiguration:
    config: TSMConfigParser
    query_type: str
    results_dir: str
    project_list: List[str]

    # after init
    project_list_file: str = field(init=False)
    tmp_dir: str = field(init=False)
    docker_mounts: List[Mount] = field(init=False)
    docker_env: Dict[str, str] = field(init=False)

    def __post_init__(self):
        # handle if project was supplied as list
        if self.project_list is not None:
            self.project_list_file = db_list_to_file(
                self.project_list, tempfile.gettempdir())

        self.docker_mounts, self.docker_env = mounts_and_envs(
            config=self.config,
            project_list_file=self.project_list_file,
            results_dir=self.results_dir,
        )

        self.tmp_dir = self.config.get("global", "tmp_dir")

    @property
    def docker_kwargs(self) -> Dict[str, Any]:
        return {
            "mounts": self.docker_mounts,
            "environment": self.docker_env,
        }


def mounts_and_envs(config: TSMConfigParser, project_list_file: str, results_dir: str) -> Tuple[List[Mount], Dict[str, str]]:
    mounts = [
        # basic mounts retrieved from the bash config
        Mount(source=config.get("global", "training_cli_dir"),
              target="/cli", type='bind'),
        Mount(source=config.get("global", "lib_tsm"), target="/ql", type='bind'),
        Mount(source=config.get("global", "lib_worse"),
              target="/worse_lib", type='bind'),
        Mount(source=config.get("global", "tmp_dir"),
              target="/bigtmp", type='bind'),
        Mount(source=results_dir, target="/results", type='bind'),
        Mount(source=config.get("global", "db_cache_dir"),
              target="/dbs", type='bind'),
        # codeql package cache
        Mount(source=config.get("global", "javascript_upgrades"),
              target="/js_upgrades_lib", type='bind'),
        # additional mounts
        Mount(source=project_list_file, target=MOUNTED_LIST_FILE,
              read_only=True, type='bind'),
    ]
    # training performance could be overriden, get those settings and prefer them
    training_performance = config.get_performance("training")
    envs = {
        "CODEQL_CLIS_ROOT": config.get("global", "codeql_clis_dir"),
        "CODEQL_WRAPPER_TIMEOUT": config.get("global", "codeql_timeout"),
        "PERF_PARALLELISM": training_performance.parallelism,
        "PERF_CODEQL_THREADS": training_performance.codeql_threads,
        "PERF_CODEQL_MEMORY": training_performance.codeql_memory,
    }
    return mounts, envs


def run_tsm(client: docker.DockerClient, settings: TrainConfiguration, tail_logs=False, block=False, debug=False):
    # prerequisites
    # create results and logs folder if necessary
    def create_dir(dir: str):
        try:
            log.info("creating %s dir. Omitting error if already existing", dir)
            os.mkdir(dir)
        except FileExistsError:
            pass

    create_dir(settings.results_dir)
    create_dir(os.path.join(settings.tmp_dir, "log"))

    query = QUERY_TYPES[settings.query_type]
    container_cmds = [
        "--steps=generate_entities,generate_model,optimize",
        "--project.cache_dir=/dbs",
        "--project-list=%s" % (MOUNTED_LIST_FILE),
        "--query-type=%s" % (query.type),
        "--query-name=%s" % (query.name),
        "--solver=CBC",
        "--progress-log=/results/training_log.txt",
        "run"
    ]

    # if debug patch environment, this will enable debug logging
    if debug:
        log.warning("enabling debug mode in tsm")
        settings.docker_env["DEBUG"] = "true"

    container = client.containers.run(
        image="github.com/thepalbi/tsm-main:latest",
        command=container_cmds,
        detach=True,
        **settings.docker_kwargs
    )
    log.info("running at container %s. Use `docker logs %s --tail 10 --follow` to follow progress",
             container.id, container.id)
    if block:
        container.wait()
    elif tail_logs:
        import sys
        for l in container.logs(
            stdout=True,
            stderr=True,
            stream=True,
        ):
            # pipe output directly to stdout, rather than print
            sys.stdout.write(l.decode('utf-8'))
    else:
        log.info("not blocking, please to run combine scores after")
        return

    log.info("running combine scores")
    run_combine_scores(settings)


def run_combine_scores(settings: TrainConfiguration):
    """
    run_combine_scores executes the combine scores post process for the given ExperimentSettings.

    :param ExperimentSettings settings: the settings
    """
    combine_scores(
        results_dir=settings.results_dir,
        multiple=False,
        out_file=os.path.join(settings.results_dir, "averaged-results.txt"),
        raw_out_file=os.path.join(
            settings.results_dir, "averaged-results.csv"),
    )


def read_dbs_dataset(path: str) -> List[str]:
    """
    read_dbs_dataset reads a file-based dataset into a list

    :param str path: the dataset file path
    :return List[str]: the read dataset into a list of DB keys
    """
    dbs = []
    with open(path, "r") as f:
        for l in f.readlines():
            dbs.append(l.rstrip())
    return dbs
