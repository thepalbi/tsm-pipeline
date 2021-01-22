import logging
from typing import List

from generation.data import DataGenerator, GenerateEntitiesStep, GenerateScoresStep, GenerateTSMQueryStep
from optimizer.gurobi import GenerateModelStep, OptimizeStep, CountRepsStep

from orchestration import global_config
from orchestration.steps import Context,  RESULTS_DIR_KEY, WORKING_DIR_KEY, SINGLE_STEP_NAME, COMMAND_NAME, STEP_NAMES

import time
import datetime

import os 
import glob

class UnknownStepException(Exception):
    def __init__(self, step_name: str, available_steps: List[str]):
        self.available_steps = available_steps
        self.step_name = step_name

    def __str__(self) -> str:
        return f"The orchestration step named '{self.step_name}' was not found. " \
               f"The available steps are: {self.available_steps}"


class Orchestrator:
    # Do not change the order of the steps in this list, its used for populating
    # the ctx in the order they are passed between them.
    step_templates = [
        GenerateEntitiesStep,
        GenerateModelStep,
        CountRepsStep,
        OptimizeStep,
        #GenerateScoresStep,
        GenerateTSMQueryStep
    ]
    possible_steps = [
        GenerateEntitiesStep,
        GenerateModelStep,
        CountRepsStep,
        OptimizeStep,
        GenerateScoresStep,
        GenerateTSMQueryStep
    ]

    def __init__(self, project_dir: str, project_name: str, 
                query_type: str, query_name: str, kind: str,  
                working_dir: str, results_dir: str, 
                scores_file: str, 
                no_flow: bool,
                run_separate_on_multiple_projects: bool,
                project_list: List[str], 
                rep_counter = dict(),
                hasExecuted: bool = False):
        self.query_type = query_type
        self.query_name = query_name
        self.kind = kind
        self.project_dir = project_dir
        self.project_name = project_name
        self.working_dir = working_dir
        self.results_dir = results_dir
        self.no_flow = no_flow
        self.project_list = project_list
        self.run_single = run_separate_on_multiple_projects
        self.scores_file = scores_file
        if scores_file == None: 
            self.combinedScore = False
            self.scores_file = "reprScores.txt"
        else:
            self.scores_file = scores_file
            self.combinedScore = True
        self.rep_counter = rep_counter
        # Hack to execute only once a step 
        self.hasExecuted = hasExecuted

        self.data_generator = DataGenerator(project_dir, project_name, working_dir, results_dir)
        self.logger = logging.getLogger(self.__class__.__name__)
        # Instantiate orchestration step templates
        self.steps = []
        for step_template in Orchestrator.step_templates:
            self.steps.append(step_template(self))
        self.possible_steps = []
        for possible_step in Orchestrator.possible_steps:
            self.possible_steps.append(possible_step(self))

    def compute_results_dir(self, new_directory=False):
        if(not self.combinedScore):
            project_name = name = self.project_name
            #print(self.query_name)
            #print(self.results_dir)
            if not self.run_single:
                name = "multiple"   

            patternToSearch = os.path.join(self.results_dir, name)+ "/{0}-*".format(self.query_name)
            #print(patternToSearch)
            results_candidates = glob.glob(patternToSearch)
            print(results_candidates)
            if len(results_candidates)>0 and not new_directory:
                results_candidates.sort()
                results_folder = results_candidates[-1]
                print("existing")
                print(results_folder)
            else:
                #raise ValueError('Cannot find results directory for ' + self.project_name )           
                timestamp = str(int(time.mktime(datetime.datetime.now().timetuple())))
                optimizer_run_name = f"{self.query_name}-{timestamp}"
                results_folder = os.path.join(self.results_dir, name, optimizer_run_name)
                print("not existing")
                print(results_folder)
                print(self.results_dir)

            return results_folder
        else:
            return self.results_dir

    def run(self):
        self.logger.info("Running ALL orchestration-run steps")

        ctx = self.starting_ctx()
        ctx[COMMAND_NAME] = "run"
        
        for step in self.steps:
            self.print_step_banner(step, "run")
            ctx = step.populate(ctx)
            ctx = step.run(ctx)

    def run_steps(self, steps: List[str]):
        self.logger.info(f"Running orchestration-run steps: {', '.join(steps)}")

        ctx = self.starting_ctx()
        ctx[COMMAND_NAME] = "run"
        ctx[STEP_NAMES] = steps
        
        for step in self.steps:
            if step.name() in steps:
                self.print_step_banner(step, "run")
                ctx = step.populate(ctx)
                step.run(ctx)
            else:
                # Make each previous step populate the ctx
                self.logger.info(f"Step `{step.name()}` is populating context")
                ctx = step.populate(ctx)

    def clean(self):
        self.logger.info("Running ALL orchestration-clean steps")

        ctx = self.starting_ctx()
        ctx[COMMAND_NAME] = "clean"

        for step in self.steps:
            self.print_step_banner(step, "clean")
            ctx = step.populate(ctx)
            step.clean(ctx)

    """Deprecated"""
    def run_step(self, step_name: str):
        self.logger.info("Running SINGLE orchestration step")

        ctx = self.starting_ctx()
        ctx[SINGLE_STEP_NAME] = step_name
        ctx[COMMAND_NAME] = "run"

        for step in self.possible_steps:
            if step.name() == step_name:
                self.print_step_banner(step, "run")
                ctx = step.populate(ctx)
                step.run(ctx)
                return
            else:
                # Make each previous step populate the ctx
                self.logger.info(f"Step `{step.name()}` is populating context")
                ctx = step.populate(ctx)

        # Step was not found
        raise UnknownStepException(step_name, [step.name() for step in self.possible_steps])

    def print_step_banner(self, step, command):
        separator = ">" * 5
        self.logger.info("%s Running orchestration-%s step: %s %s", separator, command, step.name(), separator)

    def starting_ctx(self) -> Context:
        ctx = dict()
        ctx[RESULTS_DIR_KEY] = self.compute_results_dir()
        ctx[WORKING_DIR_KEY] = self.working_dir
        return ctx
 