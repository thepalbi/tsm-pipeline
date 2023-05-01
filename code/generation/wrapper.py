import os
import subprocess
import logging
import sys
from typing import Optional

from orchestration import global_config
from utils.clis import getenv_or_default


CODEQL_WRAPPER_TIMEOUT = getenv_or_default("CODEQL_WRAPPER_TIMEOUT", "1800") # default to 30 minuteos


class CodeQLWrapper:
    """CodeQLWrapper is a codeql wrapper in Python. It finds the codeql executable through
    the $CODEQL environment variable.
    """

    def __init__(self, process_timeout: Optional[int] = None):
        try:
            # TODO: Check that file exists, and it's codeql?
            self._code_ql_binary_path = global_config.codeql_executable

            # Make wrapper logs directory if not existent
            wrapper_logs_directory = os.path.join(global_config.logs_directory, "wrapper_logs")
            os.makedirs(wrapper_logs_directory, exist_ok=True)

            self._logs_directory = wrapper_logs_directory
            self._logger = logging.getLogger(self.__class__.__name__)
            self._logger.setLevel(logging.INFO)
            self._process_timeout = process_timeout
        except KeyError:
            raise Exception(
                "'codeql' binary not found. Try setting the $CODEQL environment variable.")


    """Runs codeql running a query against the given database, and then interprets the results."""
    def database_query(self,
                         project: str,
                         query_file: str,
                         search_path: str = global_config.worse_lib_search_path):
        query_file_name = os.path.basename(query_file)
        output_file = os.path.join(project, "results", "tsm-js", "tsm", os.path.splitext(query_file_name)[0])+'.bqrs'
        command_and_arguments = [
            self._code_ql_binary_path,
            "query", "run",
            query_file,
            f"--database={project}",
            f"--output={output_file}",
            "--threads=-1",
            "--timeout=%s" % CODEQL_WRAPPER_TIMEOUT, 
            f"--search-path={search_path}"
        ]
        self._logger.info(
            "Running 'query run' for project=[%s] and query_file=[%s]", project, query_file)
        self._run_process(command_and_arguments)


    """Runs codeql running a query against the given database, and then interprets the results."""
    def database_analyze(self,
                         project: str,
                         query_file: str,
                         output_file: str, 
                         search_path: str = global_config.worse_lib_search_path,
                         extra_options = [], 
                         output_format="csv"):
        command_and_arguments = [
            self._code_ql_binary_path,
            "database", "analyze",
            project,
            query_file,
            f'--format={output_format}',
            f'--logdir={self._logs_directory}',
            f'--output={output_file}',
            f'--search-path={search_path}',
            "--timeout=%s" % CODEQL_WRAPPER_TIMEOUT, 
            f'--threads=0' # 1 thread per core
        ]

        command_and_arguments = command_and_arguments + extra_options

        self._logger.info(
            "Running 'database analyze' for project=[%s] and query_file=[%s]", project, query_file)
        self._run_process(command_and_arguments)

    """Runs codeql analyzing the raw results of a BQRS file, formatting them in a file."""
    def bqrs_decode(self,
                    bqrs_file: str,
                    result_set: str,
                    output_file: str,
                    output_format="csv"):
        command_and_arguments = [
            self._code_ql_binary_path,
            "bqrs", "decode",
            bqrs_file,
            "--entities=string,url",
            "--result-set", result_set,
            f"--format={output_format}",
            f"--output={output_file}"
        ]
        self._logger.info(
            "Running 'bqrs decode' for bqrs_file=[%s] and result_set=[%s]", bqrs_file, result_set)
        self._run_process(command_and_arguments)

    def _run_process(self, command_and_arguments):
        # Since we call subprocess with shell=True we need the command to be a single string
        command_and_arguments = [" ".join(command_and_arguments)]
        self._logger.debug("command issued: %s",
                           " ".join(command_and_arguments))
        try:
            subprocess.run(command_and_arguments, capture_output=True, shell=True, check=True, text=True, timeout=self._process_timeout)
        except subprocess.CalledProcessError as call_error:
            self._logger.error(
                "Error when executing codeql: %s", call_error.stderr)
            if "Some queries times out. Results will be incomplete." in call_error.stderr:
                # codeql execution might have timed out
                raise Exception("CodeQL execution timed out")
            else:
                # catch every other thing
                raise Exception("CodeQL execution failed")