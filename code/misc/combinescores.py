import glob
import argparse
import logging
import os
import re
import numpy as np
import pandas as pd
from collections import defaultdict
from typing import Dict, List


# Create a new defaultdict, specialized on lists
def list_default_dict() -> Dict[str, List]:
    return defaultdict(list)


def combine_scores(query: str,
                    results_dir: str,
                    multiple: bool,
                    out_file: str):
    if multiple:
        files=glob.glob(os.path.join(results_dir) + "/multiple/{0}-*/reprScores.txt".format(query))
    else:
        # Filter by query type, selecting all timestampted result files
        g=os.path.join(results_dir) + "/*/{0}-*/reprScores.txt".format(query)
        print("g: {0}".format(g))
        files=glob.glob(g)
        files = list(filter(lambda p: os.path.join(results_dir, "multiple") not in p, files))
    last_files = list()
    projectsFiles = list_default_dict()
    
    # Divide results file per project
    for file in files:
        project = os.path.basename(os.path.dirname(os.path.dirname(file)))
        projectsFiles[project].append(file)
    
    # For each project, select the last produced file
    for project in projectsFiles.keys():
        projectsFiles[project].sort(key=os.path.getmtime)
        last_files.append(projectsFiles[project][-1])

    # Work on last files for each project
    files = last_files
    files.sort(key=os.path.getmtime)
    n=0
    src_dict = list_default_dict()
    snk_dict = list_default_dict()
    san_dict = list_default_dict()
    for reprScoreFile in files:
        if r'results\combined' not in reprScoreFile:
            n+=1
            for reprScopeLine in open(reprScoreFile).readlines():
                # From the project line, parse the repr, taint object type and score
                repr=re.findall("repr = \"([^\"]+)\"", reprScopeLine)[0]
                t=re.findall("t = \"([^\"]+)\"", reprScopeLine)[0]
                res=float(re.findall("result = ([0-9.]+)", reprScopeLine)[0])

                # Add up for each repr, the scores found
                if t == "src":
                    src_dict[repr].append(res)
                elif t == "snk":
                    snk_dict[repr].append(res)
                elif t == "san":
                    san_dict[repr].append(res)

    with open(out_file, "w") as scoresfile:
        scoresfile.writelines([
            "module TsmRepr {\n",""
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
        "   } \n",""
        "}\n"
        ])

if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    logging.basicConfig(level=logging.INFO, format="[%(levelname)s\t%(asctime)s] %(name)s\t%(message)s")


    parser.add_argument("--results-dir", dest="results_dir", required=True, type=str,
                        help="Directory of the results score")

    parser.add_argument("--query-name", dest="query_name", required=True, type=str,
                        choices=["NosqlInjectionWorse", "SqlInjectionWorse", "DomBasedXssWorse","TaintedPathWorse"],
                        help="Name of the query to solve")

    parser.add_argument("--multiple", dest="multiple", action='store_true', help='Use the result of a run of one combined result')

    parser.add_argument("--out", dest="out", type=str, required=True, help="Output file to write averaged results.")

    parsed_arguments = parser.parse_args()
    query_name = parsed_arguments.query_name
    results_dir = parsed_arguments.results_dir
    out_file = parsed_arguments.out

    # TODO: Add some feature to just combine scores from certain projects dbs. If not, it might take ones from another run
    # because of using the glob feature
    combine_scores(query_name, results_dir, parsed_arguments.multiple, out_file)
