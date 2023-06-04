import numpy as np
from sklearn.metrics import precision_score, recall_score, f1_score
from solver.config import SolverConfig
from orchestration import global_config
from orchestration.steps import RESULTS_DIR_KEY, CONSTRAINTS_DIR_KEY, MODELS_DIR_KEY, RESULTS_DIR_KEY, SOURCE_ENTITIES, SANITIZER_ENTITIES, SINK_ENTITIES
import os
import logging
import shutil

log = logging.getLogger(__name__)


def compute_optimized_repr_scores(config: SolverConfig, ctx):
    for trainingsize in config.trainingsizes:
        do_compute_optimized_repr_scores(trainingsize, config, ctx)


def do_compute_optimized_repr_scores(trainingsize, config: SolverConfig, ctx):
    """
    do_compute_optimized_repr_scores translate the infer process results into both a query file
    and a csv for later usage by the evaluation pipeline.

    :param _type_ trainingsize: _description_
    :param SolverConfig config: _description_
    :param _type_ ctx: _description_
    """
    lambda_const = config.lambda_const
    trials = config.trials

    _src = "s"
    _san = "a"
    _snk = "i"
    event_to_rep_id_path = os.path.join(
        ctx[CONSTRAINTS_DIR_KEY], "eventToRepIDs.txt")
    rep_to_id_path = os.path.join(ctx[CONSTRAINTS_DIR_KEY], "repToID.txt")

    for trial in range(1, trials+1):
        logging.info("Reading: {0}".format(event_to_rep_id_path))
        events = open(event_to_rep_id_path, 'r', errors='replace',
                      encoding='utf-8').readlines()
        results = open(
            f"{ctx[MODELS_DIR_KEY]}/results_gb_{trainingsize}_{lambda_const}_{trial}.txt", encoding='utf-8').readlines()
        reprs = open(rep_to_id_path, 'r', errors='replace',
                     encoding='utf-8').readlines()
        vars = dict()
        for r in results:
            vars[r.split(":")[0]] = float(r.split(":")[1])
        eventScores = dict()
        allevents = []
        allevents2 = dict()
        for e in events:
            name = ":".join(e.split(":")[:-1])

            # check if the event has associated variables
            if e.find(":n") >= 0:
                reps = e.split(":")[-1].split(",")
                srcscores = 0.0
                snkscores = 0.0
                sanscores = 0.0
                for r in reps:
                    r = r.strip()
                    #print("Rep: ", r)
                    srcscores += vars[r+_src]
                    snkscores += vars[r+_snk]
                    sanscores += vars[r+_san]
                eventScores[name + ":src"] = srcscores / len(reps)
                eventScores[name + ":san"] = sanscores / len(reps)
                eventScores[name + ":snk"] = snkscores / len(reps)
            else:
                reps = []
                eventScores[name + ":src"] = 0
                eventScores[name + ":san"] = 0
                eventScores[name + ":snk"] = 0
            allevents.append(name)
            allevents2[name] = reps

        repConstraints = []
        reprToWrite = None
        for repr in reprs:
            if repr.find(":n") >= 0:
                repid = repr.split(":")[-1].strip()
                rep = ":".join(repr.split(":")[0:-1])
                reprToWrite = None
                if vars[repid+_src] > 0.0:
                    reprToWrite = "repr = \"{0}\" and t = \"{1}\" and result = {2}".format(rep, "src", "%.10f"
                                                                                           % vars[repid + _src])

                if vars[repid+_snk] > 0.0:
                    reprToWrite = "repr = \"{0}\" and t = \"{1}\" and result = {2}".format(rep, "snk", "%.10f"
                                                                                           % vars[repid + _snk])

                if vars[repid+_san] > 0.0:
                    reprToWrite = "repr = \"{0}\" and t = \"{1}\" and result = {2}".format(rep, "san", "%.10f"
                                                                                           % vars[repid + _san])

            if reprToWrite is not None:
                repConstraints.append(reprToWrite)

        repr_scores_file_path = os.path.join(
            ctx[RESULTS_DIR_KEY], "reprScores.txt")
        logging.info("Writing reprScores: {0}".format(repr_scores_file_path))
        if not os.path.exists(ctx[RESULTS_DIR_KEY]):
            logging.info("Creating folder: {0}".format(ctx[RESULTS_DIR_KEY]))
            os.mkdir(ctx[RESULTS_DIR_KEY])

        with open(repr_scores_file_path, "w", encoding='utf-8') as reprscores:
            sizeReprSet = len(repConstraints)
            countRepr = 0
            # sort constraints before writing to enforce determinism
            repConstraints.sort()
            for repConstraint in repConstraints:
                countRepr = countRepr + 1
                if countRepr < sizeReprSet:
                    repConstraint = repConstraint + "  or "
                repConstraint = repConstraint + "\n"
                reprscores.write(repConstraint)


def create_getReprScore_query_file(ctx, query_type: str, reprScoresFiles="reprScores.txt"):
    """
    create_getReprScore_query_file creates a new query file containing the getReprScore CodeQL function, which
    let's CodeQL interface with the facts learned through TSM.

    :param _type_ ctx: Orchestrator context
    :param str query_type: Query type
    :param str reprScoresFiles: Result learned scores file, defaults to "reprScores.txt"
    """
    # <sources root>/tsm/query/tsm_repr_pred.qll
    get_repr_score_query_file = os.path.join(
        global_config.sources_root, "tsm", "query", "tsm_repr_pred.qll")
    repr_scores_path = os.path.join(ctx[RESULTS_DIR_KEY], reprScoresFiles)

    try:
        with open(repr_scores_path, "r", encoding='utf-8') as score_results:
            with open(get_repr_score_query_file, "w", encoding='utf-8') as out:
                # TODO: Change this ad-hoc file writing to jinja if much used
                # https://jinja.palletsprojects.com/en/3.1.x/api/#jinja2.Template
                out.writelines([
                    "module TsmRepr {",
                    "float getReprScore(string repr, string t){\n"])
                score_results = score_results.readlines()
                if len(score_results) > 0:
                    out.writelines(score_results)
                else:
                    out.write(
                        '\t result = 0 and (t = "src" or t = "snk" or t = "san") and repr = ""\n')
                out.writelines(["}", "}"])

        # Copy getReprScore query file into results dir as well
        results_dir = ctx[RESULTS_DIR_KEY]
        result_query_dir = os.path.join(results_dir, query_type)
        shutil.copy(get_repr_score_query_file, result_query_dir)
    except Exception as e:
        log.error("Failed to create CodeQL result query file. Err: %s", e)
