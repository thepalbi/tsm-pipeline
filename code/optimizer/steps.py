import os
import shutil
from glob import glob
from generation.data import DataGenerator
from DataParser import compute_rep_count
import logging

from optimizer.compute_scores import compute_optimized_repr_scores
from orchestration.steps import OrchestrationStep, Context,\
    CONSTRAINTS_DIR_KEY, MODELS_DIR_KEY, RESULTS_DIR_KEY, WORKING_DIR_KEY, LOGS_DIR_KEY, \
    SOURCE_ENTITIES, SANITIZER_ENTITIES,  SINK_ENTITIES, SRC_SAN_TUPLES_ENTITIES, SAN_SNK_TUPLES_ENTITIES, REPR_MAP_ENTITIES, \
    SINGLE_STEP_NAME, COMMAND_NAME, STEP_NAMES, DB_LOGGER

from solver.config import SolverConfig
from solver.get_constraints import ConstraintBuilder
from solver.solve import solve_constraints_combine_model


log = logging.getLogger(__name__)


class CountRepsStep(OrchestrationStep):
    def populate(self, ctx: Context) -> Context:
        return ctx

    def clean(self, ctx: Context):
        pass

    def should_use_existing_model_dirs(self, ctx):
        """This step should use existing model_dirs in the following cases:
        1. Just running optimize step, should use existing model dirs
        2. When cleaning, delete the existing model dirs
        3. If running multiple steps, but this step is not included, reuse existing model dirs
        """
        return \
            (SINGLE_STEP_NAME in ctx) and ctx[SINGLE_STEP_NAME] == "optimize" or \
            (COMMAND_NAME in ctx) and ctx[COMMAND_NAME] == "clean" or \
            (STEP_NAMES in ctx) and not self.name() in ctx[STEP_NAMES]

    def run(self, ctx: Context) -> Context:
        # TODO: Implement --mode=combined model generation
        # TODO: Extract this as an orchestrator config?
        working_dir = ctx[WORKING_DIR_KEY]

        projects_folder = os.path.join(working_dir, "data")
        projects_path = [ps for p in self.orchestrator.project_list for ps in glob(
            os.path.join(projects_folder, p))]

        projects = [os.path.basename(k) for k in projects_path]
        log.info("Collected {0} projects".format(len(projects)))
        log.info("Counting reps")

        for path in projects_path:
            project = os.path.basename(path)
            project_dir = os.path.dirname(path)
            try:
                log.info("Analyzing project: %s", project)

                # hack -> refactor using populate
                dataGenerator = DataGenerator(project_dir, project,
                                              self.orchestrator.data_generator.working_dir,
                                              self.orchestrator.data_generator.results_dir)
                self.orchestrator.project_name = project

                (ctx[SOURCE_ENTITIES],
                 ctx[SINK_ENTITIES],
                 ctx[SANITIZER_ENTITIES],
                 ctx[SRC_SAN_TUPLES_ENTITIES],
                 ctx[SAN_SNK_TUPLES_ENTITIES],
                 ctx[REPR_MAP_ENTITIES]) = dataGenerator.get_entity_files(self.orchestrator.query_type)

                compute_rep_count(ctx[REPR_MAP_ENTITIES],
                                  self.orchestrator.rep_counter)
                print('rep_count %d' % len(self.orchestrator.rep_counter))

            except Exception as e:
                log.info("There was a problem reading events!")
                log.exception(
                    f"Ignoring fatal error running {self.name()} for {path}")
                pass

        return ctx

    def name(self) -> str:
        return "count_reps"


