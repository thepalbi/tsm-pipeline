import genericpath
import os
import torch
import json
import numpy as np
from sklearn.metrics.pairwise import cosine_similarity
import sys
from .location import Location

import hashlib
from typing import List

# Creates a dictionary repr -> [loc, stmLoc, funcLoc] out of the prediction json in memory
def createReprDict(predictions):
    reprDict = dict()
    for elem in predictions:
        loc = elem["location"]
        repr = elem["repr"]
        # print(loc)
        path = loc["path"] 
        project = loc["projectName"]
        location = Location(project, path, 
                            loc["startLine"],loc["startColumn"], 
                            loc["endLine"], loc["endColumn"])
        # the enclosing stm 
        locStm = elem["locationEnclosingStm"]
        locationStm = Location(project, path, 
                            locStm["startLine"],locStm["startColumn"], 
                            locStm["endLine"], locStm["endColumn"])
        # the enclosing function 
        locFunc = elem["locationEnclosingFunc"]
        locationFunc = Location(project, path, 
                            locFunc["startLine"],locFunc["startColumn"], 
                            locFunc["endLine"], locFunc["endColumn"])
        if repr not in reprDict.keys():
            reprDict[repr] = list()
        reprDict[repr].append((location.toString(),  locationStm.toStringFlat(), locationFunc.toStringFlat()))
    return reprDict

# Creates a dictionary repr -> [loc, stmLoc, funcLoc] out of the prediction json file
def readJsonPredictions(fileName):
    locs = [] 
    with open(fileName, encoding="utf-8") as source:
        data = json.load(source)        
        dictPredRepr = createReprDict(data)
        return dictPredRepr

# Obtains chunks of list. Used to read pieces of candidates
def chunks(lst, n):
    """Yield successive n-sized chunks from lst."""
    for i in range(0, len(lst), n):
        yield lst[i:i + n]

""" Reads the embeddings for a repr. Since the embeddings are organized by chunks 
    we concatenate the chunks into a single tensor
    In case of memory issues, we may need to read only a part of the embeddings 
""" 
def loadKnownSinkEmbForRep(repr, dictPredRepr, prefix):
    # print(knownSinksLocStm.keys())
    # repr = '"'+repr+'"'
    if repr in dictPredRepr.keys(): 
        allLocs = list(dictPredRepr[repr])
        # locsStm =  [locStm for (loc,locStm,locFunc) in allLocs]
        # locsFunc =  [locFunc for (loc,locStm,locFunc) in allLocs]
        page = 0
        embsStm = None
        for locs in chunks(allLocs, 50):
            # print(knownCodeStm)
            hash = hashlib.md5(repr.encode())
            filename = os.path.join(baseFolder, "embs", "sql", prefix+str(page)+"_"+hash.hexdigest()+".pickle" )
            embsStm1 = torch.load(filename)
            # print(repr, embsStm1)
            page = page + 1
            if embsStm is None:
                embsStm = embsStm1
            else:
                embsStm = torch.cat((embsStm, embsStm1),0).cpu()
        return embsStm, allLocs
    print(repr, " not found")
    return None, None



def query_from_candidates(locCodes,code_vecs, pos):
    # calculate
    # test using cosine:  
    code_vec_np = code_vecs.detach().numpy()
    similarity = cosine_similarity( [code_vec_np[pos]], code_vec_np)
    scores = torch.tensor(similarity)

    print("pos in embedding: ", pos)
    print("scores:", scores)
    # print(probs)
    # print(ids)
    # print(list([(float(x),locCodes[y]) for x,y in zip(scores[0], range(len(locCodes)))]))
    return list([(float(x),locCodes[y]) for x,y in zip(scores[0], range(len(locCodes)))])


def checkLocation(embs, locs, queryLoc):
    pos = locs.index(queryLoc)
    results = query_from_candidates(locs, embs, pos)
    # print(results)
    return results
 


def getSimilarSinks(locationStm, locationFunc, repr):
    embsAllStm, allLocs = loadKnownSinkEmbForRep(repr, dictPredRepr, "emb_")
    embsAllFunc, allLocs = loadKnownSinkEmbForRep(repr, dictPredRepr, "embF_")
    sourceLocStm = locationStm.toStringFlat()
    sourceLocFunc = locationFunc.toStringFlat()

    selectedLocs = set()
    
    allLocs = list(dictPredRepr[repr])
    locsStm =  [locStm for (loc,locStm,locFunc) in allLocs]
    locsFunc =  [locFunc for (loc,locStm,locFunc) in allLocs]

    print("Negative example: ", sourceLocStm )
    resultStm = checkLocation(embsAllStm, locsStm, sourceLocStm)
    resultFunc = checkLocation(embsAllFunc, locsFunc, sourceLocFunc)
    for i in range(0,len(allLocs)):
        scoreStm, locS = resultStm[i]
        scoreFunc, locF = resultFunc[i]
        avgScore = (scoreStm+scoreFunc)/2
        # print(allLocs[i], avgScore)
        if avgScore > 0.92:
            # print(allLocs[i])
            selectedLocs.add((allLocs[i][0],avgScore))

    print("Highlighted ", len(selectedLocs), "/", len(dictPredRepr[repr]))
    print(selectedLocs)
    # return selectedLocs
    return selectedLocs


baseFolder = "./dbs"

# testing embeddings for negative examples
predictionsFile = "../triager/data/predictions.json.updated"
dictPredRepr = readJsonPredictions(predictionsFile)
 