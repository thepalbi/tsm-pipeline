import re
import ast
import functools
import gurobipy as gp

import numpy as np

from .config import SolverConfig


class GBTaintSpecConstraints:
    def __init__(self, variables, model:gp.Model, constraintsdir, config:SolverConfig):
        self.vars = variables
        self.model = model
        self.known_samples_ratio = config.known_samples_ratio
        self.exprParser = ConstraintParser()
        self.exprParser2 = ParseExpression(self.vars, format='gb')
        self.constraintsdir = constraintsdir
        self.lambda_const = config.lambda_const
        self.skip_flow_constraints = config.no_flow_constraints
        self.cache=dict()

    def clear_cache(self):
        self.cache = dict()

    def objective(self):
        c = []
        self.clear_cache()
        print("Computing objective...")
        c = [self.vars[v] for v in self.vars.keys() if v.startswith("eps")]
        c2 = [self.vars[v] for v in self.vars.keys() if not v.startswith("eps")]
        loss = gp.quicksum(c) + self.lambda_const * gp.quicksum(c2)
        return loss


    def exprToVal(self, constraint):
        return self.exprParser2.parse(constraint.strip())

    def exprToVal2(self, constraint):
        try:
            if str(constraint) in self.cache:
                return self.cache[str(constraint)]

            if isinstance(constraint, list) and len(constraint) == 1:
                if re.match("^[0-9.]+$",constraint[0]):
                    val=float(constraint[0].strip())
                    res=val
                else:
                    res=self.vars[constraint[0]]

                self.cache[str(constraint)] = res
                return res
            elif isinstance(constraint, str) and re.match("^[a-zA-Z0-9._]+$", constraint) is not None:
                if re.match("^[0-9.]+$",constraint):
                    val=float(constraint.strip())
                    res=val
                else:
                    res=self.vars[constraint]
                self.cache[constraint] = res
                return res
            elif isinstance(constraint, str):
                tokens = self.exprParser.parse(constraint)
                if isinstance(tokens[0], str):
                    res = self.exprToVal(tokens[0])
                else:
                    res=self.exprToVal(list(tokens[0]))
                self.cache[constraint] = res
                return res
            else:
                tokens = constraint

                result=self.exprToVal(tokens[0])
                i=1
                while i < len(tokens):
                    if tokens[i] == '+':
                        result = result + self.exprToVal(tokens[i + 1])
                    elif tokens[i] == '-':
                        result = result - self.exprToVal(tokens[i + 1])
                    elif tokens[i] == '*':
                        result = result * self.exprToVal(tokens[i + 1])
                    elif tokens[i] == '/':
                        result = result / self.exprToVal(tokens[i + 1])
                    i += 2

                self.cache[str(tokens)] = result
                return result
        except:
            import traceback as tb
            tb.print_exc()
            print(constraint)

    def add_constraints(self):
        self.clear_cache()
        c=1
        if not self.skip_flow_constraints:
            print("Computing flow constraints...")
            with open("{0}/constraints_flow.txt".format(self.constraintsdir)) as constraintsfile:
                for line in constraintsfile.readlines():
                    res = self.exprToVal(line)
                    self.model.addConstr(res <= 0)
                    c += 1
        else:
            print("Skipping flow constraints")

        print("Computing known constraints...")

        try:
            with open("{0}/constraints_known_src.txt".format(self.constraintsdir)) as constraintsfile:
                allines=constraintsfile.readlines()
                sampled=int(self.known_samples_ratio*len(allines)) if self.known_samples_ratio <= 1 else self.known_samples_ratio
                print("Sampling {0} of {1} known src constraints".format(sampled, len(allines)))
                for line in np.random.choice(allines, sampled):
                    for line_part in line.split(","):
                        if len(line_part) == 0:
                            continue
                        res = self.exprToVal(line_part)
                        self.model.addConstr(res <= 0)
                        c += 1
        except:
            print("No sources")


        try:
            with open("{0}/constraints_known_san.txt".format(self.constraintsdir)) as constraintsfile:
                allines = constraintsfile.readlines()
                sampled = int(self.known_samples_ratio * len(allines)) if self.known_samples_ratio <= 1 else self.known_samples_ratio
                print("Sampling {0} of {1} known san constraints".format(sampled, len(allines)))
                for line in np.random.choice(allines, sampled):
                    for line_part in line.split(","):
                        if len(line_part) == 0:
                            continue
                        res = self.exprToVal(line_part)
                        self.model.addConstr(res <= 0)
                        c += 1
        except:
            print("No sanitizers")

        try:
            with open("{0}/constraints_known_snk.txt".format(self.constraintsdir)) as constraintsfile:
                allines = constraintsfile.readlines()
                sampled = int(self.known_samples_ratio * len(allines)) if self.known_samples_ratio <= 1 else self.known_samples_ratio
                print("Sampling {0} of {1} known sink constraints".format(sampled, len(allines)))
                for line in np.random.choice(allines, sampled):
                    for line_part in line.split(","):
                        if len(line_part) == 0:
                            continue
                        res = self.exprToVal(line_part)
                        self.model.addConstr(res <= 0)
                        c += 1
        except:
            print("No sinks")

    def proxy_constraints(self):
        pass

    @property
    def num_constraints(self):
        return self.numconstraints
