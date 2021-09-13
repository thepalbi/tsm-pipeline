import genericpath
import os
from transformers import AutoTokenizer, AutoModel
from torch.utils.data import DataLoader, SequentialSampler,TensorDataset
import torch
import torch.nn.functional as F
import json
import numpy as np
from tqdm import tqdm
from sklearn.metrics.pairwise import cosine_similarity
import sys
from location import Location
from location import getCodes


from typing import List

"""
Read the csv file of known sinks produced with the query Known-Enc.ql
Applying that query to a set of DBs produces the csv file that is read 
with this function 
"""
def readKnownLoc(file_loc:str):
    knownSinks = open(file_loc, 'r', errors='replace', encoding='utf-8').readlines()

    knownsStm =  dict()
    knownsFunc =  dict()
    db = ""
    counter = 0
    for line in knownSinks:
        counter = counter + 1
        # I have to clean this but in case of changes it is necessary to regenerate the 
        # embeddings to keep the embeddings and the code in sink
        if line.startswith("g_"):
            db = line.strip()
            print(db)
            continue
        if line.startswith("DB="):
            db = line[3:].strip()
            print(db)
            continue
        if line.startswith('"col1",'):
            continue
        if not line.startswith("\""):
            continue
        # if not "file:" in line:
        #     continue
        if '"col1"' in line:    
            continue
        if ' ?)' in line:    
            continue
        if "10'" in line:    
            continue

        try:
            repr, location, locationFunc = extractKnownSinkInfo(db, line)
            if repr not in knownsStm.keys():
                knownsStm[repr] = set()
            knownsStm[repr].add(location)
            if repr not in knownsFunc.keys():
                knownsFunc[repr] = set()
            knownsFunc[repr].add(locationFunc)
            
            # print(location, repr)
        except Exception as e:
            print(e)
            print(counter, ' ', line)
            # print(columns)
            #raise
         
    print(len(knownsStm.keys()))
    return (knownsStm, knownsFunc)

def extractKnownSinkInfo(db, line):
    columns = line.split(",")
    path = columns[1]
    repr = columns[6]
    startLine = int(columns[7])
    startColumn = int(columns[8])
    endLine = int(columns[9])
    endColumn = int(columns[10])
    funcStartLine = int(columns[11])
    funcStartColumn = int(columns[12])
    location = Location(db, path, startLine, startColumn, endLine, endColumn)
    locationFunc = Location(db, path, funcStartLine, funcStartColumn, endLine, endColumn)
    return repr,location,locationFunc


# load all embeddings for a given repr into one tensor 
def loadKnownSinkEmbForRep(repr,knownSinksLocStm, prefix):
    repr = '"'+repr+'"'
    if repr in knownSinksLocStm.keys(): 
        allLocs = list(knownSinksLocStm[repr])
        print(repr, len(allLocs))
        page = 0
        embsStm = None
        try:
            for locs in chunks(allLocs, 50):
                # print(knownCodeStm)
                hash = hashlib.md5(repr.encode())
                filename = os.path.join(baseFolder, queryType, "embs", prefix + str(page)+"_"+hash.hexdigest()+".pickle" )
                embsStm1 = torch.load( filename)
                page = page + 1
                if embsStm is None:
                    embsStm = embsStm1
                else:
                    embsStm = torch.cat((embsStm, embsStm),0)
        except: 
            print("There was a problem loading embeddings")
        return embsStm, allLocs
    return None, None

# load  only one page of precomputed  embeddings  for a given repr into one tensor 
def loadKnownSinkEmbForRepChunk(repr, knownSinksLoc, prefix, page, chunk_size):
    if repr in knownSinksLoc.keys(): 
        allLocs = list(knownSinksLoc[repr])[page*chunk_size:(page+1)*chunk_size]
        print(repr, len(allLocs))
        # page = 0
        embsStm = None
        try:
            hash = hashlib.md5(repr.encode())
            filename = os.path.join(baseFolder, queryType, "embs", prefix + str(page)+"_"+hash.hexdigest()+".pickle" )
            embsStm1 = torch.load( filename)
            page = page + 1
            if embsStm is None:
                embsStm = embsStm1
            else:
                embsStm = torch.cat((embsStm, embsStm1),0)
            print(embsStm.size())
        except: 
            print("There was a problem loading embeddings")
        return embsStm, allLocs
    return None, None


def encode(inputs):
    outputs = model(inputs,attention_mask = inputs.ne(1))[0]
    # mean pooling
    # outputs = outputs.sum(1)/inputs.ne(1).sum(-1).unsqueeze(-1)
    # Fix mean pooling
    outputs = (outputs*inputs.ne(1).unsqueeze(-1)).sum(1)/inputs.ne(1).sum(-1).unsqueeze(-1)
    # F2 norm 
    outputs = F.normalize(outputs, p=2, dim=1)
    return outputs
    
# given a query code, get the similairy results against a set of precomputed embedings
# return a list of n element [(location, score)] with the most similar sink
def query_from_candidates(query,locCodes,code_vecs, n):
    # obtain query embeddings
    inputs = tokenizer(query,return_tensors='pt', max_length=MAX_LEN, padding=True,truncation=True)['input_ids']
    query_vec = encode(inputs).cpu()

    # calculate
    # test using cosine:  
    # query_np = query_vec.detach().numpy()
    # code_vec_np = code_vecs.detach().numpy()
    # similarity = cosine_similarity( query_np, code_vec_np)
    # scores = torch.tensor(similarity)
    scores=torch.einsum("ab,cb->ac",query_vec,code_vecs)[0]
    # search
    probs, ids = scores.topk(n)
    return list([(float(x),locCodes[int(y)]) for x,y in zip(probs, ids)])

