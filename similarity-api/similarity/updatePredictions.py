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
        if line.startswith("g_"):
            db = line.strip()
            print(db)
            continue
        if line.startswith("DB="):
            db = line[3:].strip()
            print(db)
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
                filename = os.path.join(baseFolder, "sql", "embs", prefix + str(page)+"_"+hash.hexdigest()+".pickle" )
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
def loadKnownSinkEmbForRepChunk(repr, prefix, page):
    if repr in knownSinksLocStm.keys(): 
        allLocs = list(knownSinksLocStm[repr])[page*50:(page+1)*50]
        print(repr, len(allLocs))
        # page = 0
        embsStm = None
        try:
            hash = hashlib.md5(repr.encode())
            filename = os.path.join(baseFolder, "sql", "embs", prefix + str(page)+"_"+hash.hexdigest()+".pickle" )
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
def compareWithKS(code, ksEmbs, knownLocs):
    result = query_from_candidates(code,knownLocs, ksEmbs,1)[0]
    print(result[0], ",", result[1])
    return result
 

def getMostSimilarKnownSink(embs, ksLocs, loc):
    found  = None
    # print(sLocs)
    sCode = loc.read(os.path.join(baseFolder, queryType))
    # print(sCode)
    d,ksLoc = compareWithKS(sCode, embs, ksLocs)

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
    locDict = dict()
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
            page = 0
            for locs in chunks(allLocs, chunk_size):
                embsStm, allLocsStm = loadKnownSinkEmbForRepChunk(repr2, "knownStm_", page)
                # compute distance between the enclosing stm and the closest sink candidate 
                if embsStm is not None:
                    result = getMostSimilarKnownSink(embsStm, allLocsStm,  location)
                else:
                    print("Is None for ", repr)
                    result = ["",originalScore]
                    continue

                found = result[0] 
                score = result[1]

                # compute maximum score for enclosing stm
                if(maxScore1<score):
                    maxScore1 = score
            print("maxScore1:",maxScore1)

            # read the embddings in chunks to make sure they fit in memory
            page = 0
            for locs in chunks(allLocs, 50):
                embsFunc, allLocsFunc = loadKnownSinkEmbForRepChunk(repr2, "knownF_", page)
                page = page + 1
                # compute distance between the enclosing stm and the closest sink candidate 
                result2 = getMostSimilarKnownSink(embsFunc, allLocsFunc,  locationFunc)
                # result2=["",1]
                score2 = result2[1]
                if(maxScore2<score2):
                    maxScore2 = score2

                locDict[strLoc] = str(found)  + "= "  + str(score) + ";" + str(score2)  
                # sLoc = db+"||"+sLoc
                sCode = location.read(os.path.join(baseFolder, queryType))
                ksCode = None
                if found is not None:
                    ksCode = found.read(os.path.join(baseFolder, queryType))
                    print("C1:", sCode)
                    print("C2:", ksCode)
                else:
                    print(strLoc," not found, score", 
                    score)
                print("Result2:", result2[0], ",", result2[1])
            print("maxScore2:",maxScore2)

        if originalScore == 1:
            newScore = (maxScore1+maxScore2)/2 
        else: 
            newScore = ( originalScore + (maxScore1+maxScore2)/2) /2 
 
        elem["score"] = newScore
    # print(locDict)    
    json.dump( data, open( predictionsFile+'.updated', 'w' ) )

