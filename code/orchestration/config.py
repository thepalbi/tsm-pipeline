import json

CODEQL_SOURCES_ROOT_KEY = "codeQLSourcesRoot"
CODEQL_EXECUTABLE_KEY = "codeQLExecutable"
WORKING_DIRECTORY_KEY = "workingDirectory"
RESULTS_DIRECTORY_KEY = "resultsDirectory"
SEARCH_WORSE_LIB_PATH_KEY = "worseLibSearchPath"
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
    def worse_lib_search_path(self):
        return self.config[SEARCH_WORSE_LIB_PATH_KEY]

    @property
    def logs_directory(self):
        return self.config[LOGS_DIRECTORY_KEY]

    def __getattr__(self, item):
        return self.config[item]
