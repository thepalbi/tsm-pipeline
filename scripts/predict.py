#! /usr/bin/env python3

import argparse
import os
import requests
import shutil
import sys
import tempfile
from run import runTSM

def parse_arguments():
    parser = argparse.ArgumentParser()
    parser.add_argument("--query-name", dest="query_name", required=True, type=str,
                        choices=["NoSql", "Sql", "Xss", "TaintedPath"],
                        help="Name of the query to run.")
    parser.add_argument("--training-projects", dest="training_projects", required=True, type=str, 
                        nargs="+", metavar="PROJECT",
                        help="A list of projects to train on (specified either as LGTM.com slugs \
                          or as database names to be downloaded from Azure blob storage).")
    parser.add_argument("--test-projects", dest="test_projects", required=False, type=str,
                        nargs="+", default=None, metavar="PROJECT",
                        help="A list of projects to predict new taint specifications for \
                          (specified as LGTM.com  slugs).")
    parser.add_argument("--threshold", dest="threshold", required=False, type=float, default=0.5,
                        help="Minimum score a prediction needs to have to be included.")
    return parser.parse_args()

def metadata_files(query_name):
  if query_name == "NoSql":
      return "NosqlInjection", "NoSql"
  elif query_name == "Sql":
      return "SqlInjection", "Sql"
  elif query_name == "Xss":
      return "DomBasedXss", "Xss" 
  elif query_name == "TaintedPath":
      return "TaintedPath", "Path"
  else:
      sys.exit(f'Unknown query name {query_name}')

if __name__ == '__main__':
    arguments = parse_arguments()
    if arguments.test_projects is None:
      arguments.test_projects = arguments.training_projects

    codeql_cli = shutil.which("codeql")
    if codeql_cli is None:
      raise RuntimeError("CodeQL CLI not found")

    # get environment variable LGTM_TOKEN
    lgtm_token = os.environ['LGTM_TOKEN']
    if not lgtm_token:
      raise RuntimeError("LGTM_TOKEN is not set")

    tsm_ql = os.path.join(os.path.dirname(os.path.realpath(__file__)), '..', 'ql')

    lib, _ = metadata_files(arguments.query_name)
    scores_file = f'allscores_{lib}Worse_avg.txt'

    # write training projects to a temporary file
    with tempfile.NamedTemporaryFile(prefix="projects", mode="w", delete=False) as f:
      f.write("\n".join(arguments.training_projects))
      f.flush()

      runTSM(f.name, codeql_cli, tsm_ql, arguments.query_name, False)

      with open(scores_file, 'r') as f:
        scores = f.read()

      with open(os.path.join(tsm_ql, 'tsm', 'NodeRepresentation.qll'), 'r') as f:
        node_representation_lib = f.read()

      query="""
/** @kind problem */

""" + node_representation_lib + """

""" + scores + """

import semmle.javascript.security.dataflow.""" + lib + """

from DataFlow::Node nd, """ + lib + """::Configuration cfg, float score
where
  TsmRepr::getReprScore(rep(nd, true), "snk") = score and
  score >= """ + arguments.threshold + """ and
  not cfg.isSink(nd) and not cfg.isSink(nd, _)
select nd, "Predicted new sink (score " + score + ")."
"""

      for test_proj in arguments.test_projects:
        lgtm_url = f'https://lgtm.com/api/v1.0/projects/{test_proj}'
        response = requests.get(lgtm_url)
        response.raise_for_status()
        test_project_id = response.json()['id']

        lgtm_url = f'https://lgtm.com/api/v1.0/queryjobs?language=javascript&project-id={test_project_id}'
        headers = {
          'Content-Type': 'text/plain',
          'Accept': 'application/json',
          'Authorization': f'Bearer {lgtm_token}'
        }
        response = requests.post(lgtm_url, data=query, headers=headers)
        response.raise_for_status()
        query_console_url = response.json()['task-result']['result-url']
        print(f'LGTM.com query-console URL: {query_console_url}')
