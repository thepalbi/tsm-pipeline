import genericpath
import os

from scipy.sparse import base
from transformers import AutoTokenizer, AutoModel
from torch.utils.data import DataLoader, SequentialSampler,TensorDataset
import torch
import torch.nn.functional as F
import json
import numpy as np
from tqdm import tqdm
from sklearn.metrics.pairwise import cosine_similarity
import sys
from .location import Location
from .location import getCodes
import glob


from typing import List

# Obtains chunks of list. Used to read pieces of candidates
def chunks(lst, n):
    """Yield successive n-sized chunks from lst."""
    for i in range(0, len(lst), n):
        yield lst[i:i + n]


def encode(inputs):
    outputs = model(inputs,attention_mask = inputs.ne(1))[0]
    # Fixed mean pooling
    outputs = outputs = (outputs*inputs.ne(1).unsqueeze(-1)).sum(1)/inputs.ne(1).sum(-1).unsqueeze(-1)
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
            knownCodeStm = getCodes(locs, baseFolder, queryType)
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


def generateAndSaveEmbeddings(dictPredRepr):
    generateAndSaveEmbeddingsFromPredictions(dictPredRepr)
    
def generateAndSaveEmbeddingsFromPredictions(dictPredRepr):
    print(len(dictPredRepr.keys()))
    for repr in dictPredRepr.keys():
        print(repr)
        generateEmbeddingsForRepr(dictPredRepr, repr)

def generateEmbeddingsForRepr(dictPredRepr, repr):
    allLocs = list(dictPredRepr[repr])
    locsStm =  [locStm for (loc,locStm,locFunc) in allLocs]
    locsFunc =  [locFunc for (loc,locStm,locFunc) in allLocs]
    page = 0
    for locs in chunks(locsStm, 50):
        print(len(locs))
        hash = hashlib.md5(repr.encode())
        filename = os.path.join(baseFolder, "embs", "sql",  "emb_"+str(page)+"_"+hash.hexdigest()+".pickle" )
        if not os.path.isfile(filename):
            knownCodeStm = getCodes(locs, baseFolder, queryType)
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
            knownCodeStm = getCodes(locs, baseFolder, queryType)
                # print(knownCodeStm)
            embsFunc = getVectors(knownCodeStm)
            torch.save(embsFunc, filename)
        else:
            print("File: ", filename, " for ", repr, " ", page, " exists")
        page = page + 1


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


