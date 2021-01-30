import logging
from typing import Dict, Any, NewType
from glob import glob
import os 
import datetime
import time

Context = NewType('Context', Dict[str, Any])

# Generated entities keys
SOURCE_ENTITIES = "entities.sources"
SINK_ENTITIES = "entities.sinks"
SANITIZER_ENTITIES = "entities.sanitizers"
SRC_SAN_TUPLES_ENTITIES = "entities.src_san_tuple"
SAN_SNK_TUPLES_ENTITIES = "entities.san_snk_tuple"
REPR_MAP_ENTITIES = "entities.repr_map"

# Directory keys
CONSTRAINTS_DIR_KEY = "wd_constraints_dir"
MODELS_DIR_KEY = "wd_models_dir"
LOGS_DIR_KEY = "wd_logs_dir"
RESULTS_DIR_KEY = "results_dir"
WORKING_DIR_KEY = "working_dir"
SINGLE_STEP_NAME = "orchestrator.single_step_name"
STEP_NAMES = "orchestrator.steps_to_run"
COMMAND_NAME = "orchestrator.command_name"


class OrchestrationStep:
    def __init__(self, orchestrator):
        # TODO: Figure a way to add typing here, or at least not use the orchestrator as context passing mechanism
        self.orchestrator = orchestrator
        self.logger = logging.getLogger(self.__class__.__name__)

    def populate(self, ctx: Context) -> Context:
        """Populates ctx with the entries necessary to run this step."""        
        raise NotImplementedError()

    def run(self, ctx: Context) -> Context:
        """Run this orchestration step, adding entries to the context if necessary, and querying
        all necessary paths or info from previous steps from it."""        
        raise NotImplementedError()

    def name(self) -> str:
        """Readable name of the step."""
        raise NotImplementedError()

    def clean(self, ctx: Context):
        """Cleans the resources generated by this step."""
        pass

    def clean_error_callback(self, function, path, exec_info):
        self.logger.error(f"Error cleaning folder: {path}, exec_info: {exec_info}")


    def get_new_working_directories(self, query_name, working_dir):
        projects_folder = os.path.join(working_dir, "data")
        projects = glob(os.path.join(projects_folder, self.orchestrator.project_name))

        timestamp = str(int(time.mktime(datetime.datetime.now().timetuple())))
        optimizer_run_name = f"{query_name}-{timestamp}"
        
        project_name = name = self.orchestrator.project_name
        
        if not self.orchestrator.run_single:
            name = "multiple"   

        self.logger.info(f"Project dir: {project_name}/{optimizer_run_name}")

        constraints_dir = os.path.join(working_dir, "constraints", name, optimizer_run_name)
        models_dir = os.path.join(working_dir, "models", name, optimizer_run_name)
        logs_dir = os.path.join(working_dir, "logs", project_name, optimizer_run_name)
        return constraints_dir, models_dir, logs_dir
    
    def get_existing_working_directories(self, query_name, working_dir):
        projects_folder = os.path.join(working_dir, "data")
        projects = glob(os.path.join(projects_folder, self.orchestrator.project_name))

        project_name = name = self.orchestrator.project_name
        
        if not self.orchestrator.run_single:
            name = "multiple"   

        patternToSearch = os.path.join(working_dir, "constraints", name)+ "/{0}-*".format(query_name)
        candidates = glob(patternToSearch)
        print(candidates)
        if len(candidates)>0:
            candidates.sort()
            last_dir = candidates[-1]
            optimizer_run_name = os.path.basename(last_dir)
            self.logger.info(f"Project dir: {project_name}/{optimizer_run_name}")
        else:
            raise ValueError('Cannot find results directory for ' + patternToSearch)

        constraints_dir = os.path.join(working_dir, "constraints", name, optimizer_run_name)
        models_dir = os.path.join(working_dir, "models", name, optimizer_run_name)
        logs_dir = os.path.join(working_dir, "logs", project_name, optimizer_run_name)
        return constraints_dir, models_dir, logs_dir
     
