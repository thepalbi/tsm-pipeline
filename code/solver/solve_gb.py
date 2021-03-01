import gurobipy as gp
from gurobipy import GRB
from .MyConstraintedProblem import GBTaintSpecConstraints
import shutil
from .config import SolverConfig
from orchestration.steps import CONSTRAINTS_DIR_KEY, MODELS_DIR_KEY
import os

import sys
sys.path.append("./cbc_utils")
import cbc_utils

def solveLpProblemGurobi(lpFilePath, lpResultsFilePath):
    try:
        m = gp.read(lpFilePath)
        m.optimize()
        zero = 0
        non_zero = 0
        ones = 0
        eps_non_zero = 0
        
        with open(lpResultsFilePath, "w") as resultfile:
            for v in m.getVars():
                if v.x == 0:
                    zero += 1
                elif v.x == 1:
                    ones += 1
                    if v.varName.startswith('e'):
                        eps_non_zero+=1
                else:
                    non_zero += 1
                    if v.varName.startswith('e'):
                        eps_non_zero+=1
            resultfile.write("\n".join(['{0}:{1}'.format(v.varName, v.x) for v in m.getVars()]))
        print('Obj: %g' % m.objVal)
        print('Zero: %g, Non-Zero: %g, Ones: %g, Eps: %g' % (zero, non_zero, ones, eps_non_zero))

    except gp.GurobiError as e:
        print('Error code ' + str(e.errno) + ': ' + str(e))

    except AttributeError:
        print('Encountered an attribute error')


def solve_constraints_combine_model(config: SolverConfig, ctx):
    constraintsdir = ctx[CONSTRAINTS_DIR_KEY]
    modelfile_path = os.path.join(ctx[MODELS_DIR_KEY], f"gurobi_model_{config.known_samples_ratio}_{1}.lp")
    # write minimization objective
    print("Writing minimization objective")
    print("Model file: %s" % modelfile_path)
    print("Constraint foler: %s" % constraintsdir)
    with open(modelfile_path, "w") as modelfile:
        modelfile.write("Minimize\n")
        modelfile.write(open(os.path.join(constraintsdir, "objective.txt")).read())
        modelfile.write("\n")

    # write constraints
    print("Writing flow and known constraints")
    with open(modelfile_path, "a") as modelfile:
        modelfile.write("Subject To\n")

    i=0
    with open(modelfile_path, "a") as modelfile:
        use_flow_constraints= not config.no_flow_constraints
        if use_flow_constraints:
            for l in open(os.path.join(constraintsdir, "constraints_flow.txt")).readlines():
                modelfile.write("R{0}: {1}\n".format(i,l.strip()))
                i += 1
            modelfile.flush()
            print("Done flows")
        else:
            print("Ignoring flows")
        try:
            for ltriple in open(os.path.join(constraintsdir, "constraints_known_src.txt")).readlines():
                for l in ltriple.split(","):
                    modelfile.write("R{0}: {1}\n".format(i, l ))
                    i += 1
            modelfile.flush()
        except:
            print("No known sources")

        try:
            for ltriple in open(os.path.join(constraintsdir, "constraints_known_san.txt"), encoding='utf-8').readlines():
                for l in ltriple.split(","):
                    modelfile.write("R{0}: {1}\n".format(i, l))
                    i += 1
            modelfile.flush()

        except:
            print("No known sanitizers")

        try:
            for ltriple in open(os.path.join(constraintsdir, "constraints_known_snk.txt"), encoding='utf-8').readlines():
                for l in ltriple.split(","):
                    modelfile.write("R{0}: {1} \n".format(i, l))
                    i += 1
            modelfile.flush()

        except:
            print("No known sinks")

        modelfile.write("\n")

    print("Writing Bounds")
    with open(modelfile_path, "a") as modelfile:
        modelfile.write("Bounds\n")
        for line in open(os.path.join(constraintsdir, "constraints_var.txt"), encoding='utf-8').readlines():
            if not line.startswith("0 "):
                modelfile.write("{0}\n".format(line.strip()))

    with open(modelfile_path, "a") as modelfile:
        modelfile.write("End")
    print("Done")

    resultsFilePath = os.path.join(ctx[MODELS_DIR_KEY], f"results_gb_{config.known_samples_ratio}_{config.lambda_const}_{1}.txt")
    if config.solver == "gurobi":
        print('Using Gurobi to solve')
        solveLpProblemGurobi(modelfile_path, resultsFilePath)
    elif config.solver == "CBC":
        print('Using CBC solve')
        cbc_utils.solveLpProblemCBC(modelfile_path, resultsFilePath)
    else:
        print(f'ERROR: {config.solver} is not a known solver')


# TODO: this function seems to not be used. Delete?
def solve_constraints(config: SolverConfig, ctx):
    constraintsdir = ctx[CONSTRAINTS_DIR_KEY]
    modelfile_path = os.path.join(ctx[MODELS_DIR_KEY], f"gurobi_model_{config.known_samples_ratio}_{1}.lp")
    modelfile_mps_path = os.path.join(ctx[MODELS_DIR_KEY], f"gurobi_model_{config.known_samples_ratio}_{1}.mps")

    for trial in range(1, config.trials+1):
        try:
            # Create a new model
            model = gp.Model("mip1")
            vars_to_train=[]
            vars=dict()
            totalvars=0
            with open("{0}/var.txt".format(constraintsdir)) as varsfile:
                for line in varsfile.readlines():
                    parts = line.split(":")
                    if "eps" in parts[0]:
                        v = model.addVar(vtype=GRB.CONTINUOUS, lb=0.0, name=parts[0])
                        totalvars += 1
                        vars_to_train.append(v)
                        vars[parts[0]] = v
                    else:
                        v = model.addVar(vtype=GRB.CONTINUOUS, lb=0.0, ub=1.0, name=parts[0])
                        totalvars += 1
                        vars_to_train.append(v)
                        vars[parts[0]] = v

            problem=GBTaintSpecConstraints(vars, model, constraintsdir, config)

            # create constraints
            problem.add_constraints()

            # Set objective
            model.setObjective(problem.objective(), GRB.MINIMIZE)

            model.write(modelfile_path)
            model.write(modelfile_mps_path)

            # Optimize model
            model.optimize()
            zero=0
            non_zero=0
            ones=0
            with open(os.path.join(ctx[MODELS_DIR_KEY], f"results_gb_{config.known_samples_ratio}_{config.lambda_const}_{1}.txt"), "w") as resultfile:
                for v in model.getVars():
                    resultfile.write('%s:%g\n' % (v.varName, v.x))
                    if v.x == 0:
                        zero+=1
                    elif v.x == 1:
                        ones+=1
                    else:
                        non_zero+=1

            print('Obj: %g' % m.objVal)
            print('Zero: %g, Non-Zero: %g, Ones: %g' % (zero, non_zero, ones))

        except gp.GurobiError as e:
            print('Error code ' + str(e.errno) + ': ' + str(e))

        except AttributeError:
            print('Encountered an attribute error')