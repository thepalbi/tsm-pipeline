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
import zipfile
import sys
from .location import Location
import glob


from typing import List

def readJsonPredictions(fileName):
    locs = [] 
    with open(fileName, encoding="utf-8") as source:
        data = json.load(source)        
        return data



def extendLocation(location):
    newLoc = Location(location.db, location.path, 
                location.startLine, location.startColumn,
                location.endLine, location.endColumn)
    newLoc.startLine = max(newLoc.startLine-5,1)
    newLoc.startColumn = 1
    return newLoc

def fakeEnclosingStm(location):
    newLoc = Location(location.db, location.path, 
                location.startLine, location.startColumn,
                location.endLine, location.endColumn)
    newLoc.startLine = max(newLoc.startLine-2,1)
    newLoc.startColumn = 1
    newLoc.endLine = newLoc.endLine + 1
    return newLoc


def extendStrLocation(url):
    locArray = url.replace("\"","").split(":")
    if len(locArray)>5:
        startLine = max(int(locArray[2])-5,1)
        startColumn = 1
        endLine = int(locArray[4])
        endColumn = int(locArray[5])
        fileName = locArray[1][3:]        
        urlFunc = "file:///"+fileName+':'+str(startLine)+':'+str(startColumn)+':'+str(endLine)+':'+str(endColumn)
        return urlFunc
    return url


def encode(inputs):
    outputs = model(inputs,attention_mask = inputs.ne(1))[0]
    # mean pooling
    outputs = outputs.sum(1)/inputs.ne(1).sum(-1).unsqueeze(-1)
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
    for batch in tqdm(dataloader):
        embeddings.append(encode(batch[0]))
    
    embeddings = torch.cat(embeddings,0).cpu()

    return embeddings

def query_candidate(query, candidate):
    inputs1 = tokenizer(query,return_tensors='pt', max_length=MAX_LEN, padding=True,truncation=True)['input_ids']
    query_vec = encode(inputs1).cpu()
    inputs2 = tokenizer(candidate,return_tensors='pt', max_length=MAX_LEN, padding=True,truncation=True)['input_ids']
    code_vec = encode(inputs2).cpu()
    scores=torch.einsum("ab,cb->ac",query_vec,code_vec)[0]
    # search
    probs, ids = scores.topk(1)
    return float(probs)

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
    print("query:", query)
    print("Probs", probs, " ids:", ids, " locCodes:", locCodes)
    return list([(float(x),locCodes[int(y)]) for x,y in zip(probs, ids)])


def compareWithKS(code, ksEmbs, knownLocs):
    result = query_from_candidates(code,knownLocs, ksEmbs)[0]
    print(result)
    return result
 

def readLocation(location:str, prefix:str):
    try: 
        locDB = location.split("||")
        db = locDB[0].strip().replace("/","_")
        url = locDB[1].replace("\"","")
        locArray = url.replace("\"","").split(":")
        startLine = int(locArray[2])
        startColumn = int(locArray[3])
        endLine = int(locArray[4])
        endColumn = int(locArray[5])
        fileName = locArray[1][3:]

        # print(prefix+db+"/src.zip")
        
        archive = zipfile.ZipFile(os.path.join(prefix,db,"src.zip"), 'r')
        # print(fileName)
        # print(startLine)
        # print(endLine)
        with archive.open(fileName) as source:
            lines = source.readlines()
            # lines = text.split('\n')
            # print(len(lines))
            result = ""
            if(endLine>startLine):
                result += lines[startLine-1].decode('utf-8')[startColumn-1:]
                for i in range(startLine+1,endLine-1):
                    # print(lines[i-1])
                    text = lines[i-1].decode('utf-8')
                    result += text
                    result += lines[endLine-1].decode('utf-8')[:endColumn]
            else:
                result += lines[startLine-1].decode('utf-8')[startColumn-1:endColumn]
            # print(result)
    except Exception as inst:
        print("Error:", location)
        print(inst)   
        # raise    
        result = ""
        if "None" in location:
            raise
    return result


def getCodes(locs):
    result = []
    for ksLoc in locs:
        ksCode = readLocation(ksLoc, os.path.join(baseFolder, queryType))
        result.append(ksCode)
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
        

