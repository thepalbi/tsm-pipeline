from os.path import join
import os
from .process import run_process
from .logging import get_stdout_logger


def getenv_or_default(key: str, default: str):
    try:
        return os.environ[key]
    except Exception:
        get_stdout_logger("loader").warn(
            "envvar under name %s not found, using default instead.", key)
        return default


root_path = getenv_or_default("CODEQL_CLIS_ROOT", "/tesis/clis")


def resolve_codeqlcli_path(version: str) -> str:
    """
    resolve_codeqlcli_path retrieves the CodeQL CLI path, given a version with the following format:
    `<CodeQL CLI semver version>`

    :param str version: <semver version>
    :return str: The path to the CodeQL CLI binary
    """
    path = join(root_path, "codeqlcli-v%s" % (version), 'codeql')
    # test path
    if run_process([path, 'version -q']).stdout.rstrip('\n') != version:
        raise Exception('Wrong CodeQL CLI found')
    return path
