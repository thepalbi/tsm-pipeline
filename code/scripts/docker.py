import docker
from docker.types import Mount
from typing import Dict, Tuple, List, Any, Optional
import re
from dataclasses import dataclass, field
import os
import logging
from .files import db_list_to_file

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
class ExperimentSettings:
    name: str
    bash_config_path: str
    results_dir: str
    query_type: str
    project_list_file: Optional[str] = None
    project_list: Optional[List[str]] = None
    tmp_dir: str = field(init=False)
    cq_wrapper_timeout: int = 600

    # after init
    docker_mounts: List[Mount] = field(init=False)
    docker_env: Dict[str, str] = field(init=False)

    def __post_init__(self):
        with open(self.bash_config_path, 'r') as f:
            cfg = parse_bash_config(f.read())
            self.tmp_dir = cfg["TMP_DIR"]

        # handle if project was supplied as list
        if self.project_list is not None:
            if self.project_list_file is not None:
                # both cannot be set
                raise Exception("cannot configure projects as list and file")
            
            self.project_list_file = db_list_to_file(self.project_list, self.tmp_dir)
        
        if self.project_list_file is None:
            raise Exception("either project_list or project_list_file need to be configures")

        self.docker_mounts, self.docker_env = mounts_and_envs(
            config=cfg,
            project_list_file=self.project_list_file,
            results_dir=self.results_dir,
            cq_wrapper_timeout=self.cq_wrapper_timeout,
        )

    @property
    def docker_kwargs(self) -> Dict[str, Any]:
        return {
            "mounts": self.docker_mounts,
            "environment": self.docker_env,
        }


def mounts_and_envs(config: Dict[str, str], project_list_file: str, results_dir: str, cq_wrapper_timeout=600) -> Tuple[List[Mount], Dict[str, str]]:
    mounts = [
        # basic mounts retrieved from the bash config
        Mount(source=config["CLI_DIR"], target="/cli", type='bind'),
        Mount(source=config["QL_LIB_DIR"], target="/ql", type='bind'),
        Mount(source=config["QL_LIB_WORSE_DIR"],
              target="/worse_lib", type='bind'),
        Mount(source=config["TMP_DIR"], target="/bigtmp", type='bind'),
        Mount(source=results_dir, target="/results", type='bind'),
        Mount(source=config["CACHE_DBS_DIR"], target="/dbs", type='bind'),
        # codeql package cache
        Mount(source=config["QL_JAVASCRIPT_UPGRADES"], target="/js_upgrades_lib", type='bind'),
        # additional mounts
        Mount(source=project_list_file, target=MOUNTED_LIST_FILE,
              read_only=True, type='bind'),
    ]
    envs = {
        "CODEQL_CLIS_ROOT": config['CODEQL_CLIS_ROOT'],
        "CODEQL_WRAPPER_TIMEOUT": cq_wrapper_timeout,
    }
    return mounts, envs


def run_tsm(client: docker.DockerClient, settings: ExperimentSettings, tail_logs=False, block=False, debug=False):
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
    log.info("running at container %s. Use `docker logs %s --tail 10 --follow` to follow progress", container.id, container.id)
    print("running at container %s. Use `docker logs %s --tail 10 --follow` to follow progress" % (container.id, container.id))
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
    combine_scores(
        query=query.name,
        results_dir=settings.results_dir,
        multiple=False,
        out_file=os.path.join(settings.results_dir, "averaged-results.txt"),
        raw_out_file=os.path.join(settings.results_dir, "averaged-results.csv"),
    )


def read_dbs_dataset(path):
    dbs = []
    with open(path, "r") as f:
        for l in f.readlines():
            dbs.append(l.rstrip())
    return dbs


if __name__ == "__main__":
    client = docker.from_env()

    with open('/tesis/repos/tsm-pipeline/code/scripts/config.sh', 'r') as f:
        config = parse_bash_config(f.read())

    mounts, env = mounts_and_envs(
        config=config,
        project_list_file='/tesis/repos/tsm-pipeline/experiments/tesis/tainted_path/test_4.txt',
        results_dir='/tmp',
    )

    run_tsm(client, mounts, env)
