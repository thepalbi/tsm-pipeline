import subprocess
import logging
from typing import Union, List


log = logging.getLogger("process")


class RunProcessError(Exception):
    def __init__(self, message: str, cmd: str, stdout: str, stderr: str):
        super().__init__(message)
        self.cmd = cmd
        self.stdout = stdout
        self.stderr = stderr


def run_process(command_and_arguments: Union[List[str], str], cwd=None):
    # Since we call subprocess with shell=True we need the command to be a single string
    if isinstance(command_and_arguments, list):
        command_and_arguments = [" ".join(command_and_arguments)]
    log.debug("command issued: %s",
              " ".join(command_and_arguments))
    try:
        proc = subprocess.run(
            command_and_arguments, capture_output=True, shell=True, check=True, text=True, cwd=cwd)
        return proc
    except subprocess.CalledProcessError as err:
        raise RunProcessError(
            "Failed to execute: %s" % command_and_arguments,
            command_and_arguments,
            err.stdout,
            err.stderr
        )
