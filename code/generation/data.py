import logging
import os
from typing import Tuple

from orchestration.steps import OrchestrationStep, Context
from orchestration.steps import SOURCE_ENTITIES, SINK_ENTITIES, SANITIZER_ENTITIES, \
    SRC_SAN_TUPLES_ENTITIES, SAN_SNK_TUPLES_ENTITIES, REPR_MAP_ENTITIES
from orchestration import global_config
from .wrapper import CodeQLWrapper
from orchestration import global_config

SOURCES = SINKS = SANITIZERS = "Known"

SUPPORTED_QUERY_TYPES = ["NoSql", "Sql", "Xss", "Sel", "Path"]

# Using for all codeql stuff a hard 5 minute timeout, that if elapsed, will kill the process
CODEQL_PROCESS_TIMEOUT = 5 * 60

class GenerateEntitiesStep(OrchestrationStep):
    def populate(self, ctx: Context) -> Context:
        (ctx[SOURCE_ENTITIES],
         ctx[SINK_ENTITIES],
         ctx[SANITIZER_ENTITIES],
         ctx[SRC_SAN_TUPLES_ENTITIES],
         ctx[SAN_SNK_TUPLES_ENTITIES],
         ctx[REPR_MAP_ENTITIES]) = self.orchestrator.data_generator.get_entity_files(self.orchestrator.query_type)
        return ctx

    def run(self, ctx: Context) -> Context:
        self.orchestrator.data_generator.generate_entities(
            self.orchestrator.query_type, ctx)
        return ctx

    def name(self) -> str:
        return "generate_entities"


