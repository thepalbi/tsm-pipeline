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
        # reprDict[repr].append((location.toString(),  locationStm.toStringFlat(), locationFunc.toStringFlat()))
        reprDict[repr].append((location,  locationStm, locationFunc))
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

class EmbeddingsReader: 
    def __init__(self, predictionsFile, baseFolder, queryType,  chunk_size, threshold = 0.92):
        self.baseFolder = baseFolder
        self.queryType = queryType
        self.chunk_size = chunk_size
        self.dictPredRepr = readJsonPredictions(predictionsFile)
        self.threshold = threshold
    """ Reads the embeddings for a repr. Since the embeddings are organized by chunks 
        we concatenate the chunks into a single tensor
        In case of memory issues, we may need to read only a part of the embeddings 
    """ 
    def loadKnownSinkEmbForRepPage(self, repr, prefix, page):
        # print(knownSinksLocStm.keys())
        # repr = '"'+repr+'"'
        if repr in self.dictPredRepr.keys(): 
            allLocs = list(self.dictPredRepr[repr])[page*self.chunk_size:(page+1)*self.chunk_size]
            print(repr, len(allLocs))
            # page = 0
            embsStm = None
            try:
                hash = hashlib.md5(repr.encode())
                filename = os.path.join(self.baseFolder, "embs", self.queryType, prefix+str(page)+"_"+hash.hexdigest()+".pickle" )
                embsStm = torch.load( filename)
            except Exception as e:
                print(f"There was a problem loading embeddings: {e}")
            return embsStm, allLocs
        print(repr, " not found")
        return None, None

    """ Reads the embeddings for a repr. Since the embeddings are organized by chunks 
        we concatenate the chunks into a single tensor
        In case of memory issues, we may need to read only a part of the embeddings 
    """ 
    def loadKnownSinkEmbForRep(self, repr, prefix):
        # print(knownSinksLocStm.keys())
        # repr = '"'+repr+'"'
        if repr in self.dictPredRepr.keys(): 
            allLocs = list(self.dictPredRepr[repr])
            # locsStm =  [locStm for (loc,locStm,locFunc) in allLocs]
            # locsFunc =  [locFunc for (loc,locStm,locFunc) in allLocs]
            page = 0
            embsStm = None
            for locs in chunks(allLocs, 50):
                # print(knownCodeStm)
                hash = hashlib.md5(repr.encode())
                filename = os.path.join(self.baseFolder, "embs", self.queryType, prefix+str(page)+"_"+hash.hexdigest()+".pickle" )
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

    # query a candidate (that exists in the repr) against the set of other candidates for the repr 
    def query_from_candidates(self, locCodes, code_vecs, emb):
        # calculate
        # test using cosine:  
        similarity = cosine_similarity( [emb], code_vecs)
        scores = torch.tensor(similarity)

        print("scores:", scores)
        # print(probs)
        # print(ids)
        # print(list([(float(x),locCodes[y]) for x,y in zip(scores[0], range(len(locCodes)))]))
        return list([(float(x),locCodes[y]) for x,y in zip(scores[0], range(len(locCodes)))])


    def checkLocation(self, embs, locs, queryLoc):
        print("query:" , queryLoc)
        pos = locs.index(queryLoc)
        print("pos in embedding: ", pos)

        code_vec_np = embs.detach().numpy()
        emb = code_vec_np[pos]
        results = self.query_from_candidates(locs, code_vec_np, emb)

        # print(results)
        return results
    
    """ 
    Given a repr and the enclosing STM + enclosing Function of a candidate sink
    return the set of candidate sinks (for the same repr) that has similar code
    Important: Assumes locationStm in embsAllStm and locationFunc in embsAllFunc 
    """     
    def getSimilarSinks(self, locationStm, locationFunc, repr):
        embsAllStm, allLocs = self.loadKnownSinkEmbForRep(repr,  "emb_")
        embsAllFunc, allLocs = self.loadKnownSinkEmbForRep(repr, "embF_")
        sourceLocStm = locationStm
        sourceLocFunc = locationFunc

        selectedLocs = set()
        
        allLocs = list(self.dictPredRepr[repr])
        locsStm =  [locStm for (loc,locStm,locFunc) in allLocs]
        locsFunc =  [locFunc for (loc,locStm,locFunc) in allLocs]

        print("Negative example: ", sourceLocStm )
        resultStm = self.checkLocation(embsAllStm, locsStm, sourceLocStm)
        resultFunc = self.checkLocation(embsAllFunc, locsFunc, sourceLocFunc)
        for i in range(0,len(allLocs)):
            scoreStm, locS = resultStm[i]
            scoreFunc, locF = resultFunc[i]
            avgScore = (scoreStm+scoreFunc)/2
            # print(allLocs[i], avgScore)
            if avgScore > self.threshold:
                # print(allLocs[i])
                selectedLocs.add((allLocs[i][0],avgScore))

        print("Highlighted ", len(selectedLocs), "/", len(self.dictPredRepr[repr]))
        print(selectedLocs)
        return selectedLocs


    """ 
    Given a repr and the enclosing STM + enclosing Function of a candidate sink
    return the set of candidate sinks (for the same repr) that has similar code 
    Paginated version to handle memory contrains.
    Important: Cannot assume locationStm in embsAllStm and locationFunc in embsAllFunc 
    """
    def getSimilarSinksPaginated(self, locationStm, locationFunc, repr):
        sourceLocStm = locationStm
        sourceLocFunc = locationFunc

        selectedLocs = set()
        
        allLocs = list(self.dictPredRepr[repr])
        allLocsStm =  [locStm for (loc,locStm,locFunc) in allLocs]

        # find and load the embedding for the location 
        pos = allLocsStm.index(sourceLocStm)
        page = int(pos / self.chunk_size)
        relativePos = pos % self.chunk_size
        # load page with the embedding for that enclosing stm and get embedding
        embsAllStm, locsStm = self.loadKnownSinkEmbForRepPage(repr,  "emb_", page)
        code_vec_np = embsAllStm.detach().numpy()
        embStm = code_vec_np[relativePos]
        # load page with the embedding for that enclosing func and get embedding
        embsAllFunc, locsFunc = self.loadKnownSinkEmbForRepPage(repr, "embF_", page)
        code_vec_np = embsAllFunc.detach().numpy()
        embFunc = code_vec_np[relativePos]

        print("Negative example: ", sourceLocStm )
        page = 0
        for locs in chunks(allLocs, self.chunk_size):
            print(page)
            embsAllStm, _ = self.loadKnownSinkEmbForRepPage(repr,  "emb_", page)
            embsAllFunc, _ = self.loadKnownSinkEmbForRepPage(repr, "embF_", page)
            locsStm =  [locStm for (loc,locStm,locFunc) in locs]
            locsFunc =  [locFunc for (loc,locStm,locFunc) in locs]

            code_vec_np = embsAllStm.detach().numpy()
            resultStm = self.query_from_candidates(locsStm, code_vec_np, embStm)
            code_vec_np = embsAllFunc.detach().numpy()
            resultFunc = self.query_from_candidates(locsFunc, code_vec_np, embFunc)

            # resultStm = self.checkLocation(embsAllStm, locsStm, sourceLocStm)
            # resultFunc = self.checkLocation(embsAllFunc, locsFunc, sourceLocFunc)

            for i in range(0,len(locs)):        
                scoreStm, locS = resultStm[i]
                scoreFunc, locF = resultFunc[i]
                avgScore = (scoreStm+scoreFunc)/2
                # print(allLocs[i], avgScore)
                if avgScore > self.threshold:
                    # print(allLocs[i])
                    selectedLocs.add((locs[i][0],avgScore))
            page = page + 1

        print("Highlighted ", len(selectedLocs), "/", len(self.dictPredRepr[repr]))
        print(selectedLocs)
        return selectedLocs

# baseFolder = "./dbs"
# testing embeddings for negative examples
# predictionsFile = "../triager/data/predictions.json.updated"
# dictPredRepr = readJsonPredictions(predictionsFile)
 
