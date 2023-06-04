from DataParser import readEvents, readKnown, readFlowsAndReps, readPairs
from Variable import Variable
from Event import Event
import Constraint
import os

from orchestration.steps import SOURCE_ENTITIES, SINK_ENTITIES, SANITIZER_ENTITIES, \
    SRC_SAN_TUPLES_ENTITIES, SAN_SNK_TUPLES_ENTITIES, REPR_MAP_ENTITIES


def search(values, searchFor):
    for k in values:
        for v in values[k]:
            if searchFor in v:
                return k
    return None


def safe_str(obj):
    try:
        return str(obj)
    except UnicodeEncodeError:
        return obj.encode('utf-8', 'replace').decode('ascii', 'replace')
    return ""


class ConstraintBuilder:
    def __init__(self, mode, outputdir, min_rep_events, dataset_type, constraint_format, lambda_const, working_dir):
        self.events = dict()
        self.unique_reps = dict()
        self.reps_map = dict()
        self.mode = mode
        self.outputdir = outputdir
        os.makedirs(outputdir, exist_ok=True)
        self.working_dir = working_dir
        self.delete_old_constraints()
        # variables refer to actual program elements variables
        self.variables = dict()
        # eps_vars refers to the epsilons relaxing the model
        self.eps_vars = list()
        self.known_sources = dict()
        self.known_sinks = dict()
        self.known_sanitizers = dict()
        self.rep_count = dict()
        self.min_rep_events = min_rep_events
        self.dataset_type = dataset_type
        self.constraint_format = constraint_format
        self.lambda_const = lambda_const
        self._src = "s"
        self._san = "a"
        self._snk = "i"
        self._eps = "e"

    def set_output_dir(self, newdir):
        self.outputdir = newdir

    def readEventsAndReps(self, projectdir, ctx):
        readEvents(ctx[REPR_MAP_ENTITIES],
                   self.events,
                   self.unique_reps,
                   self.rep_count,
                   ctx)

    def createBlackList(self):
        blacklist = []
        for k in self.known_sources.keys():
            for src in self.known_sources[k]:
                if src not in self.events.keys():
                    continue
                src_reps = set(self.events[src].reps)

                for k2 in self.known_sinks.keys():
                    for snk in self.known_sinks[k2]:
                        if snk not in self.events.keys():
                            continue
                        snk_reps = set(self.events[snk].reps)
                        if len(src_reps.intersection(snk_reps)) > 0:
                            blacklist.append(src)
                            blacklist.append(snk)

                for k3 in self.known_sanitizers.keys():
                    for san in self.known_sanitizers[k3]:
                        if san not in self.events.keys():
                            continue
                        san_reps = set(self.events[san].reps)
                        if len(src_reps.intersection(san_reps)) > 0:
                            blacklist.append(src)
                            blacklist.append(san)

        for k in self.known_sinks.keys():
            for snk in self.known_sinks[k]:
                if snk not in self.events.keys():
                    continue
                snk_reps = set(self.events[snk].reps)
                for k2 in self.known_sanitizers.keys():
                    for san in self.known_sanitizers[k2]:
                        if san not in self.events.keys():
                            continue
                        san_reps = set(self.events[san].reps)
                        if len(snk_reps.intersection(san_reps)) > 0:
                            blacklist.append(snk)
                            blacklist.append(san)
        return list(set(blacklist))

    def createBlackList2(self, sources, sinks, sanitizers):
        # ignoring sanitizers for now
        blacklist = []
        for source in sources:
            if source not in self.events.keys():
                continue
            source_reps = set(self.events[source].reps)
            for sink in sinks:
                if sink not in self.events.keys():
                    continue
                sink_reps = set(self.events[sink].reps)
                if len(source_reps.intersection(sink_reps)) > 0:
                    blacklist.append(source)
                    blacklist.append(sink)
            for san in sanitizers:
                if san not in self.events.keys():
                    continue
                san_reps = set(self.events[san].reps)
                if len(source_reps.intersection(san_reps)) > 0:
                    blacklist.append(source)
                    blacklist.append(san)

        for sink in sinks:
            if sink not in self.events.keys():
                continue
            sink_reps = set(self.events[sink].reps)
            for san in sanitizers:
                if san not in self.events.keys():
                    continue

                san_reps = set(self.events[san].reps)
                if len(sink_reps.intersection(san_reps)) > 0:
                    blacklist.append(sink)
                    blacklist.append(san)

        return list(set(blacklist))

    def getVar(self, rep, suffix="") -> str:
        return "n{0}{1}".format(self.unique_reps[rep], suffix)

    # When constraint_type == "known" it returns a tuple (constraint, rep count)
    def getBackOffVar(self, event: Event, suffix: str, constraint_type="flow") -> str:
        reps = event.reps
        if len(reps) == 0:
            assert False, "No Reps"
        elif len(reps) > 1:
            if self.constraint_format == "gb":
                if constraint_type == "known":
                    # sum over backoff vars
                    return " + ".join([self.getVar(r, suffix) for r in reps]), len(reps)
                else:
                    # average over backoff vars
                    factor = "{0:.2f}".format(1.0/len(reps))
                    return " + ".join([factor + " " + self.getVar(r, suffix) for r in reps])
            else:
                return "({0})/{1}".format("+".join([self.getVar(r, suffix) for r in reps]), len(reps))
        else:
            # len(reps) == 1
            if constraint_type == "flow":
                return "{0}".format(" + ".join([self.getVar(r, suffix) for r in reps]))
            else:
                return "{0}".format(" + ".join([self.getVar(r, suffix) for r in reps])), 1

    def printKnownConstraints(self,  event, map: dict):
        # TODO: What's that list(map.keys())[0] in the filename?
        with open("{0}/constraints_known_{1}.txt".format(self.outputdir, list(map.keys())[0]), "a+") as constraintsfile:
            src_var, src_rhs = self.getBackOffVar(event, self._src, "known")
            constraintsfile.write(
                Constraint.print(src_var,
                                 src_rhs if "src" in map else "0", Constraint.Constraint.LTE, format='norm'))
            constraintsfile.write(",")
            constraintsfile.write(
                Constraint.print(src_var,
                                 src_rhs if "src" in map else "0", Constraint.Constraint.GTE, format='norm'))
            constraintsfile.write(",")

            san_var, san_rhs = self.getBackOffVar(event, self._san, "known")
            constraintsfile.write(
                Constraint.print(san_var,
                                 str(san_rhs) if "san" in map else "0", Constraint.Constraint.LTE, format='norm'))
            constraintsfile.write(",")
            constraintsfile.write(
                Constraint.print(san_var,
                                 str(san_rhs) if "san" in map else "0", Constraint.Constraint.GTE, format='norm'))
            constraintsfile.write(",")

            snk_var, snk_rhs = self.getBackOffVar(event, self._snk, "known")
            constraintsfile.write(
                Constraint.print(snk_var,
                                 str(snk_rhs) if "snk" in map else "0", Constraint.Constraint.LTE, format='norm'))
            constraintsfile.write(",")
            constraintsfile.write(
                Constraint.print(snk_var,
                                 str(snk_rhs) if "snk" in map else "0", Constraint.Constraint.GTE, format='norm'))
            constraintsfile.write("\n")

    def delifexists(self, f):
        if os.path.exists(f):
            os.remove(f)

    def delete_old_constraints(self):
        self.delifexists("{0}/constraints_var.txt".format(self.outputdir))
        self.delifexists("{0}/constraints_flow.txt".format(self.outputdir))
        self.delifexists("{0}/constraints_known.txt".format(self.outputdir))
        self.delifexists(
            "{0}/constraints_known_src.txt".format(self.outputdir))
        self.delifexists(
            "{0}/constraints_known_san.txt".format(self.outputdir))
        self.delifexists(
            "{0}/constraints_known_snk.txt".format(self.outputdir))
        self.delifexists("{0}/var.txt".format(self.outputdir))

    def createVariables(self, ctx):
        print("Creating variables")

        rep_to_id_path = os.path.join(self.outputdir, "repToID.txt")
        with open(rep_to_id_path, "w", encoding='utf-8') as repToIDfile:
            newvars = [["n{0}{1}".format(self.unique_reps[k], self._src),
                        "n{0}{1}".format(self.unique_reps[k], self._san),
                       "n{0}{1}".format(self.unique_reps[k], self._snk)]
                       for k in self.unique_reps.keys()]
            print("Built vars")
            for k in newvars:
                self.variables[k[0]] = Variable(k[0])
                self.variables[k[1]] = Variable(k[1])
                self.variables[k[2]] = Variable(k[2])
            print("Done variables")

            repToIDfile.write("\n".join(["{0}:n{1}".format(safe_str(k), safe_str(
                self.unique_reps[k])) for k in self.unique_reps.keys()]))

            print("Wrote to file")

        event_to_rep_ids_path = os.path.join(
            self.outputdir, "eventToRepIDs.txt")
        with open(event_to_rep_ids_path, "w", encoding='utf-8') as eventToRepIDs:
            for e in self.events.keys():
                repIDs = ["n{0}".format(safe_str(self.unique_reps[rep]))
                          for rep in self.events[e].reps]
                eventToRepIDs.write("{0}:{1}\n".format(
                    safe_str(e), ",".join(repIDs)))

    def readAllKnown(self, projectdir, query, query_type, use_all_sanitizers, ctx):
        # constraints for known sources
        print("Constraints for known events")
        known_sources = readKnown(ctx[SOURCE_ENTITIES], "sources", query)
        known_sinks = readKnown(ctx[SINK_ENTITIES], "sinks", query)
        if use_all_sanitizers:
            print("Using all sanitizers")
            # TO-DO: Check last parameter: Is None or should be removed?
            known_sanitizers = readKnown(
                ctx[SANITIZER_ENTITIES], "sanitizers", None)
        else:
            known_sanitizers = readKnown(
                ctx[SANITIZER_ENTITIES], "sanitizers", query)
        self.known_sources[projectdir] = known_sources
        self.known_sinks[projectdir] = known_sinks
        self.known_sanitizers[projectdir] = known_sanitizers

    def writeKnownConstraints(self, ctx):
        print("Computing blacklist")
        blacklist = self.createBlackList()

        if len(blacklist) > 0:
            print(blacklist)
            print("Events in blacklist: {0}".format(len(blacklist)))

        set_sources = 0
        for k in self.known_sources:
            for src in self.known_sources[k]:
                set_sources += self.setKnownConstraints(
                    src, self._src, blacklist)

        set_sinks = 0
        for k in self.known_sinks:
            for sink in self.known_sinks[k]:
                set_sinks += self.setKnownConstraints(
                    sink, self._snk, blacklist)

        set_san = 0
        for k in self.known_sanitizers:
            for san in self.known_sanitizers[k]:
                set_san += self.setKnownConstraints(san, self._san, blacklist)

        print("Known sources: %d" % set_sources, end=',')
        print("Known sanitizers: %d" % set_san, end=',')
        print("Known sinks: %d" % set_sinks)

    """
    Sets set a determined constrainst variable to 1 according to its kind [Source, Sink, Sanitizer]
    """

    def setKnownConstraints(self, event, kind, blacklist):
        #  TO_DO: Improve to avoid if statements
        k_src = 0.0
        k_san = 0.0
        k_snk = 0.0

        if kind == self._src:
            k_src = 1.0
            kText = "src"
        if kind == self._san:
            k_san = 1.0
            kText = "san"
        if kind == self._snk:
            k_snk = 1.0
            kText = "snk"

        count = 0
        if event not in self.events.keys() or event in blacklist:
            return count

        count += 1
        self.printKnownConstraints(self.events[event], {kText: "1"})
        for rep in self.events[event].reps:
            if rep not in self.unique_reps:
                continue

            srcVar = self.getVar(rep, self._src)
            sanVar = self.getVar(rep, self._san)
            snkVar = self.getVar(rep, self._snk)
            self.variables[srcVar].set_constant(k_src)
            self.variables[sanVar].set_constant(k_san)
            self.variables[snkVar].set_constant(k_snk)

        return count

    def writeVarConstrants(self, ctx):
        # output var.txt and constraints_var.txt
        var_path = os.path.join(self.outputdir, "var.txt")
        with open(var_path, "w") as varfile:
            varfile.write("\n".join([self.variables[v].print()
                          for v in self.variables.keys()]))
            varfile.write("\n")

        with open(var_path, "a") as varfile:
            varfile.write("\n".join([v+":variable" for v in self.eps_vars]))
            varfile.write("\n")

        # output constraints.txt
        constraints_var_path = os.path.join(
            self.outputdir, "constraints_var.txt")
        with open(constraints_var_path, "a+") as constraintsfile:
            constraintsfile.write("\n".join([Constraint.print(self.variables[v].id, "1", Constraint.Constraint.LTE, format='norm')
                                             for v in self.variables.keys() if not self.variables[v].is_constant]))
            constraintsfile.write("\n")
            constraintsfile.write("\n".join([Constraint.print(self.variables[v].id, "0", Constraint.Constraint.GTE, format='norm')
                                             for v in self.variables.keys() if not self.variables[v].is_constant]))
            constraintsfile.write("\n")

        with open(constraints_var_path, "a") as constraintsfile:
            constraintsfile.write("\n".join([Constraint.print(
                v, "0", Constraint.Constraint.GTE, format='norm') for v in self.eps_vars]))
            constraintsfile.write("\n")

    def ff(self, row, events, flow_list, other):
        sinks = list(other[other["ssan"] == row["ssan"]]["ssnk"])
        pass

    def compute_source_sanit_sink_fromPairs(self, projectdir, ctx):
        """ Generates the following mappings that are handy to the generation of the flow constraints for the model
        It computes the join  of the pairs (src,san) and (san, snk) obtained from  the PropagationGraph  
        source_sanit: (src,san)-> [snk], 
        source_sink:  (src,snk) -> [san], 
        sanit_sink: (san,snk) -> [src]
        """
        # TODO: Propagate below paths on context from previous step
        src_san_pairs = readPairs(ctx[SRC_SAN_TUPLES_ENTITIES], self.events)
        print("src_san_pairs:", len(src_san_pairs))
        san_src_map = {k: g["ssrc"].tolist()
                       for k, g in src_san_pairs.groupby("ssan")}
        print("src_san:", len(san_src_map))

        san_snk_pairs = readPairs(ctx[SAN_SNK_TUPLES_ENTITIES], self.events)
        print("src_san_pairs:", len(san_snk_pairs))

        san_snk_map = {k: g["ssnk"].tolist()
                       for k, g in san_snk_pairs.groupby("ssan")}
        print("san_snk:", len(san_snk_map))

        source_sanit = dict()
        source_sink = dict()
        sanit_sink = dict()

        srcNotFound = 0
        sanNotFound = 0
        snkNotFound = 0

        for san in san_snk_map.keys():
            # sanit_sink will contain for every pair of sanit -> sink, the possible
            # sources that complete the triplet.
            sources = san_src_map[san]

            for snk in san_snk_map[san]:
                if san in self.events and snk in self.events:
                    sanit_sink_tuple = (self.events[san], self.events[snk])

                    sanit_sink[sanit_sink_tuple] = list()
                    for src in sources:
                        if src in self.events:
                            sanit_sink[sanit_sink_tuple].append(
                                self.events[src])
                        else:
                            srcNotFound = srcNotFound + 1

                    for src in sources:
                        # source_sink will contain for every pair of source -> sink, the possible
                        # sanitizers that complete the triplet.
                        if src in self.events and snk in self.events:
                            source_sink_tuple = (
                                self.events[src], self.events[snk])
                            source_sink_list = []
                            if source_sink_tuple in source_sink:
                                source_sink_list = source_sink.get(
                                    source_sink_tuple)
                            else:
                                source_sink[source_sink_tuple] = source_sink_list
                            source_sink_list.append(self.events[san])

                            # source_sanit will contain for every pair of source -> sanit, the possible
                            # sinks that complete the triplet.
                            source_sanit_tuple = (
                                self.events[src], self.events[san])
                            source_sanit_list = []
                            if source_sanit_tuple in source_sanit:
                                source_sanit_list = source_sanit.get(
                                    source_sanit_tuple)
                            else:
                                source_sanit[source_sanit_tuple] = source_sanit_list

                            source_sanit_list.append(self.events[snk])
                        else:
                            if snk not in self.events:
                                snkNotFound = snkNotFound + 1
                else:
                    if san not in self.events:
                        sanNotFound = sanNotFound + 1
                    if snk not in self.events:
                        snkNotFound = snkNotFound + 1

        print("Sinks not found", snkNotFound)
        print("Sources not found", srcNotFound)
        print("Sanitizers not found", sanNotFound)

        return source_sanit, source_sink, sanit_sink

    def generate_flow_constraints_from_pairs(self, projectdir: str, global_constant_C, query=None, ctx=dict()):
        """Generate the flow constraints required for the optimization model
        It gets the potential flows by joining the pairs (src, san) (san, snk) from the progapation graph   
        """
        source_sanit, source_sink, sanit_sink = self.compute_source_sanit_sink_fromPairs(
            projectdir, ctx)
        print("Flows: San-Snk {0}, Src-San {1}, Src-Snk {2}".format(
            len(sanit_sink), len(source_sanit), len(source_sink)))

        constraints_flow_path = os.path.join(
            self.outputdir, "constraints_flow.txt")
        print(f'constraints flow path = {constraints_flow_path}')

        with open(constraints_flow_path, "a+") as constraintsfile:
            for san_snk_pair in sanit_sink.keys():
                newepsvar = "{0}{1}".format(self._eps, len(self.eps_vars))
                self.eps_vars.append(newepsvar)
                # Adding constraint as in Seldon-Sec 4.2-Fig 4.a
                if len(sanit_sink[san_snk_pair]) > 0:
                    constraintsfile.write(Constraint.print("{0} + {1} - {2} - {3}".format(
                        self.getBackOffVar(san_snk_pair[0], self._san),
                        self.getBackOffVar(san_snk_pair[1], self._snk),
                        " + ".join([
                            self.getBackOffVar(k, self._src)
                            for k in sanit_sink[san_snk_pair]
                        ]).replace(" + ", " - "),
                        newepsvar),
                        "{0}".format(global_constant_C),
                        Constraint.Constraint.LTE, format='norm'))
                    constraintsfile.write("\n")

            for src_san_pair in source_sanit.keys():
                newepsvar = "{0}{1}".format(self._eps, len(self.eps_vars))
                self.eps_vars.append(newepsvar)
                # Adding constraint as in Seldon-Sec 4.2-Fig 4.b
                if len(source_sanit[src_san_pair]) > 0:
                    constraintsfile.write(Constraint.print(
                        "{0} + {1} - {2} - {3}".format(
                            self.getBackOffVar(src_san_pair[0], self._src),
                            self.getBackOffVar(src_san_pair[1], self._san),
                            " + ".join([
                                self.getBackOffVar(k, self._snk)
                                for k in source_sanit[src_san_pair]
                            ]).replace(" + ", " - "),
                            newepsvar
                        ),
                        "{0}".format(global_constant_C), Constraint.Constraint.LTE, format='norm'))

                    constraintsfile.write("\n")

            for src_snk_pair in source_sink.keys():
                newepsvar = "{0}{1}".format(self._eps, len(self.eps_vars))
                self.eps_vars.append(newepsvar)

                # Adding constraint as in Seldon-Sec 4.2-Fig 4.c
                if len(source_sink[src_snk_pair]) > 0:
                    constraintsfile.write(Constraint.print(
                        "{0} + {1} - {2} - {3}".format(
                            self.getBackOffVar(src_snk_pair[0], self._src),
                            self.getBackOffVar(src_snk_pair[1], self._snk),
                            " + ".join([
                                self.getBackOffVar(k, self._san)
                                for k in source_sink[src_snk_pair]
                            ]).replace(" + ", " - "),
                            newepsvar
                        ),
                        "{0}".format(global_constant_C), Constraint.Constraint.LTE, format='norm'))
                    constraintsfile.write("\n")

    def removeRareEvents(self, rep_counter=None):
        if rep_counter is None:
            rep_counter = self.rep_count
        keys = list(self.events.keys())
        dropped = 0
        for k in keys:
            reps = list(filter(
                lambda x: x in rep_counter and rep_counter[x] >= self.min_rep_events, self.events[k].reps))
            if len(reps) == 0:
                self.events.pop(k)
                dropped += 1

        print("Dropped: %d" % dropped)

    def writeObjective(self, ctx):
        objective_path = os.path.join(self.outputdir, "objective.txt")
        print("Objective File: %s" % objective_path)
        with open("{0}/objective.txt".format(self.outputdir), "w") as objectivefile:
            obj = " + ".join(["{0} ".format(self.lambda_const) +
                             k for k in self.variables.keys()])
            if len(self.eps_vars) > 0:
                obj = obj + " + " + " + ".join(self.eps_vars)
            objectivefile.write(obj)
            objectivefile.write("\n")