class GenerateModelStep(OrchestrationStep):
    def populate(self, ctx: Context) -> Context:
        if self.should_use_existing_model_dirs(ctx):
            try:
                (ctx[CONSTRAINTS_DIR_KEY],
                 ctx[MODELS_DIR_KEY],
                 ctx[LOGS_DIR_KEY]) = self.get_existing_working_directories(self.orchestrator.query_name, ctx[WORKING_DIR_KEY])
            except Exception as inst:
                raise ValueError('Could not find working directory ' +
                                 ctx[WORKING_DIR_KEY] + '. Maybe you never generated a model. Try generate_model step')

        else:
            (ctx[CONSTRAINTS_DIR_KEY],
             ctx[MODELS_DIR_KEY],
             ctx[LOGS_DIR_KEY]) = self.get_new_working_directories(self.orchestrator.query_name, ctx[WORKING_DIR_KEY])

        # generate results dir so I can write model metrics
        ctx[RESULTS_DIR_KEY] = self.orchestrator.compute_results_dir()
        if not os.path.exists(ctx[RESULTS_DIR_KEY]):
            log.info("Creating dir %s" % ctx[RESULTS_DIR_KEY])
            os.makedirs(ctx[RESULTS_DIR_KEY])

        return ctx

    def clean(self, ctx: Context):
        for dir_to_remove in [ctx[CONSTRAINTS_DIR_KEY], ctx[MODELS_DIR_KEY], ctx[LOGS_DIR_KEY]]:
            log.info(f"Removing directory `{dir_to_remove}` and its contents")
            shutil.rmtree(dir_to_remove, onerror=self.clean_error_callback)

    def should_use_existing_model_dirs(self, ctx):
        """
        This step should use existing model_dirs in the following cases:
        1. Just running optimize step, should use existing model dirs
        2. When cleaning, delete the existing model dirs
        3. If running multiple steps, but this step is not included, reuse existing model dirs
        """
        # Commenting out, old feature used when the pipeline was run individually
        # return \
        #     (SINGLE_STEP_NAME in ctx) and ctx[SINGLE_STEP_NAME] == "optimize" or \
        #     (COMMAND_NAME in ctx) and ctx[COMMAND_NAME] == "clean" or \
        #     (SINGLE_STEP_NAME not in ctx and STEP_NAMES in ctx) and not self.name() in ctx[STEP_NAMES]
        return False

    def run(self, ctx: Context) -> Context:
        # TODO: Implement --mode=combined model generation
        # TODO: Extract this as an orchestrator config?
        # TODO: Fix logging
        results_dir = ctx[RESULTS_DIR_KEY]
        working_dir = ctx[WORKING_DIR_KEY]
        constraints_dir = ctx[CONSTRAINTS_DIR_KEY]
        models_dir = ctx[MODELS_DIR_KEY]
        logs_dir = ctx[LOGS_DIR_KEY]

        config = SolverConfig(query_name=self.orchestrator.query_name, query_type=self.orchestrator.query_type,
                              working_dir=working_dir, results_dir=results_dir)

        projects_folder = os.path.join(config.working_dir, "data")
        if self.orchestrator.run_single:
            projects_path = glob(os.path.join(
                projects_folder, self.orchestrator.project_name))
        else:
            projects_path = [ps for p in self.orchestrator.project_list for ps in glob(
                os.path.join(projects_folder, p))]

        # Create directories if needed
        # results_dir]:
        for directory in [constraints_dir, models_dir, logs_dir]:
            os.makedirs(directory, exist_ok=True)

        projects = [os.path.basename(k) for k in projects_path]
        log.info("Collected {0} projects".format(len(projects)))
        log.info("Creating events and reps")

        name = self.orchestrator.project_name

        if not self.orchestrator.run_single:
            name = "multiple"

        constraint_builder = ConstraintBuilder(name,
                                               constraints_dir,
                                               config.min_rep_events,
                                               config.dataset_type,
                                               config.constraint_format,
                                               config.lambda_const,
                                               config.working_dir)
        for project_path in projects_path:
            project = os.path.basename(project_path)
            project_dir = os.path.dirname(project_path)
            try:
                log.info("Analyzing project: %s", project)

                # hack -> refactor using populate
                if not self.orchestrator.run_single:
                    self.orchestrator.project_name = project
                    data_generator = DataGenerator(
                        project_dir,
                        project,
                        self.orchestrator.data_generator.working_dir,
                        self.orchestrator.data_generator.results_dir,
                    )

                    (ctx[SOURCE_ENTITIES],
                     ctx[SINK_ENTITIES],
                     ctx[SANITIZER_ENTITIES],
                     ctx[SRC_SAN_TUPLES_ENTITIES],
                     ctx[SAN_SNK_TUPLES_ENTITIES],
                     ctx[REPR_MAP_ENTITIES]) = data_generator.get_entity_files(self.orchestrator.query_type)

                constraint_builder.readEventsAndReps(project, ctx)
                constraint_builder.readAllKnown(project, config.query_name, config.query_type,
                                                config.use_all_sanitizers, ctx)
            except Exception:
                log.exception("There was a problem reading events!")
                raise
        # if we run multiple projects we allow some filtering
        # this whole block is not running due to the blacklist step disabled
        if not self.orchestrator.run_single:
            # remove events with no min reps
            constraint_builder.removeRareEvents()
        else:
            if len(self.orchestrator.rep_counter) > 0:
                constraint_builder.removeRareEvents(
                    self.orchestrator.rep_counter)

        # initiate all variables
        constraint_builder.createVariables(ctx)

        log.info("Adding constraints")
        for project_path in projects_path:
            project = os.path.basename(project_path)
            log.info(">>>>>>>>>>>>>Executing project %s" % project)
            # hack -> refactor using populate
            if not self.orchestrator.run_single:
                self.orchestrator.project_name = project
                data_generator = DataGenerator(
                    project_dir,
                    project,
                    self.orchestrator.data_generator.working_dir,
                    self.orchestrator.data_generator.results_dir,
                )

                (ctx[SOURCE_ENTITIES],
                 ctx[SINK_ENTITIES],
                 ctx[SANITIZER_ENTITIES],
                 ctx[SRC_SAN_TUPLES_ENTITIES],
                 ctx[SAN_SNK_TUPLES_ENTITIES],
                 ctx[REPR_MAP_ENTITIES]) = data_generator.get_entity_files(self.orchestrator.query_type)
            try:
                # Write flow constraints, as in Seldon 4.2
                constraint_builder.generate_flow_constraints_from_pairs(
                    project, config.constraints_constant_C, query=config.query_name, ctx=ctx)
                pass
            except:
                import traceback as tb
                tb.print_exc()

        # Write variable constraints as in Seldon 4.1
        constraint_builder.writeVarConstrants(ctx)
        constraint_builder.writeKnownConstraints(ctx)
        # Write objective as in Seldon 4.4, minimizing the violation of each constraint
        constraint_builder.writeObjective(ctx)

        # known maps are indexed by project, since they used to support multiple projects
        # count all
        def count_known_for_project_indexed_map(m: dict) -> int:
            return sum([
                len(m[k]) for k in m.keys()
            ])

        db_logger: logging.LoggerAdapter = ctx[DB_LOGGER]
        # hard-coding this to the base results dir, since the results_dir key uses a suffix with the project name
        # write model metrics to results folder
        model_infos = [
            f"model_variables_count={len(constraint_builder.variables)}",
            f"model_known_source_count={count_known_for_project_indexed_map(constraint_builder.known_sources)}",
            f"model_known_sanitizer_count={count_known_for_project_indexed_map(constraint_builder.known_sanitizers)}",
            f"model_known_sink_count={count_known_for_project_indexed_map(constraint_builder.known_sinks)}",
        ]
        db_logger.info("model info: %s", " ".join(model_infos))

        return ctx

    def name(self) -> str:
        return "generate_model"


class OptimizeStep(OrchestrationStep):
    def populate(self, ctx: Context) -> Context:
        return ctx

    def run(self, ctx: Context) -> Context:
        # ctx entry for result dir should have been created in generate_model populate func, since it's used for model metrics
        results_dir = ctx[RESULTS_DIR_KEY]
        working_dir = ctx[WORKING_DIR_KEY]

        # If we are clean in ran, and each previous step once again (generate_entities and generate_model),
        # we might need to re-create the model dir, since it was previously deleted.

        os.makedirs(ctx[MODELS_DIR_KEY], exist_ok=True)

        config = SolverConfig(query_name=self.orchestrator.query_name, query_type=self.orchestrator.query_type,
                              working_dir=working_dir, results_dir=results_dir)

        config.no_flow_constraints = self.orchestrator.no_flow
        config.solver = self.orchestrator.solver

        # Run solver
        solve_constraints_combine_model(config, ctx)

        # Compute metrics
        compute_optimized_repr_scores(config, ctx)

        return ctx

    def name(self) -> str:
        return "optimize"
