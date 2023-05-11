import unittest
from tsm.configuration import TSMConfigParser
from pathlib import Path

THIS_DIR = Path(__file__).parent


class TestTSM(unittest.TestCase):
    def test_config(self):
        parser = TSMConfigParser()
        parser.read(THIS_DIR / "sample.cfg")

        self.assertEqual(parser.get("global", "tmp_dir"), "/tmp")
        self.assertEqual(parser.get(
            "boosted_evaluation", "cli_version"), "2.13.1")
        self.assertEqual(parser.get("boosted_evaluation", "query_file"),
                         "/home/pablo/tesis/tsm-pipeline/tsm-atm-pipeline/src/tsm/evaluation/NosqlInjectionBoostedTSM.ql")

        self.assertEqual(parser.configured_query_types(), ["nosql"])
