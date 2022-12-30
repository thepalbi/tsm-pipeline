import docker
from docker.types import Mount


from typing import Dict, Tuple, List
import re


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
O11Y_CONTAINDER_DB_DIR = '/data/tracking.db'

# cq stands for CodeQL


def mounts_and_envs(config: Dict[str, str], project_list_file: str, results_dir: str, o11y_db_dir: str, cq_wrapper_timeout=600) -> Tuple[List[Mount], Dict[str, str]]:
    mounts = [
        # basic mounts retrieved from the bash config
        Mount(source=config["CLI_DIR"], target="/cli"),
        Mount(source=config["QL_LIB_DIR"], target="/ql"),
        Mount(source=config["QL_LIB_WORSE_DIR"], target="/worse_lib"),
        Mount(source=config["TMP_DIR"], target="/bigtmp"),
        Mount(source=results_dir, target="/results"),
        Mount(source=config["CACHE_DBS_DIR"], target="/dbs"),
        # additional mounts
        Mount(source=project_list_file, target=MOUNTED_LIST_FILE, read_only=True),
        Mount(source=o11y_db_dir, target=O11Y_CONTAINDER_DB_DIR)
    ]
    envs = {
        "CODEQL_CLIS_ROOT": config['CODEQL_CLIS_ROOT'],
        "CODEQL_WRAPPER_TIMEOUT": cq_wrapper_timeout,
    }
    return mounts, envs


if __name__ == "__main__":
    client = docker.from_env()

    with open('/tesis/repos/tsm-pipeline/code/scripts/config.sh', 'r') as f:
        config = parse_bash_config(f.read())

    mounts, env = mounts_and_envs(
        config=config,
        project_list_file='/tesis/repos/tsm-pipeline/experiments/tesis/tainted_path/test_4.txt',
        results_dir='/tmp',
        o11y_db_dir='/tesis/repos/tsm-pipeline/code/tsm.db',
    )

    container = client.containers.run(
        image="python:3.10.5-bullseye",
        command="echo hello world",
        detach=True,
        mounts=mounts,
        environment=env,
    )
    container.wait()
    print(container.logs(stdout=True))
    print("done")
