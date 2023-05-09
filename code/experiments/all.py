from scripts.docker import run_tsm, ExperimentSettings, read_dbs_dataset, run_combine_scores
from scripts.evaluate import evaluate, EvaluationSettings
from os.path import join as path_join
from typing import List, Optional
from scripts.calculate_scores import calculate_scores_df
import pandas as pd
import docker
import logging
from dataclasses import dataclass

@dataclass(frozen=True)
class EvaluationQueryInfo:
    boosted_search_path: str
    boosted_query_file: str
    v0_search_path: str
    v0_query_file: str


QUERY_INFOS = {
    "nosql": EvaluationQueryInfo(
        boosted_search_path="/home/pablo/tesis/tsm-pipeline/lib-worse/codeql/javascript/ql:/home/pablo/.codeql/packages/codeql/javascript-upgrades/0.0.3",
        boosted_query_file="/home/pablo/tesis/tsm-pipeline/tsm-atm-pipeline/src/tsm/evaluation/NosqlInjectionWorseTSM.ql",
        v0_search_path="/home/pablo/codeqlv0/javascript/ql/lib",
        v0_query_file="/home/pablo/tesis/tsm-pipeline/tsm-evaluation/tsm-evaluation/src/NoSqlEvaluation.ql",
    )
}


log = logging.getLogger(__name__)



defaults_train = {
    "bash_config_path": "/home/pablo/tesis/tsm-pipeline/code/scripts/config.sh",
}

defaults_evalute = {
    "cache_root":"/home/pablo/dbcache",    
}

DB_CLI_VERSION = "2.5.2"
EVALUATE_CLI_VERSION = "2.13.1"


def train_and_evaluate(
        results_dir: str,
        train: List[str],
        test: List[str],
        query_type: str,
        docker_client: docker.DockerClient,
        skip: List[str]=[],
    ) -> pd.DataFrame:
    """
    train_and_evaluate runs the whole training and evaluation pipeline

    :param str results_dir: _description_
    :param List[str] train: _description_
    :param List[str] test: _description_
    :param str query_type: _description_
    :param docker.DockerClient docker_client: _description_
    :param List[str] skip: steps to skip, can be "train", "evaluate_boosted" or "evaluate_v0", defaults to []
    :return pd.DataFrame: the computed scores for the experiment
    """
    if len(skip) > 0:
        log.warning("configued to skip the following steps: %s", ",".join(skip))

    log.info("train_and_evaluate with train size %d, test size %s", len(train), len(test))
    # training
    train_settings = ExperimentSettings(
        name="unusued",
        query_type=query_type,
        project_list=train,
        results_dir=results_dir,
        **defaults_train,
    )

    if not "train" in skip:
        log.info("Running training")
        run_tsm(docker_client, train_settings, block=True)
    else:
        log.warning("skipping train")

    # evaluation
    external_predicate_file = path_join(results_dir, 'averaged-results.csv')
    evaluate_query_info = QUERY_INFOS[query_type]

    worse_settings = EvaluationSettings(
        search_path=evaluate_query_info.boosted_search_path,
        cli_version=EVALUATE_CLI_VERSION,
        db_cli_version=DB_CLI_VERSION,
        query_file=evaluate_query_info.boosted_query_file,
        external_predicate_file=external_predicate_file,
        **defaults_evalute,
    )


    if not "evaluate_boosted" in skip:
        log.info("Running boosted evaluation")
        evaluate(
            settings=worse_settings,
            output_dir=path_join(results_dir, 'worse'),
            dbs=test,
        )
    else:
        log.warning("skipping boosted evaluation")

    v0_settings = EvaluationSettings(
        search_path=evaluate_query_info.v0_search_path,
        cli_version=EVALUATE_CLI_VERSION,
        db_cli_version=DB_CLI_VERSION,
        query_file=evaluate_query_info.v0_query_file,
        **defaults_evalute,
    )

    if not "evaluate_v0" in skip:
        log.info("Running v0 evaluation")
        evaluate(
            settings=v0_settings,
            output_dir=path_join(results_dir, 'v0'),
            dbs=test,
        )
    else:
        log.warning("skipping v0 evaluation")

    return calculate_scores_df(
        results_folder=results_dir,
        cleanup_base_dir="/tmp",
    )