class DataGenerator:
    """DataGenerator extracts the events and propagation graph information from the
    provided project. It orchestrates the calls to the CodeQL toolchain, running 
    a couple of queries (for sources, sinks, sanitizers, and the PG).
    """

    def __init__(self, project_dir: str, project_name: str,
                 working_dir: str = global_config.working_directory,
                 results_dir: str = global_config.results_directory,
                 ):
        """Creates a new DataGenerator for the given project

        Args:
            project_dir (str): the relative directory to projects CodeQL database
            project_name (str): the project slug (usually the folder name of the project's database)
        """
        self.project_dir = project_dir
        self.project_name = project_name
        self.codeql = CodeQLWrapper(process_timeout=CODEQL_PROCESS_TIMEOUT)
        # noinspection PyInterpreter
        self.logger = logging.getLogger(self.__class__.__name__)
        self.working_dir = working_dir
        self.results_dir = results_dir
        self.generated_data_dir = self._get_generated_data_dir()

        constaintssolving_dir = global_config.results_directory
        logs_folder = os.path.join(constaintssolving_dir, "logs/")
        if not os.path.exists(logs_folder):
            os.mkdir(logs_folder)

        self.logs_folder = logs_folder
    

    def get_generated_data_dir(self):
        return self._get_generated_data_dir()

    def _get_generated_data_dir(self):
        generated_data_dir = os.path.join(
            global_config.results_directory, f"{self.working_dir}/data/{self.project_name}/")
        if not os.path.isdir(generated_data_dir):
            self.logger.warn(
                "Creating directory for generated data at %s", generated_data_dir)
            os.makedirs(generated_data_dir)
        return generated_data_dir

    def _get_tsm_query_file_for_entity(self, queried_entity: str, query_type: str) -> str:
        return self._get_tsm_query_file(query_type, f"{queried_entity}-{query_type}.ql")

    def _get_tsm_query_file(self, query_type: str, filename: str) -> str:
        """_get_tsm_query_file gets the absolute path to the tsm library codeql query file.

        :param str query_type: query type
        :param str filename: filename
        :return str aboluste path to the query
        """        
        if query_type is None:
            return os.path.join(global_config.sources_root, "tsm", filename)
        else: 
            return os.path.join(global_config.sources_root, "tsm", query_type, filename)

    def _get_tsm_bqrs_file_for_entity(self, queried_entity: str, query_type: str) -> str:
        # Add query_type as prefix folder since database analyze 
        # reads the ql file from query_type/file.ql and generates the same route
        # this will change if we replace database analyze with database query   
        return self._get_tsm_bqrs_file( f"{query_type}/{queried_entity}-{query_type}.bqrs")
        

    def _get_tsm_bqrs_file(self, filename: str) -> str:
        return os.path.join(global_config.results_directory, self.project_dir, "results", "tsm-js", "tsm", filename)

    def generate_scores(self, query_type: str, combinedScore: bool, kind = "snk") -> Tuple[str, ...]:
        # Run metrics-snk query

        metrics_file = "metrics_{0}_{1}".format(kind, query_type)
        self.logger.info("Generating events scores.")
        self.codeql.database_query(
            self.project_dir,
            self._get_tsm_query_file(query_type, metrics_file + ".ql"))

        # Get results BQRS file
        bqrs_metrics_file = self._get_tsm_bqrs_file(metrics_file + '.bqrs')
        subfix = ""
        if combinedScore:
            subfix = "-combined"

        tsm_worse_scores_file = os.path.join(
            self.generated_data_dir, f"{self.project_name}-tsmworse-ind-avg{subfix}-{kind}.prop.csv")
        tsm_worse_filtered_file = os.path.join(
            self.generated_data_dir, f"{self.project_name}-tsmworse-filtered-avg{subfix}-{kind}.prop.csv")

        prediction_scores_file = os.path.join(
            self.generated_data_dir, f"{self.project_name}-prediction-{subfix}-{kind}.prop.csv")

        # Extract result scores
        self.codeql.bqrs_decode(
            bqrs_metrics_file, f"getTSMWorseScores{query_type}{kind}", tsm_worse_scores_file)
        self.codeql.bqrs_decode(bqrs_metrics_file, f"getTSMWorseFiltered{query_type}{kind}",
                                tsm_worse_filtered_file)

        return tsm_worse_scores_file, tsm_worse_filtered_file

    def generate_entities(self, query_type: str, ctx: Context) -> Tuple[str, ...]:
        """Main data generation method, that orchestrates the process.

        Args:
            query_type (str): query type to generate data for (eg. Xss, Sql, NoSql, etc.).
        """
        if not query_type in SUPPORTED_QUERY_TYPES:
            raise Exception(
                "{0} is not a supported query type. Currently supports {1}".format(query_type, SUPPORTED_QUERY_TYPES))

        # For KnownSource  we use current version of CodeQl Libraries  
        # sources
        self._generate_for_entity(
            query_type, SOURCES, f"source{query_type}Classes", ctx[SOURCE_ENTITIES], True,
            global_config.search_path)
        # sinks
        self._generate_for_entity(
            query_type, SINKS, f"sink{query_type}Classes", ctx[SINK_ENTITIES], False,
            global_config.search_path)
        # sanitizers
        self._generate_for_entity(
            query_type, SANITIZERS, f"sanitizer{query_type}Classes", ctx[SANITIZER_ENTITIES], False,
            global_config.search_path)
        
        # running propagation graph queries
        # we use the csv files of known sources/sinks/sanitizers 
        # to feed the corresponding predicates in the PG query
        try:
            propgraph_path = self._get_tsm_query_file(query_type, f"PropagationGraph-{query_type}.ql")

            # For Progapation graphs we use current version of CodeQl Libraries  
            self.codeql.database_analyze(
                self.project_dir,
                propgraph_path,
                f"{self.logs_folder}/js-results.csv",
                global_config.search_path,
                [f"--external=knownSource={ctx[SOURCE_ENTITIES]}",
                f"--external=knownSink={ctx[SINK_ENTITIES]}",
                f"--external=knownSanitizer={ctx[SANITIZER_ENTITIES]}"]
                )

        except Exception as e:
            self.logger.info("Error Analyzing PropagationGraph.ql")
            raise(e)

        self.logger.info("Generating propagation graph data")
        bqrs_propgraph = self._get_tsm_bqrs_file_for_entity("PropagationGraph", query_type)
        # data/1046224544_fontend_19c10c3/1046224544_fontend_19c10c3-src-san.prop.csv
        
        # We remove the entities to make sure we use updated versions
        if os.path.exists(ctx[SRC_SAN_TUPLES_ENTITIES]):
            os.remove(ctx[SRC_SAN_TUPLES_ENTITIES])
        if os.path.exists(ctx[SAN_SNK_TUPLES_ENTITIES]): 
            os.remove(ctx[SAN_SNK_TUPLES_ENTITIES])
        if os.path.exists(ctx[REPR_MAP_ENTITIES]):
            os.remove(ctx[REPR_MAP_ENTITIES])

        self.codeql.bqrs_decode(
            bqrs_propgraph,
            "pairSrcSan",
            ctx[SRC_SAN_TUPLES_ENTITIES])

        # data/1046224544_fontend_19c10c3/1046224544_fontend_19c10c3-san-snk.prop.csv
        self.codeql.bqrs_decode(
            bqrs_propgraph,
            "pairSanSnk",
            ctx[SAN_SNK_TUPLES_ENTITIES])

        # repr
        # data/1046224544_fontend_19c10c3/1046224544_fontend_19c10c3-eventToConcatRep-small.prop.csv
        self.codeql.bqrs_decode(
            bqrs_propgraph,
            "eventToConcatRep",
            ctx[REPR_MAP_ENTITIES])

    def get_entity_files(self, query_type: str) -> Tuple[str, ...]:
        if not query_type in SUPPORTED_QUERY_TYPES:
            raise Exception(
                "{0} is not a supported query type. Currently supports {1}".format(query_type, SUPPORTED_QUERY_TYPES))
        sources_output_file = os.path.join(
            self.generated_data_dir, f"{self.project_name}-sources-{query_type}.prop.csv")
        sinks_output_file = os.path.join(
            self.generated_data_dir, f"{self.project_name}-sinks-{query_type}.prop.csv")
        sanitizers_output_file = os.path.join(
            self.generated_data_dir, f"{self.project_name}-sanitizers-{query_type}.prop.csv")

        src_san_output_file = os.path.join(
            self.generated_data_dir, f"{self.project_name}-src-san-small.prop.csv")
        san_snk_output_file = os.path.join(
            self.generated_data_dir, f"{self.project_name}-san-snk-small.prop.csv")
        repr_mapping_output_file = os.path.join(
            self.generated_data_dir, f"{self.project_name}-eventToConcatRep-small.prop.csv")

        return (
            sources_output_file,
            sinks_output_file,
            sanitizers_output_file,
            src_san_output_file,
            san_snk_output_file,
            repr_mapping_output_file
        )

    def _generate_for_entity(self, query_type: str, entity_type: str, result_set: str, output_file: str, 
                            force_query: bool = True,
                            search_path:str = global_config.search_path):
        """Runs the query for a given entity, and extracts the results into a csv file."""
        self.logger.info(
            "Generating %s data in file=[%s]", entity_type, output_file)
        query_path = self._get_tsm_query_file_for_entity(
                entity_type,
                query_type)
        bqrs_file = self._get_tsm_bqrs_file_for_entity(entity_type, query_type)
        
        # We remove the entity to make sure is using a new one
        if os.path.exists(output_file):
            os.remove(output_file)

        if not os.path.exists(bqrs_file) or force_query: 
            self.codeql.database_analyze(
                self.project_dir,
                query_path,
                f"{self.logs_folder}/js-results.csv",
                search_path)

        self.codeql.bqrs_decode(
            bqrs_file,
            result_set,
            output_file)
