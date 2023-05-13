import json
import os
from tsm.configuration import PerformanceConfiguration

CODEQL_SOURCES_ROOT_KEY = "codeQLSourcesRoot"
CODEQL_EXECUTABLE_KEY = "codeQLExecutable"
WORKING_DIRECTORY_KEY = "workingDirectory"
RESULTS_DIRECTORY_KEY = "resultsDirectory"
SEARCH_WORSE_LIB_PATH_KEY = "searchPath"
LOGS_DIRECTORY_KEY = "logsDirectory"


class Configuration:
    def __init__(self, config_file_path="config.json"):
        with open(config_file_path, "r") as config_file:
            self.config = json.load(config_file)

    @property
    def codeql_executable(self):
        return self.config[CODEQL_EXECUTABLE_KEY]

    @property
    def sources_root(self):
        return self.config[CODEQL_SOURCES_ROOT_KEY]

    @property
    def working_directory(self):
        return self.config[WORKING_DIRECTORY_KEY]

    @property
    def results_directory(self):
        return self.config[RESULTS_DIRECTORY_KEY]

    @property
    def search_path(self):
        """search_path is the tsm configured search used when running `codeql database analyze` or
        `codeql query run`. It's used to resolve the javascript libraries, or dependencies of them.
        If it's more than one item they should be `:` concatenated.

        :return str: the search path to be used.
        """
        return self.config[SEARCH_WORSE_LIB_PATH_KEY]

    @property
    def logs_directory(self):
        return self.config[LOGS_DIRECTORY_KEY]

    @property
    def compiled_dbs_version(self):
        """compiled_dbs_version is the CodeQL CLI version used in the database cache
        to compile the dbs used during training.

        :return str: the db version to use in the cache
        """
        return self.config["compiledDBsVersion"]

    @property
    def performance(self) -> PerformanceConfiguration:
        parallelism = int(os.getenv("PERF_PARALLELISM", "4"))
        codeql_threads = int(os.getenv("PERF_CODEQL_THREADS", "2"))
        codeql_memory = int(os.getenv("PERF_CODEQL_MEMORY", "2000"))

        return PerformanceConfiguration(
            parallelism=parallelism,
            codeql_memory=codeql_memory,
            codeql_threads=codeql_threads,
        )

    def __getattr__(self, item):
        return self.config[item]
