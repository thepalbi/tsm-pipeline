import pandas as pd
from Event import Event
from FlowRelation import FlowRelation
import multiprocessing
import traceback as tb
from typing import List
import logging

log = logging.getLogger(__name__)

def compute_rep_count(file_loc, rep_count=None):
    log.info("Reading events from: %s", file_loc)
    df=pd.read_csv(file_loc)
    for rep in list(df["repr"]):
        reps = rep.strip().split("::")
        for k in reps:
            rep_count[k] = rep_count.get(k, 0) + 1


def readEvents(file_loc, events=None, unique_reps=None, rep_count=None, ctx=dict()):
    log.info("Reading events from: %s", file_loc)
    df=pd.read_csv(file_loc)

    # create events
    if events is None:
        events=dict()
    cur_reps=set(list(df["repr"]))
    # TODO: Diego Check 
    for rep in list(df["repr"]):
        reps= rep.strip().split("::")
        for k in reps:
            rep_count[k] = rep_count.get(k, 0) + 1

    new_reps=cur_reps.difference(set(events.keys()))
    log.info("New events: %d", len(new_reps))
    log.info("Size rep_count: %d", len(rep_count.keys()))
    for rep in new_reps:
        event_obj = Event(rep, reps=rep.strip().split("::"))
        events[rep] = event_obj
    new_unique_reps = [r.strip().split("::") for r in new_reps]
    # Flattens the new_unique_reps, and makes a diff
    new_unique_reps = set([i for g in new_unique_reps for i in g]).difference(set(unique_reps.keys()))
    log.info("New Unique reps: %d", len(new_unique_reps))
    log.info(list(new_unique_reps)[:5])
    i = len(list(unique_reps.keys()))
    for k in sorted(new_unique_reps):
        unique_reps[k] = i
        i += 1

    log.info("Total events: %d", len(events.keys()))
    return events


def readFlows(file_loc:str, events: dict):
    df=pd.read_csv(file_loc)
    flows=[]
    error_ids=[]
    for ind in df.index:
        srcid=df.loc[ind]["URL for src"]
        sanid = df.loc[ind]["URL for san"]
        snkid = df.loc[ind]["URL for snk"]
        try:
            flow_obj=FlowRelation(events[srcid], events[sanid], events[snkid])
            flows.append(flow_obj)
        except KeyError as k:
            error_ids.append(k.args[0])

    return flows


def getevent(id, events, reps):
    if id not in events.keys():
        events[id] = Event(id)
        for r in id.split("::"):
            reps.append(r)
            events[id].add_rep(r)
    return events[id]


def mp(func, data, events):
    with multiprocessing.Pool(4) as p:
        results = p.map(lambda x: func(events, x), data)
    return results

def f(events, tup, flows):
    row=tup
    srcid = row["ssrc"]
    sanid = row["ssan"]
    snkid = row["ssnk"]
    try:
        flow_obj = FlowRelation(events[srcid], events[sanid], events[snkid])
        flows.append(flow_obj)
    except:
        tb.print_exc()


def readFlowsAndReps(file_loc:str, events) -> List[FlowRelation]:
    df=pd.read_csv(file_loc)
    flows = []
    error_ids = []
    log.info("Starting flows")
    df.apply(lambda x: f(events, x, flows), axis=1)
    log.info("Done flows")
    return flows

def readPairs(file_loc:str, events):
    df = pd.read_csv(file_loc)
    return df


def readKnown(file_loc:str, suffix:str, query) -> List[str]:
    log.info("Reading known from: %s", file_loc)
    log.info("Query: %s", query)

    df=pd.read_csv(file_loc)
    log.info("Unique {0} locations: {1}, reps: {2} ".format(suffix,len(list(set(df["URL for nd"]))), len(list(set(df["repr"])))))

    if query is None:
        return list(set(df["repr"]))
    else:
        log.info("Unique Query {0} locations: {1} ".format(suffix, len(list(set(df[df["q"] == query]["repr"])))))
        return list(set(df[df["q"] == query]["repr"]))


def readURL(file_loc:str):
    df=pd.read_csv(file_loc)
    col=list(filter(lambda x: x.startswith('URL'), list(df)))
    assert(len(col) == 1)
    col=col[0]
    return list(df[col])

def readClass(file_loc:str):
    df=pd.read_csv(file_loc)
    eventclass=dict()
    for ind in df.index:
        d=eventclass.get(df.loc[ind]["URL for pnd"], list())
        d.append(df.loc[ind]["q"])
        eventclass[df.loc[ind]["URL for pnd"]] = d
    return eventclass
