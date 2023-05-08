from .config import SolverConfig
from orchestration.steps import CONSTRAINTS_DIR_KEY, MODELS_DIR_KEY
import os
from cbc_utils import solveLpProblemCBC
import logging


log = logging.getLogger(__name__)


def solve_constraints_combine_model(config: SolverConfig, ctx):
    constraintsdir = ctx[CONSTRAINTS_DIR_KEY]
    modelfile_path = os.path.join(ctx[MODELS_DIR_KEY], f"optimization_model_{config.known_samples_ratio}_{1}.lp")
    # write minimization objective
    log.info("Writing minimization objective")
    log.info("Model file: %s" % modelfile_path)
    log.info("Constraint folder: %s" % constraintsdir)
    with open(modelfile_path, "w") as modelfile:
        modelfile.write("Minimize\n")
        modelfile.write(open(os.path.join(constraintsdir, "objective.txt")).read())
        modelfile.write("\n")

    # write constraints
    log.info("Writing flow and known constraints")
    i=0
    with open(modelfile_path, "a") as modelfile:
        modelfile.write("Subject To\n")

        use_flow_constraints= not config.no_flow_constraints
        if use_flow_constraints:
            for l in open(os.path.join(constraintsdir, "constraints_flow.txt")).readlines():
                modelfile.write("R{0}: {1}\n".format(i,l.strip()))
                i += 1
            modelfile.flush()
            log.info("Done flows")
        else:
            log.info("Ignoring flows")
        try:
            for ltriple in open(os.path.join(constraintsdir, "constraints_known_src.txt")).readlines():
                for l in ltriple.split(","):
                    modelfile.write("R{0}: {1}\n".format(i, l ))
                    i += 1
            modelfile.flush()
        except:
            log.info("No known sources")

        try:
            for ltriple in open(os.path.join(constraintsdir, "constraints_known_san.txt"), encoding='utf-8').readlines():
                for l in ltriple.split(","):
                    modelfile.write("R{0}: {1}\n".format(i, l))
                    i += 1
            modelfile.flush()

        except:
            log.info("No known sanitizers")

        try:
            for ltriple in open(os.path.join(constraintsdir, "constraints_known_snk.txt"), encoding='utf-8').readlines():
                for l in ltriple.split(","):
                    modelfile.write("R{0}: {1} \n".format(i, l))
                    i += 1
            modelfile.flush()

        except:
            log.info("No known sinks")

        modelfile.write("\n")

    log.info("Writing Bounds")
    with open(modelfile_path, "a") as modelfile:
        modelfile.write("Bounds\n")
        for line in open(os.path.join(constraintsdir, "constraints_var.txt"), encoding='utf-8').readlines():
            if not line.startswith("0 "):
                modelfile.write("{0}\n".format(line.strip()))

    with open(modelfile_path, "a") as modelfile:
        modelfile.write("End")
    log.info("Done")

    resultsFilePath = os.path.join(ctx[MODELS_DIR_KEY], f"results_gb_{config.known_samples_ratio}_{config.lambda_const}_{1}.txt")
    solveLpProblemCBC(modelfile_path, resultsFilePath)