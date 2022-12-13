import argparse
import os
import glob
import pandas as pd
from utils.logging import get_stdout_logger
import logging

log = get_stdout_logger("calculate-scores", level=logging.DEBUG)

if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--results-boost", dest="result_boost", type=str, required=True,
                        help="Directory path with worse and boosted query results for calculting learning scores")
    parser.add_argument("--results-v0", dest="result_v0", type=str, required=True,
                        help="Directory path with v0 query results for calculting learning scores")
    args = parser.parse_args()

    if not os.path.isdir(args.result_boost):
        raise Exception("Expected results boost path to be a directory")
    if not os.path.isdir(args.result_v0):
        raise Exception("Expected results v0 path to be a directory")

    results_boost = {}
    results_v0 = {}

    for f in glob.glob(os.path.join(args.result_boost, "*.csv")):
        results_boost[os.path.basename(f)] = pd.read_csv(f)

    for f in glob.glob(os.path.join(args.result_v0, "*.csv")):
        results_v0[os.path.basename(f)] = pd.read_csv(f)

    log.info("Read total %s results", len(results_boost) + len(results_v0))
