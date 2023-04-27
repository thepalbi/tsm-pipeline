import unittest

import docker
from scripts.xxx import run_tsm, ExperimentSettings
# from scripts.evaluate import evaluate, EvaluationSettings
import tempfile

defaults = {
    "bash_config_path": "/home/pablo/tesis/tsm-pipeline/code/scripts/config.sh",
}
defaults_evalute = {
    "cache_root":"/home/pablo/dbcache",    
}

test_train_data = [
    # "ASCOT/dashboardjs/352a8b6710d6f2ddfd42ddfa0266af65c9c23ebe",
    # "alphagov/submit-prototype-kit/6ce9e75078ea7965cb9429446cca8c5765817d7c",
    # "RuffApps/Apps/90e13d23b0593aa45f35fdac736b8e19c6616a9d",
    "Sv443/JokeAPI/f2c757a20bdc385edcf57b811ec8cc1a72899432",
]

class TestMain(unittest.TestCase):
    def test_smoke_training_run(self):
        docker_client = docker.from_env()
        results_dir = tempfile.mkdtemp()
        print("Using temporary directory as results: %s" % (results_dir))

        # training
        train_settings = ExperimentSettings(
            name="smoke_training_run",
            query_type="path",
            project_list=test_train_data,
            results_dir=results_dir,
            **defaults
        )

        run_tsm(docker_client, train_settings, tail_logs=True)