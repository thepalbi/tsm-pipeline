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


import hashlib

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


