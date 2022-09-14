import numpy as np
from sklearn.metrics import precision_score, recall_score, f1_score
from solver.config import SolverConfig
from orchestration import global_config
from orchestration.steps import RESULTS_DIR_KEY, CONSTRAINTS_DIR_KEY, MODELS_DIR_KEY, RESULTS_DIR_KEY, SOURCE_ENTITIES, SANITIZER_ENTITIES, SINK_ENTITIES
import os
import logging
import shutil


def getmetrics(actual, predicted, c):
    # Precision
    scores = dict()
    scores["actual"] = sum(actual)
    scores["predicted"] = sum(predicted)
    scores["precision"] = precision_score(actual, predicted)
    scores["recall"] = recall_score(actual, predicted)
    scores["f1"] = f1_score(actual, predicted)
    return scores


def compute_optimized_repr_scores(config: SolverConfig, ctx):
    for trainingsize in config.trainingsizes:
        do_compute_optimized_repr_scores(trainingsize, config, ctx)


def do_compute_optimized_repr_scores(trainingsize, config: SolverConfig, ctx):
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


def createReprPredicate(ctx, project_name: str, query_type: str, reprScoresFiles="reprScores.txt"):
    tsm_query_folder = os.path.join(global_config.sources_root, "tsm", "query")
    tsm_repr_pred_file = os.path.join(tsm_query_folder, "tsm_repr_pred.qll")
    repr_scores_path = os.path.join(ctx[RESULTS_DIR_KEY], reprScoresFiles)

    print(tsm_repr_pred_file)
    print(repr_scores_path)
    try:
        logging.info("Writing: {0}".format(repr_scores_path))

        with open(repr_scores_path, "r", encoding='utf-8') as reprscores:
            with open(tsm_repr_pred_file, "w", encoding='utf-8') as reprPrFile:
                reprPrFile.writelines([
                    "module TsmRepr {",
                    "float getReprScore(string repr, string t){\n"])
                reprscores = reprscores.readlines()
                if len(reprscores) > 0:
                    reprPrFile.writelines(reprscores)
                else:
                    reprPrFile.write(
                        '\t result = 0 and (t = "src" or t = "snk" or t = "san") and repr = ""\n')
                reprPrFile.writelines(["}", "}"])
        # create a TSM query in the results dir
        createTSMQuery(ctx, project_name, query_type)
    except Exception as e:
        print(e)


def createTSMQuery(ctx, project_name: str, query_type: str):
    tsm_folder = os.path.join(global_config.sources_root, "tsm")
    tsm_query_folder = os.path.join(tsm_folder, "query")
    tsm_repr_pred_file = os.path.join(tsm_query_folder, "tsm_repr_pred.qll")
    tsm_query_qll = os.path.join(tsm_query_folder, "tsm.qll")
    # for tsm_config and tsm we use one query tailored for query_type
    # this allows to compare against worse version
    tsm_query = os.path.join(tsm_folder, query_type, "TSM.ql")
    tsm_config = os.path.join(tsm_folder, query_type, "tsm_config.qll")

    results_dir = ctx[RESULTS_DIR_KEY]
    query_dir = os.path.join(results_dir, query_type)
    print(query_dir)
    if not os.path.exists(query_dir):
        os.makedirs(query_dir)
    shutil.copy(tsm_repr_pred_file, query_dir)
    shutil.copy(tsm_query, query_dir)
    shutil.copy(tsm_query_qll, query_dir)
    shutil.copy(tsm_config, query_dir)