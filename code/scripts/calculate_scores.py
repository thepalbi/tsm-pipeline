from sklearn.metrics import accuracy_score, precision_score, recall_score
from typing import Iterable, Set, Tuple
import pandas as pd
import glob
import os
import re
from utils.logging import get_stdout_logger
"""tesis scores.ipynb

Automatically generated by Colaboratory.

Original file is located at
    https://colab.research.google.com/drive/1Xrk9z0PcyIPlod4aqLG8_GiP69XTLc4r
"""

log = get_stdout_logger("calculate_scores")


def calculate_scores(
    results_folder: str,
    cleanup_base_dir="/tesis/tmp"
) -> Tuple[float, float, float]:
    # Take as input results folder, and assume that there exists a `v0` and `worse` folder with the evaluation results
    v0_dir = "v0/"
    boost_dir = "worse/"

    results_boost = {}
    results_v0 = {}

    for f in glob.glob(os.path.join(results_folder, boost_dir, "*.csv")):
        results_boost[os.path.basename(f)] = pd.read_csv(f)

    for f in glob.glob(os.path.join(results_folder, v0_dir, "*.csv")):
        results_v0[os.path.basename(f)] = pd.read_csv(f)

    log.debug("Read total %s dataframes" % (len(results_boost) + len(results_v0)))

    # Post-processing required for results:
    # - remove the leading /tesis/tmp/*/ from the filePathSource and filePathSink columns
    # - drop score
    # - drop the origin worse results

    # Post-processing results
    # Clean filePath* columns
    def cleanup_filePath_col(value: str) -> str:
        # /tesis/tmp/78fi2yky
        leading_replace_pat = "%s/[a-zA-Z0-9]+/" % (cleanup_base_dir)
        return re.sub(leading_replace_pat, "", value)

    # This bit below will cleanup the /tesis/tmp/[a-zA-Z0-9]+ bit of the path column in the results
    for df in results_boost.values():
        # Cleanup filePath* columns
        df['filePathSource'] = df['filePathSource'].map(cleanup_filePath_col)
        df['filePathSink'] = df['filePathSink'].map(cleanup_filePath_col)

    for df in results_v0.values():
        df['filePathSource'] = df['filePathSource'].map(cleanup_filePath_col)
        df['filePathSink'] = df['filePathSink'].map(cleanup_filePath_col)

    # utility function used for hashing each row in a consistent way, so they
    # can be operated in sets
    def hash_tuple(x: Tuple):
        return "#".join([
            str(v) for v in x
        ])

    # Now, generate the a set for worse, v0 and boosted alone
    v0 = set()
    worse = set()
    boosted = set()

    # cleanup of each dataframe, dropping columns that will not give repeatable results between
    # evaluation sets.
    def cleanup(df):
        return df.drop(["score", "origin"], axis=1)

    # Calculate v0 set
    for df in results_v0.values():
        # Drop non hashed columns
        df = cleanup(df)
        # hash and add to set
        v0 = v0 | set(df.apply(lambda x: hash_tuple(tuple(x)), axis=1))

    # Calculate boosted
    for df in results_boost.values():
        # filter out boosted
        df = df[df['origin'] == 'boosted']
        df = cleanup(df)
        boosted = boosted | set(
            df.apply(lambda x: hash_tuple(tuple(x)), axis=1))

    # Calculate worse
    for df in results_boost.values():
        # filter out boosted
        df = df[df['origin'] == 'worse']
        df = cleanup(df)
        worse = worse | set(df.apply(lambda x: hash_tuple(tuple(x)), axis=1))

    all = v0 | worse | boosted

    log.info("Result sets sizes: Worse %d, Boosted %d, V0 %d, All %d" %
             (len(worse), len(boosted), len(v0), len(all)))

    # set(results_v0['FurutaTakuto_infoVis2017_7b7aa8999b4233eb2b9e5fc7d3ba6488b80ed141.csv'].apply(lambda t: hash_tuple(t), axis=1))

    # Helper function to make a set iterable in a repeatable order. Used for generating
    # the item sets required by the score calculation functions in sklearn

    def repeatable_for_each_set(s: Set[int]) -> Iterable[int]:
        return sorted(list(s))

    y_pred = [
        int(it in boosted)
        for it in repeatable_for_each_set(all)
    ]
    y_true = [
        int(it in v0)
        for it in repeatable_for_each_set(all)
    ]

    precision = precision_score(y_true, y_pred, pos_label=1)
    recall = recall_score(y_true, y_pred, pos_label=1)
    accuracy = accuracy_score(y_true, y_pred)
    log.info("Score results: Precision: %.4f. Recall: %.4f. Accuracy: %.4f" % (precision, recall, accuracy))
    return precision, recall, accuracy

if __name__ == "__main__":
    import argparse
    parser = argparse.ArgumentParser()
    parser.add_argument(
        "--results-dir",
        dest="results_dir",
        help="Directory where results are hosted. Must contain a `v0` and `worse` folder.",
        type=str
        )
    parser.add_argument(
        "--debug",
        help="Enable debug logging",
        type=bool,
        action=argparse.BooleanOptionalAction
        )

    args = parser.parse_args()
    if args.debug:
        import logging
        log.setLevel(logging.DEBUG)
    calculate_scores(args.results_dir)