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


def encode(inputs):
    outputs = model(inputs,attention_mask = inputs.ne(1))[0]
    # mean pooling
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

def chunks(lst, n):
    """Yield successive n-sized chunks from lst."""
    for i in range(0, len(lst), n):
        yield lst[i:i + n]

import hashlib

def generateAndSaveEmbeddings(knownSinksLocStm,knownSinksLocFunc):
    queryType = "sql"
    prefix = "knownStm_"
    generateEmbeddings(knownSinksLocStm, queryType, prefix)

    prefix = "knownF_"
    generateEmbeddings(knownSinksLocFunc, queryType, prefix)

def generateEmbeddings(knownSinksLoc, queryType, prefix):
    for repr in knownSinksLoc.keys():
        print(repr)
        allLocs = list(knownSinksLoc[repr])
        page = 0
        for locs in chunks(allLocs, 50):
            print(len(locs))
            knownCodeStm = getCodes(locs, baseFolder, queryType)
            # print(knownCodeStm)
            embsStm = getVectors(knownCodeStm)
            hash = hashlib.md5(repr.encode())
            filename = os.path.join(embeddingsBaseFolder, "sql", "embs", prefix+str(page)+"_"+hash.hexdigest()+".pickle" )
            torch.save(embsStm, filename)
            page = page + 1


from location import Location
import glob

    
if __name__ == '__main__':
    # baseFolder = "/persistent/dbs"
    baseFolder = "/home/diegog/repos/microsoft/MSR-collab2020/tsm-js/similarity-api/dbs"
    embeddingsBaseFolder = "/persistent/dbs/test"

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
    knownSinksFilename = "KnownEncTest.csv" #"KnownEnc2.csv"
    knownSinksLocStm,knownSinksLocFunc = readKnownLoc(os.path.join(baseFolder, knownSinksFilename))

    # this is to create embeddings once
    print("Generating embeddings for known sinks")
    generateAndSaveEmbeddings(knownSinksLocStm,knownSinksLocFunc)
    # exit()


    

