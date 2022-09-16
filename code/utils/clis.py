from os.path import join
from .process import run_process

root_path = "/tesis/clis"


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
