import glob
import argparse
import logging
import os
import re
import numpy as np
import pandas as pd
from collections import defaultdict
from typing import Dict, List, Optional


log = logging.getLogger(__name__)


# Create a new defaultdict, specialized on lists
def list_default_dict() -> Dict[str, List]:
    return defaultdict(list)


def combine_scores(results_dir: str,
                   multiple: bool,
                   out_file: str,
                   raw_out_file: Optional[str]):
    if multiple:
        files = glob.glob(os.path.join(results_dir) +
                          "/multiple/reprScores.txt")
    else:
        # Filter by query type, selecting all timestampted result files
        g = os.path.join(results_dir) + "/*/reprScores.txt"
        log.info("globbing folder: {0}".format(g))
        files = glob.glob(g)
        files = list(filter(lambda p: os.path.join(
            results_dir, "multiple") not in p, files))

    log.info("working on %d reprScores files", len(files))

    n = 0
    src_dict = list_default_dict()
    snk_dict = list_default_dict()
    san_dict = list_default_dict()
    for reprScoreFile in files:
        if r'results\combined' not in reprScoreFile:
            # count files
            n += 1
            with open(reprScoreFile, "r") as f:
                for reprScopeLine in f.readlines():
                    # From the project line, parse the repr, taint object type and score
                    repr = re.findall("repr = \"([^\"]+)\"", reprScopeLine)[0]
                    # t is the type of node, either snk, src or san
                    t = re.findall("t = \"([^\"]+)\"", reprScopeLine)[0]
                    # results is the score
                    res = float(re.findall("result = ([0-9.]+)", reprScopeLine)[0])

                    # Add up for each repr, the scores found
                    if t == "src":
                        src_dict[repr].append(res)
                    elif t == "snk":
                        snk_dict[repr].append(res)
                    elif t == "san":
                        san_dict[repr].append(res)

    with open(out_file, "w") as scoresfile:
        scoresfile.writelines([
            "module TsmRepr {\n", ""
            "  float getReprScore(string repr, string t){\n"
        ])
        # IMPORANT!!!
        # we are currently only writing combined scores for sinks
        # to add sources and sanitizers simple add a similar line with src_dict and san_dict
        scoresfile.write(" or\n".join(["   repr = \"{0}\" and t = \"{1}\" and result = {2}".format(k, "snk",  "%.10f"
                                                                                                   % np.mean(snk_dict[k])) for k in sorted(snk_dict.keys())]))
        if len(snk_dict.keys()) == 0:
            scoresfile.write("   none()")
        scoresfile.writelines([
            "\n",
            "   } \n", ""
            "}\n"
        ])

    if raw_out_file != None:
        with open(raw_out_file, "w") as scoresfile:
            # TODO: See belo!
            # IMPORANT!!!
            # we are currently only writing combined scores for sinks
            # to add sources and sanitizers simple add a similar line with src_dict and san_dict

            scoresfile.write("\n".join(
                [
                    # external float getReprScore(string repr, string t);
                    "\"{0}\",\"{1}\",{2}".format(
                        k, "snk",  "%.10f" % np.mean(snk_dict[k]))
                    for k in sorted(snk_dict.keys())
                ]
            ))


if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    logging.basicConfig(
        level=logging.INFO, format="[%(levelname)s\t%(asctime)s] %(name)s\t%(message)s")

    parser.add_argument("--results-dir", dest="results_dir", required=True, type=str,
                        help="Directory of the results score")

    parser.add_argument("--query-name", dest="query_name", required=True, type=str,
                        choices=["NosqlInjectionWorse", "SqlInjectionWorse",
                                 "DomBasedXssWorse", "TaintedPathWorse"],
                        help="Name of the query to solve")

    parser.add_argument("--multiple", dest="multiple", action='store_true',
                        help='Use the result of a run of one combined result')

    parser.add_argument("--out", dest="out", type=str, required=True,
                        help="Output file to write averaged results.")
    parser.add_argument("--raw-out", dest="raw_out", type=str, required=True,
                        help="Output file to write averaged results, in a CSV external predicate facts.")

    parsed_arguments = parser.parse_args()
    query_name = parsed_arguments.query_name
    results_dir = parsed_arguments.results_dir
    out_file = parsed_arguments.out
    raw_out_file = parsed_arguments.raw_out

    # TODO: Add some feature to just combine scores from certain projects dbs. If not, it might take ones from another run
    # because of using the glob feature
    combine_scores(results_dir,
                   parsed_arguments.multiple, out_file, raw_out_file)
