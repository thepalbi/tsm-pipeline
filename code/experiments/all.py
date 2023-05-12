from scripts.docker import run_tsm, TrainConfiguration, read_dbs_dataset, run_combine_scores
from scripts.evaluate import evaluate, EvaluationSettings
from os.path import join as path_join
from typing import List, Optional
from scripts.calculate_scores import calculate_scores_df
import pandas as pd
import docker
import logging
from dataclasses import dataclass
from tsm.configuration import TSMConfigParser


@dataclass(frozen=True)
class EvaluationQueryInfo:
    worse_search_path: str
    worse_query_file: str
    boosted_search_path: str
    boosted_query_file: str
    v0_search_path: str
    v0_query_file: str


log = logging.getLogger(__name__)


def train_and_evaluate(
    config: TSMConfigParser,
    results_dir: str,
    train: List[str],
    test: List[str],
    query_type: str,
    docker_client: docker.DockerClient,
    skip: List[str] = [],
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
        log.warning("configued to skip the following steps: %s",
                    ",".join(skip))

    log.info("train_and_evaluate with train size %d, test size %s",
             len(train), len(test))
    # training
    train_settings = TrainConfiguration(
        config=config,
        query_type=query_type,
        project_list=train,
        results_dir=results_dir,
    )

    if not "train" in skip:
        log.info("Running training")
        run_tsm(docker_client, train_settings, block=True)
    else:
        log.warning("skipping train")

    # evaluation
    external_predicate_file = path_join(results_dir, 'averaged-results.csv')

    worse_settings = EvaluationSettings(
        search_path=config.get("worse_evaluation:search_path"),
        cli_version=config.get("worse_evaluation:cli_version"),
        db_cli_version=config.get("global:db_cli_version"),
        query_file=config.get_for_querytype(query_type, "worse_query_file"),
        cache_root=config.get("global", "db_cache_dir"),
    )

    if not "evaluate_worse" in skip:
        log.info("Running worse evaluation")
        evaluate(
            settings=worse_settings,
            output_dir=path_join(results_dir, 'worse'),
            dbs=test,
        )
    else:
        log.warning("skipping worse evaluation")

    boosted_settings = EvaluationSettings(
        search_path=config.get("boosted_evaluation:search_path"),
        cli_version=config.get("boosted_evaluation:cli_version"),
        db_cli_version=config.get("global:db_cli_version"),
        query_file=config.get_for_querytype(query_type, "boosted_query_file"),
        cache_root=config.get("global", "db_cache_dir"),
        external_predicate_file=external_predicate_file,
    )

    if not "evaluate_boosted" in skip:
        log.info("Running boosted evaluation")
        evaluate(
            settings=boosted_settings,
            output_dir=path_join(results_dir, 'boosted'),
            dbs=test,
        )
    else:
        log.warning("skipping boosted evaluation")

    v0_settings = EvaluationSettings(
        search_path=config.get("v0_evaluation:search_path"),
        cli_version=config.get("v0_evaluation:cli_version"),
        db_cli_version=config.get("global:db_cli_version"),
        query_file=config.get_for_querytype(query_type, "v0_query_file"),
        cache_root=config.get("global", "db_cache_dir"),
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
