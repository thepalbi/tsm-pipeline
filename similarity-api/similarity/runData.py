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
    embeddings = encode(inputs).cpu()
    # dataset = TensorDataset(inputs)
    # dataloader = DataLoader(dataset, sampler=SequentialSampler(dataset), batch_size=32)   
    # # obtain embeddings
    # embeddings = []
    # for batch in tqdm(dataloader):
    #     print(batch)
    #     embeddings.append(encode(batch[0]))
    
    # embeddings = torch.cat(embeddings,0).cpu()

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

def query_candidates(query, locCodes, code_vecs):
    inputs1 = tokenizer(query,return_tensors='pt', max_length=MAX_LEN, padding=True,truncation=True)['input_ids']
    query_vec = encode(inputs1).cpu()
    scores=torch.einsum("ab,cb->ac",query_vec,code_vecs)[0]
    print(scores)
    # search
    probs, ids = scores.topk(len(locCodes))
    return list([(float(x),locCodes[int(y)]) for x,y in zip(probs, ids)])

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
            reprDict[repr] = list()
        reprDict[repr].append((location.toString(),  locationStm.toStringFlat(), locationFunc.toStringFlat()))
    return reprDict

def chunks(lst, n):
    """Yield successive n-sized chunks from lst."""
    for i in range(0, len(lst), n):
        yield lst[i:i + n]

import hashlib
def loadKnownSinkEmbForRepFake(repr, dictPredRepr, prefix):
    if repr in dictPredRepr.keys(): 
        allLocs = list(dictPredRepr[repr])
        locsStm =  [locStm for (loc,locStm,locFunc) in allLocs]
        locsFunc =  [locFunc for (loc,locStm,locFunc) in allLocs]
        page = 0
        embsStm = None
        for locs in chunks(locsStm, 50):
            print(len(locs))
            hash = hashlib.md5(repr.encode())
            knownCodeStm = getCodes(locs)
            print("Locs:", locs)
            # print(knownCodeStm)
            knownCodeStm = [knownCodeStm[3]]*len(locs)
            embsStm1 = getVectors(knownCodeStm)
            page = page + 1
            if embsStm is None:
                embsStm = embsStm1
            else:
                embsStm = torch.cat((embsStm, embsStm1),0).cpu()
    return embsStm, allLocs


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
            hash = hashlib.md5(repr.encode())
            filename = os.path.join(baseFolder, "embs", "sql",  "emb_"+str(page)+"_"+hash.hexdigest()+".pickle" )
            if not os.path.isfile(filename):
                knownCodeStm = getCodes(locs)
                # print(knownCodeStm)
                embsStm = getVectors(knownCodeStm)
                torch.save(embsStm, filename)
            else: 
                print("File: ", filename, " for ", repr, " ", page, " exists")
            page = page + 1
        page = 0
        for locs in chunks(locsFunc, 50):
            print(len(locs))
            hash = hashlib.md5(repr.encode())
            filename = os.path.join(baseFolder, "embs", "sql", "embF_"+str(page)+"_"+hash.hexdigest()+".pickle" )
            if not os.path.isfile(filename):
                knownCodeStm = getCodes(locs)
                # print(knownCodeStm)
                embsFunc = getVectors(knownCodeStm)
                torch.save(embsFunc, filename)
            else:
                print("File: ", filename, " for ", repr, " ", page, " exists")
            page = page + 1

def query_from_candidates(emb,locCodes,code_vecs, pos):
    # obtain query embeddings
    # inputs = tokenizer(query,return_tensors='pt', max_length=MAX_LEN, padding=True,truncation=True)['input_ids']
    # query_vec = encode(inputs).cpu()
    query_vec = emb

    # calculate
    # test using cosine:  
    query_np = query_vec.detach().numpy()
    code_vec_np = code_vecs.detach().numpy()
    # similarity = cosine_similarity( query_np, code_vec_np)
    similarity = cosine_similarity( [code_vec_np[pos]], code_vec_np)
    scores = torch.tensor(similarity)

    # alternative from Daya
    # scores=torch.einsum("ab,cb->ac",query_vec,code_vecs)[0]
    # scores=torch.einsum("ab,cb->ac",code_vecs[pos],code_vecs)[0]
    print("pos: ", pos)
    print("scores:", scores)
    # search
    # probs, ids = scores[0].topk(len(locCodes))
    # print(probs)
    # print(ids)
    # print(list([(float(x),locCodes[y]) for x,y in zip(scores[0], range(len(locCodes)))]))
    return list([(float(x),locCodes[y]) for x,y in zip(scores[0], range(len(locCodes)))])
    # return list([(float(x),locCodes[int(y)]) for x,y in zip(probs, ids)])


def checkLocation(embs, locs, queryEmb, queryLoc):
    pos = locs.index(queryLoc)
    results = query_from_candidates(queryEmb, locs, embs, pos)
    # print(results)
    return results
 


def getSimilarSinks(locationStm, locationFunc, repr):
    embsAllStm, allLocs = loadKnownSinkEmbForRep(repr, dictPredRepr, "emb_")
    embsAllFunc, allLocs = loadKnownSinkEmbForRep(repr, dictPredRepr, "embF_")
    sourceLocStm = locationStm.toStringFlat()
    sourceLocFunc = locationFunc.toStringFlat()
    queryCodeStm = readLocation(sourceLocStm,os.path.join(baseFolder,  "sql"))
    queryCodeFunc = readLocation(sourceLocFunc,os.path.join(baseFolder,  "sql"))


    selectedLocs = set()
    embeddingStm = getVectors([queryCodeStm])
    embeddingFunc = getVectors([queryCodeFunc])
    
    allLocs = list(dictPredRepr[repr])
    locsStm =  [locStm for (loc,locStm,locFunc) in allLocs]
    locsFunc =  [locFunc for (loc,locStm,locFunc) in allLocs]

    print("Negative example: ", sourceLocStm , " code: ", queryCodeStm)
    resultStm = checkLocation(embsAllStm, locsStm, embeddingStm,sourceLocStm)
    resultFunc = checkLocation(embsAllFunc, locsFunc, embeddingFunc,sourceLocFunc)
    # resultStm = query_candidates(queryCodeStm, locsStm, embsAllStm)
    # resultFunc = query_candidates(queryCodeFunc, locsFunc, embsAllFunc)
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

def getSimilarSinksOrig(locationStm, locationFunc, repr):
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
        scoreStm,_ = query_candidates(destCodeStm,[sourceLocStm], embeddingStm)[0]
        scoreFunc,_ = query_candidates(destCodeFunc,[sourceLocFunc], embeddingFunc)[0]
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

SIMILARITY_THRESHOLD=0.80
MAX_LEN = 512


# testing embeddings for negative examples
predictionsFile = "../triager/data/predictions.json.updated"
data = readJsonPredictions(predictionsFile)
dictPredRepr = createReprDict(data, baseFolder, queryType)
