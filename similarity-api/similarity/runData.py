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


def readKnownLoc(file_loc:str):
    knownSinks = open(file_loc, 'r', errors='replace', encoding='utf-8').readlines()
    knownsStm =  list()
    knownsFunc =  list()
    db = ""
    for line in knownSinks:
        if line.startswith("DB="):
            db = line[3:].strip()
            print(db)
            continue
        if line.startswith('"nd",'):
            continue
        if not line.startswith("\""):
            continue
        if not "file:" in line:
            continue
        if '"col1"' in line:    
            continue
        if ' ?)' in line:    
            continue
        if "10'" in line:    
            continue

        columns = line.split(",")
        url = columns[1]
        urlStm = db+"||"+url
        knownsStm.append(urlStm)
        # temporary (until I can compute enclosing functions) get a few lines before the enclosing statement
        urlFunc = extendStrLocation(url)
        knownsFunc.append(db+"||"+urlFunc)
        #  print(line)
         
    return (knownsStm, knownsFunc)

def loadKnownSinkEmbs():
    embsStm1 = torch.load( "knownStm1.pickle")
    embsStm2 = torch.load( "knownStm2.pickle")
    embsStm = torch.cat((embsStm1, embsStm2),0).cpu()
    return embsStm

def loadKnownSinkExtendedEmbs():
    embsFunc1 = torch.load( "knownF1.pickle")
    embsFunc2 = torch.load( "knownF2.pickle")
    embsFunc = torch.cat((embsFunc1, embsFunc2),0).cpu()
    return embsFunc



def readLocs(fileName): 
    print("Reading locs")
    locsDict = dict()
    with open(fileName) as source:
        lines = source.readlines()
        for line in lines:
            columns = line.split(",")
            size = len(columns)
            if(size<4):
                continue
            sLoc = columns[size-3].strip()
            repr = columns[size-1].strip()
            if(size>4):
                size = size -1
            sink = columns[size-4].strip()
            locsDict[sLoc] = (sink, repr)
    return locsDict

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


def getKnowCodes(knownSinks):
    result = []
    for ksLoc in knownSinks:
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


def generateAndSaveEmbeddings(knownSinksLocStm,knownSinksLocFunc):
    knownCodeStm = getKnowCodes(knownSinksLocStm)
    knownCodeFunc = getKnowCodes(knownSinksLocFunc)

    embsStm = getVectors(knownCodeStm)
    torch.save(embsStm, "knownStm1.pickle")

    embsFunc = getVectors(knownCodeFunc)
    torch.save(embsFunc, "knownF1.pickle")


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

def readPredictions(fileName):
    locs = [] 
    with open(fileName, encoding="utf-8") as source:
        data = json.load(source)        
        for elem in data:
            loc = elem["locationEnclosingStm"]
            # print(loc)
            path = loc["path"] 
            project = loc["projectName"]
            location = Location(project, path, 
                                loc["startLine"],loc["startColumn"], 
                                loc["endLine"], loc["endColumn"])
            locs.append(location)
            # print(sLoc)
    return locs
        

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
# tokenizer = AutoTokenizer.from_pretrained("mrm8488/codebert-finetuned-clone-detection")
# model = AutoModel.from_pretrained("mrm8488/codebert-finetuned-clone-detection")
# tokenizer = RobertaTokenizer.from_pretrained("microsoft/codebert-base")
# model = RobertaModel.from_pretrained("microsoft/codebert-base")
torch.cuda._initialized = True
model.to(device)
model.eval()

SIMILARITY_THRESHOLD=0.90
MAX_LEN = 512

# load locations of knows sinks, and same locations extended to get more context
# knownSinksLocStm,knownSinksLocFunc = readKnownLoc(os.path.join(baseFolder, "KnownEnc.csv"))

# testing embeddings for negative examples
predictionsFile = "../triager/data/predictions.json"
data = readJsonPredictions(predictionsFile)
dictPredRepr = createReprDict(data, baseFolder, queryType)
locationStm = Location("g/bkimminich/juice-shop", "frontend/src/app/product-details/product-details.component.spec.ts",
                92, 5, 92, 102)
locationFunc = Location("g/bkimminich/juice-shop", "frontend/src/app/product-details/product-details.component.spec.ts",
                88, 67, 92, 102)
repr = "(parameter 0 (member query *))"

# "projectName": "g/bkimminich/juice-shop", "path": "routes/chatbot.ts",
#   "startLine": 62,
#   "startColumn": 3,
#   "endLine": 64,
#   "endColumn": 3
locationStm = Location("g/bkimminich/juice-shop", "routes/chatbot.ts",
                62, 3, 64, 3)
locationFunc = Location("g/bkimminich/juice-shop", "routes/chatbot.ts",
                43, 1, 64, 3)
repr = "(parameter 0 (member run *))"

locationStm = Location("g/QBisConsult/psql-api", "kdman.js",
                36, 1, 36, 63)
locationFunc = Location("g/QBisConsult/psql-api", "kdman.js",
                1, 1, 36, 63)
repr = "(parameter 0 (member all *))"


# locationStm = Location("g/chaibio/chaipcr", "frontend/javascripts/libs/angular-sanitize.js",
#                 468, 7, 468, 69)
# locationFunc = Location("g/chaibio/chaipcr", "frontend/javascripts/libs/angular-sanitize.js",
#                 457, 5, 468, 69)
# repr =  "(parameter 0 (member open *))"
locationStm.db = getDBName(locationStm.db, os.path.join(baseFolder, queryType))
locationFunc.db = getDBName(locationFunc.db, os.path.join(baseFolder, queryType))
# selectedSinks = getSimilarSinks(locationStm, locationFunc)

locStm = Location.fromString("g_magda-io_magda||file:///magda-gateway/src/createAuthPluginRouter.ts:69:9:69:64")
locFunc = Location.fromString("g_magda-io_magda||file:///magda-gateway/src/createAuthPluginRouter.ts:62:23:69:64")
# repr = request.args.get('repr')
repr = "(parameter 0 (member end (local res)))"
# similar = getSimilarSinks(locStm, locFunc, repr)