def createReprDict(predictions, baseFolder, queryType):
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
        # compare each sink candidate against the enclosing stm of all known sinks
        # for location in locs:
        # location.db = getDBName(location.db, os.path.join(baseFolder, queryType))
        locStm = elem["locationEnclosingStm"]
        locationStm = Location(project, path, 
                            locStm["startLine"],locStm["startColumn"], 
                            locStm["endLine"], locStm["endColumn"])
        locationStm.db = getDBName(location.db, os.path.join(baseFolder, queryType))
        locFunc = elem["locationEnclosingFunc"]
        locationFunc = Location(project, path, 
                            locFunc["startLine"],locFunc["startColumn"], 
                            locFunc["endLine"], locFunc["endColumn"])
        # compare each sink candidate against the enclosing stm of all known sinks
        # for location in locs:
        locationFunc.db = getDBName(location.db, os.path.join(baseFolder, queryType))

        if repr not in reprDict.keys():
            reprDict[repr] = set()
        reprDict[repr].add((location.toString(),  locationStm.toString(), locationFunc.toString()))
    return reprDict

def chunks(lst, n):
    """Yield successive n-sized chunks from lst."""
    for i in range(0, len(lst), n):
        yield lst[i:i + n]

import hashlib

def generateAndSaveEmbeddings():
    generateAndSaveEmbeddingsFromPredictions(dictPredRepr)
    
def generateAndSaveEmbeddingsFromPredictions(dictPredRepr):
    for repr in dictPredRepr.keys():
        print(repr)
        allLocs = list(dictPredRepr[repr])
        locsStm =  [locStm for (loc,locStm,locFunc) in allLocs]
        locsFunc =  [locFunc for (loc,locStm,locFunc) in allLocs]
        page = 0
        for locs in chunks(locsStm, 50):
            print(len(locs))
            knownCodeStm = getCodes(locs)
            # print(knownCodeStm)
            embsStm = getVectors(knownCodeStm)
            hash = hashlib.md5(repr.encode())
            filename = os.path.join(baseFolder, "embs", "sql",  "emb_"+str(page)+"_"+hash.hexdigest()+".pickle" )
            torch.save(embsStm, filename)
            page = page + 1
        for locs in chunks(locsFunc, 50):
            print(len(locs))
            knownCodeStm = getCodes(locs)
            # print(knownCodeStm)
            embsStm = getVectors(knownCodeStm)
            hash = hashlib.md5(repr.encode())
            filename = os.path.join(baseFolder, "embs", "sql", "emb_"+str(page)+"_"+hash.hexdigest()+".pickle" )
            torch.save(embsStm, filename)
            page = page + 1



def getSimilarSinks(locationStm, locationFunc, repr):
    sourceLocStm = locationStm.toString()
    sourceLocFunc = locationFunc.toString()
    queryCodeStm = readLocation(sourceLocStm,os.path.join(baseFolder,  "sql"))
    queryCodeFunc = readLocation(sourceLocFunc,os.path.join(baseFolder,  "sql"))
    selectedLocs = set()
    embeddingStm = getVectors([queryCodeStm])
    embeddingFunc = getVectors([queryCodeFunc])
    print("Negative example: ", sourceLocStm , " code: ", queryCodeStm)
    for (loc, sLoc,fLoc) in dictPredRepr[repr]:
        print(loc, sLoc, fLoc)
        destCodeStm = readLocation(sLoc,os.path.join(baseFolder,  "sql"))
        destCodeFunc = readLocation(fLoc,os.path.join(baseFolder,  "sql"))
        print(destCodeStm)
        scoreStm, l1 = query_from_candidates(destCodeStm,[sourceLocStm], embeddingStm)[0]
        scoreFunc, l2 = query_from_candidates(destCodeFunc,[sourceLocFunc], embeddingFunc)[0]
        # scoreStm = query_candidate(queryCodeStm, destCodeStm)
        # scoreFunc = query_candidate(queryCodeFunc, destCodeFunc) 
        print(scoreStm, scoreFunc)
        avgScore = (scoreStm+scoreFunc)/2
        if avgScore > 0.9:
            selectedLocs.add((loc,avgScore))
    print("Highlighted ", len(selectedLocs), "/", len(dictPredRepr[repr]))
    print(selectedLocs)
    return selectedLocs

baseFolder = "./dbs"

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


# testing embeddings for negative examples
predictionsFile = "../triager/data/predictions.json"
data = readJsonPredictions(predictionsFile)
dictPredRepr = createReprDict(data, baseFolder, queryType)