# given a query code, get the similairy results against a set of precomputed known sink embeddings
# return a tuple (location, score) with the most similar sink
# def compareWithKS(code, ksEmbs, knownLocs):
#     result = query_from_candidates(code,knownLocs, ksEmbs,1)[0]
#     print(result[0], ",", result[1])
#     return result
 

def getMostSimilarKnownSink(embs, ksLocs, loc):
    found  = None
    # print(sLocs)
    sCode = loc.read(os.path.join(baseFolder, queryType))
    # print(sCode)
    d, ksLoc = query_from_candidates(sCode, ksLocs, embs, 1)[0]
    # d,ksLoc = compareWithKS(sCode, embs, ksLocs)

    if d > SIMILARITY_THRESHOLD: 
        print("Match:", loc.toString(),  d)
        found = ksLoc
        return (found, d)
    # print(sCode, ksCode)
    # print(sLoc, ksLoc)
        #     print("Not Match:", sLoc, ksLoc)
        # else:
            # print("Match:", sCode, ksCode)
    return (None, d)

def chunks(lst, n):
    """Yield successive n-sized chunks from lst."""
    for i in range(0, len(lst), n):
        yield lst[i:i + n]

import hashlib

from location import Location
import glob

        
def readJsonPredictions(fileName):
    locs = [] 
    with open(fileName, encoding="utf-8") as source:
        data = json.load(source)        
        return data


def processOneLocation(location, knownSinksLoc, prefix, allLocs, repr, chunk_size):
    maxScore = 0
    maxLoc = None
    page = 0
    for locs in chunks(allLocs, chunk_size):
        print(page, " ", repr, " ", prefix)
        embs, allLocsChunk = loadKnownSinkEmbForRepChunk(repr, knownSinksLoc,  prefix, page, chunk_size)
        page = page + 1
        # compute distance between the enclosing stm and the closest sink candidate 
        if embs is not None:
            result = getMostSimilarKnownSink(embs, allLocsChunk,  location)
        else:
            print("Is None for ", repr)
            result = (location,originalScore)
            return result

        found = result[0] 
        score = result[1]

        # compute maximum score for enclosing stm
        if(maxScore<score):
            maxScore = score
            maxLoc = found

    print("maxScore:",maxScore)
    return (maxLoc, maxScore)

if __name__ == '__main__':
    baseFolder = "/persistent/dbs"
    queryType = "sql" 
    knownSinksFilename = "KnownEnc2.csv"
    predictionsFile = "../triager/data/predictions.json"
    SIMILARITY_THRESHOLD=0.90
    MAX_LEN = 512
    chunk_size = 50
    # predictionsFile = "predictions.json"

    # load precomputed model
    device = torch.device("cuda" if torch.cuda.is_available() else "cpu")
    tokenizer = AutoTokenizer.from_pretrained("microsoft/graphcodebert-base")
    model = AutoModel.from_pretrained("microsoft/graphcodebert-base")
    torch.cuda._initialized = True
    model.to(device)
    model.eval()
    

    print("Read known sinks")
    # load locations of knows sinks, and same locations extended to get more context
    knownSinksLocStm,knownSinksLocFunc = readKnownLoc(os.path.join(baseFolder, knownSinksFilename))
    data = readJsonPredictions(predictionsFile)
    # locDict = dict()

    for elem in data:
        loc = elem["locationEnclosingStm"]
        repr = elem["repr"]
        repr2 = '"'+repr+'"'
        maxScore1 = 0
        maxScore2 = 0
        originalScore = elem["score"]
        # print(loc)                        

        if repr2 in knownSinksLocStm.keys(): 
            allLocs = list(knownSinksLocStm[repr2])
            print(repr2, len(allLocs))
            path = loc["path"] 
            project = loc["projectName"]
            location = Location(project, path, 
                                loc["startLine"],loc["startColumn"], 
                                loc["endLine"], loc["endColumn"])
            locFunc = elem["locationEnclosingFunc"]
            locationFunc = Location(project, path, 
                                locFunc["startLine"],locFunc["startColumn"], 
                                locFunc["endLine"], locFunc["endColumn"])
            strLoc = location.toString() 
            db = location.db

            if '"col1"' in strLoc:
                print("Skip", strLoc)
                continue
            if strLoc == '10' or  strLoc == ' 10':    
                continue

            # read the embddings in chunks to make sure they fit in memory
            # note that this is very innneficient: 
            # each sink from the prediction is compared (in chunks) agains all known sinks for the repr
            # a possible optimization is to group several sinks from the prediction together  
            (loc1, maxScore1) = processOneLocation(location, knownSinksLocStm, "knownStm_", allLocs, repr2, chunk_size)
            
            (loc2, maxScore2) = processOneLocation(location, knownSinksLocFunc,  "knownF_", allLocs, repr2, chunk_size)

        if originalScore == 1:
            newScore = (maxScore1+maxScore2)/2 
        else: 
            newScore = ( originalScore + (maxScore1+maxScore2)/2) /2 
 
        elem["score"] = newScore
    # print(locDict)    
    json.dump( data, open( predictionsFile+'.updated', 'w' ) )

