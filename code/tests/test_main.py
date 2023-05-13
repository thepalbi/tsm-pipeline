import unittest

import docker
from scripts.docker import run_tsm, TrainConfiguration
from experiments.all import train_and_evaluate
# from scripts.evaluate import evaluate, EvaluationSettings
import tempfile
from os.path import join as path_join
from database.cache import DatabasesCache
import logging
from typing import List
from pathlib import Path
from tsm.configuration import TSMConfigParser


logging.basicConfig(level=logging.DEBUG)
log = logging.getLogger(__name__)


class TestMain(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.docker_client = docker.from_env()
        cls.config = TSMConfigParser()
        this_dir = Path(__file__).parent
        cls.config.read(this_dir / "sample.cfg")
        cls.cache = DatabasesCache(cls.config.get(
            "global", "db_cache_dir"), cls.config.get("global", "db_cli_version"))

    @classmethod
    def tearDownClass(cls):
        cls.docker_client.close()

    def cleanup_dbs(self, dbs: List[str]):
        for db in dbs:
            cleaned_up = self.cache.clean_results(db)
            if cleaned_up:
                log.info("cleaned up results for db: %s", db)

    def test_smoke_run_nosql(self):
        test_train_data = [
            "ethereumclassic/explorer/da39687",
        ]
        results_dir = tempfile.mkdtemp()
        print("Using temporary directory as results: %s" % (results_dir))

        self.cleanup_dbs(test_train_data)

        # training
        train_settings = TrainConfiguration(
            config=self.config,
            query_type="nosql",
            project_list=test_train_data,
            results_dir=results_dir,
        )

        run_tsm(self.docker_client, train_settings, tail_logs=True, debug=True)

        # assert empty model error was logged
        self.assert_in_training_log(results_dir, "run ok")

        # assert evaluation portion
        results = train_and_evaluate(
            self.config,
            results_dir,
            test_train_data,
            test_train_data,
            "nosql",
            self.docker_client,
            skip=["train"],
        )
        # print results
        print(results)
        # assert non-zero score
        self.assertGreater(results["precision"][0],
                           0, "precision should be greater than zeo")
        self.assertGreater(results["recall"][0], 0,
                           "recall should be greater than zero")

    @unittest.skip("path not implemented")
    def test_smoke_training_run_path(self):
        test_train_data = [
            "Sv443/JokeAPI/f2c757a20bdc385edcf57b811ec8cc1a72899432",
        ]
        results_dir = tempfile.mkdtemp()
        print("Using temporary directory as results: %s" % (results_dir))

        self.cleanup_dbs(test_train_data)

        # training
        train_settings = TrainConfiguration(
            config=self.config,
            query_type="path",
            project_list=test_train_data,
            results_dir=results_dir,
        )

        run_tsm(self.docker_client, train_settings, tail_logs=True, debug=True)

        # assert empty model error was logged
        self.assert_in_training_log(results_dir, "run ok")

    @unittest.skip("path not implemented")
    def test_smoke_training_run_xss(self):
        results_dir = tempfile.mkdtemp()
        print("Using temporary directory as results: %s" % (results_dir))

        test_data = [
            "danielstern/express-react-fullstack/865504ee0d0188f10d162a06d1311d9115a68cfe"]

        self.cleanup_dbs(test_data)

        # training

        train_settings = TrainConfiguration(
            config=self.config,
            query_type="path",
            project_list=test_data,
            results_dir=results_dir,
        )

        run_tsm(self.docker_client, train_settings, tail_logs=True)

        # assert empty model error was logged
        self.assert_in_training_log(results_dir, "run ok")

    @unittest.skip("path not implemented")
    def test_expected_empty_model_error(self):
        results_dir = tempfile.mkdtemp()
        print("Using temporary directory as results: %s" % (results_dir))
        train_data_with_empty_model = [
            "bugulink/bugu-web/422f3bf2a8dbc85bd85e12e89ce40cb3cd9f6555"]

        self.cleanup_dbs(train_data_with_empty_model)

        # training
        train_settings = TrainConfiguration(
            config=self.config,
            query_type="path",
            project_list=train_data_with_empty_model,
            results_dir=results_dir,
        )

        run_tsm(self.docker_client, train_settings, tail_logs=True)

        # assert empty model error was logged
        self.assert_in_training_log(
            results_dir, "run ended because model was empty")

    def assert_in_training_log(self, results_dir: str, what: str):
        """checks if the training log located in results_dir containes the what given string.
        """
        # assert empty model error was logged
        with open(path_join(results_dir, "training_log.txt"), "r") as f:
            log = f.read()
            self.assertTrue(what in log)
