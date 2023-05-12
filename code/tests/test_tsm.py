import unittest
from tsm.configuration import TSMConfigParser
from pathlib import Path


THIS_DIR = Path(__file__).parent


class TestTSM(unittest.TestCase):
    def test_all_interpolations(self):
        parser = TSMConfigParser()
        parser.read(THIS_DIR / "sample.cfg")
        self.assertTrue(parser.check())

    def test_config(self):
        parser = TSMConfigParser()
        parser.read(THIS_DIR / "sample.cfg")

        self.assertEqual(parser.get("global", "tmp_dir"), "/tmp")
        self.assertEqual(parser.get(
            "boosted_evaluation", "cli_version"), "2.13.1")

        self.assertEqual(parser.configured_querytypes(), ["nosql"])
        self.assertEqual(parser.get_for_querytype("nosql", "worse_query_file"),
                         "/home/pablo/tesis/tsm-pipeline/tsm-atm-pipeline/src/tsm/evaluation/NosqlInjectionWorseTSM.ql")
        self.assertEqual(parser.get_for_querytype("nosql", "boosted_query_file"),
                         "/home/pablo/tesis/tsm-pipeline/tsm-atm-pipeline/src/tsm/evaluation/NosqlInjectionBoostedTSM.ql")

        self.assertEqual(parser.getint("performance", "parallelism"), 4)
        self.assertEqual(parser.getint("performance", "codeql_memory"), 4000)
        self.assertEqual(parser.getint("performance", "codeql_threads"), 4)
