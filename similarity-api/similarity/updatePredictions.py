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
from location import getCodes, readLocation


from typing import List

def readKnownLoc(file_loc:str):
    knownSinks = open(file_loc, 'r', errors='replace', encoding='utf-8').readlines()

    knownsStm =  dict()
    knownsFunc =  dict()
    db = ""
    counter = 0
    for line in knownSinks:
        counter = counter + 1
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
            urlStm = location.toString()
            # urlStm = db+"||"+url
            # knownsStm.append(urlStm)
            if repr not in knownsStm.keys():
                knownsStm[repr] = set()
            knownsStm[repr].add(urlStm)
            # temporary (until I can compute enclosing functions) get a few lines before the enclosing statement
            urlFunc = locationFunc.toString()
            # knownsFunc.append(db+"||"+urlFunc)
            # knownsFunc.append(fakeEnclosingStm(location).toString())
            if repr not in knownsFunc.keys():
                knownsFunc[repr] = set()
            knownsFunc[repr].add(urlFunc)
            
            # print(location, repr)
        except Exception as e:
            print(e)
            print(counter, ' ', line)
            print(columns)
            #raise
         
    print(len(knownsStm.keys()))
    return (knownsStm, knownsFunc)


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
    
def getVectors(codes):
    # build dataset
    inputs = tokenizer(codes,return_tensors='pt',max_length=MAX_LEN, padding=True,truncation=True)['input_ids']

    dataset = TensorDataset(inputs)
    dataloader = DataLoader(dataset, sampler=SequentialSampler(dataset), batch_size=32)   
    # obtain embeddings
    embeddings = []
    count = 0
    for batch in tqdm(dataloader):
        count += 1
        print(count)
        emb = encode(batch[0])
        embeddings.append(emb)
    
    embeddings = torch.cat(embeddings,0).cpu()

    return embeddings

def query_from_candidates(query,locCodes,code_vecs):
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
    probs, ids = scores.topk(1)
    return list([(float(x),locCodes[int(y)]) for x,y in zip(probs, ids)])


def compareWithKS(code, ksEmbs, knownLocs):
    result = query_from_candidates(code,knownLocs, ksEmbs)[0]
    print(result)
    return result
 


def checkLocation(embs, ksLocs, sLocs):
    found  = None
    # print(sLocs)
    md = 0
    for sLoc in sLocs:
            sCode = readLocation(sLoc, os.path.join(baseFolder, queryType))
            # print(sCode)
            elems = [sCode]                
            d,ksLoc = compareWithKS(sCode, embs, ksLocs)
            if d > md:
                md = d

            if d > SIMILARITY_THRESHOLD: 
                print("Match:", sLoc,  d)
                found = ksLoc
                return (found, d)
            # print(sCode, ksCode)
            # print(sLoc, ksLoc)
                #     print("Not Match:", sLoc, ksLoc)
                # else:
                    # print("Match:", sCode, ksCode)
    return (None, md)

def chunks(lst, n):
    """Yield successive n-sized chunks from lst."""
    for i in range(0, len(lst), n):
        yield lst[i:i + n]

import hashlib

def generateAndSaveEmbeddings(knownSinksLocStm,knownSinksLocFunc):
    for repr in knownSinksLocStm.keys():
        print(repr)
        allLocs = list(knownSinksLocStm[repr])
        page = 0
        for locs in chunks(allLocs, 50):
            print(len(locs))
            knownCodeStm = getCodes(locs, baseFolder, queryType)
            # print(knownCodeStm)
            embsStm = getVectors(knownCodeStm)
            hash = hashlib.md5(repr.encode())
            filename = os.path.join(baseFolder, "sql", "embs", "knownStm_"+str(page)+"_"+hash.hexdigest()+".pickle" )
            torch.save(embsStm, filename)
            page = page + 1

    for repr in knownSinksLocFunc.keys():
        print(repr)
        allLocs = list(knownSinksLocFunc[repr])
        page = 0
        for locs in chunks(allLocs, 50):
            print(len(locs))
            knownCodeStm = getCodes(locs, baseFolder, queryType)
            # print(knownCodeStm)
            embsStm = getVectors(knownCodeStm)
            hash = hashlib.md5(repr.encode())
            filename = os.path.join(baseFolder, "sql", "embs", "knownF_"+str(page)+"_"+hash.hexdigest()+".pickle" )
            torch.save(embsStm, filename)
            page = page + 1


from location import Location
import glob

def getDBName(project, projectPrefix):
    # if project[0:2]=="g/":
    #     project = project[2:]

    projectPrefix =  os.path.join(projectPrefix, project.replace('\r', '').replace('\n', '').replace("/","_"))
    # print(projectPrefix)
    projectCandidate = []
    if("/" in project):
        projectCandidate = glob.glob(projectPrefix+"*", recursive=True)
    if len(projectCandidate)==1:
        return os.path.basename(projectCandidate[0])
    if len(projectCandidate)>1:
            projectCandidate = glob.glob(projectPrefix+"_A*", recursive=True)
            return os.path.basename(projectCandidate[0])
    # should throw exception
    return project

        
def readJsonPredictions(fileName):
    locs = [] 
    with open(fileName, encoding="utf-8") as source:
        data = json.load(source)        
        return data


if __name__ == '__main__':
    baseFolderKS = "/persistent2/experiments/"
    baseFolder = "/persistent/dbs"
    baseModel = "/persistent2/CodeBERT/GraphCodeBERT/clonedetection/"

    queryType = "sql" 
    db = "jordanbertasso_vulnerable-web-app_9ea5fa8"
    inputCVS = "inputs4.csv"
    outputFileName = db + '.json'

    if len(sys.argv)>1:
        db = sys.argv[1]
        inputCVS = sys.argv[2]

    outputFileName = db + '.json'

    # load precomputed model
    device = torch.device("cuda" if torch.cuda.is_available() else "cpu")
    tokenizer = AutoTokenizer.from_pretrained("microsoft/graphcodebert-base")
    model = AutoModel.from_pretrained("microsoft/graphcodebert-base")
    torch.cuda._initialized = True
    model.to(device)
    model.eval()
    
    SIMILARITY_THRESHOLD=0.90
    MAX_LEN = 512

    print("Read known sinks")
    # load locations of knows sinks, and same locations extended to get more context
    knownSinksFilename = "KnownEnc2.csv"
    knownSinksLocStm,knownSinksLocFunc = readKnownLoc(os.path.join(baseFolder, knownSinksFilename))

    predictionsFile = "predictions.json"
    data = readJsonPredictions(predictionsFile)
    locDict = dict()
    for elem in data:
        loc = elem["locationEnclosingStm"]
        repr = elem["repr"]
        page  = 0
        repr2 = '"'+repr+'"'
        maxScore1 = 0
        maxScore2 = 0
        originalScore = elem["score"]

        if repr2 in knownSinksLocStm.keys(): 
            allLocs = list(knownSinksLocStm[repr2])
            print(repr2, len(allLocs))
            for locs in chunks(allLocs, 50):
                embsStm, allLocsStm = loadKnownSinkEmbForRepChunk(repr2, "knownStm_", page)
                # print(loc)
                path = loc["path"] 
                project = loc["projectName"]
                location = Location(project, path, 
                                    loc["startLine"],loc["startColumn"], 
                                    loc["endLine"], loc["endColumn"])
                location.db = getDBName(location.db, os.path.join(baseFolder, queryType))
                locFunc = elem["locationEnclosingFunc"]
                locationFunc = Location(project, path, 
                                    locFunc["startLine"],locFunc["startColumn"], 
                                    locFunc["endLine"], locFunc["endColumn"])
                locationFunc.db = getDBName(location.db, os.path.join(baseFolder, queryType))
                # compare each sink candidate against the enclosing stm of all known sinks
                # for location in locs:
                # if not "QBis" in location.db:
                #     continue
                # if location.startLine !=15:
                #     continue
                # location = fakeEnclosingStm(location)
                sLoc = location.toString() 
                db = location.db
                # print(sLoc)
                if '"col1"' in sLoc:
                    print("Skip", sLoc)
                    continue
                if sLoc == '10' or  sLoc == ' 10':    
                    continue
            
            
                # compute distance between the enclosing stm of a sink candidate and a the 
                # enclosing stm of all known sinks
                # result = (location of matching known source, score) 
                # sLocs = [db+"||"+sLoc]
                sLocs = [sLoc]
                # print(sLocs)
                if embsStm is not None:
                    result = checkLocation(embsStm, allLocsStm,  sLocs)
                else:
                    print("Is None for ", repr)
                    result = ["",originalScore]
                    continue
                found = result[0] 
                score = result[1]
                if(maxScore1<score):
                    maxScore1 = score
            print("maxScore1:",maxScore1)
            # This is simillar to enclosing stm but starting 5 lines before to give more context
            # sLocs2 = [db+"||"+extendLocation(sLoc)]
            page = 0
            for locs in chunks(allLocs, 50):
                embsFunc, allLocsFunc = loadKnownSinkEmbForRepChunk(repr2, "knownF_", page)
                page = page + 1
                sLocs2 = [locationFunc.toString()]
                print(sLocs2)
                # embsFunc, allLocsFunc = loadKnownSinkEmbForRep(repr, knownSinksLocFunc, "knownF_")
                result2 = checkLocation(embsFunc, allLocsFunc,  sLocs2)
                # result2=["",1]
                score2 = result2[1]
                if(maxScore2<score2):
                    maxScore2 = score2

                locDict[sLoc] = str(found)  + "= "  + str(score) + ";" + str(score2)  
                # sLoc = db+"||"+sLoc
                sCode = readLocation(sLoc, os.path.join(baseFolder, queryType))
                ksCode = None
                if found is not None:
                    ksCode = readLocation(found, os.path.join(baseFolder, queryType))
                    print("C1:", sCode)
                    print("C2:", ksCode)
                else:
                    print(sLoc," not found, score", 
                    score)
                print("Result2:", result2)
            print("maxScore2:",maxScore2)

        if originalScore == 1:
            newScore = (maxScore1+maxScore2)/2 
        else: 
            newScore = ( originalScore + (maxScore1+maxScore2)/2) /2 
 
        elem["score"] = newScore
    print(locDict)    
    json.dump( locDict, open( outputFileName, 'w' ) )
    json.dump( data, open( predictionsFile+'.updated', 'w' ) )

