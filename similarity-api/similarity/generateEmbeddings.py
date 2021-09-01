import genericpath
import os

from transformers import AutoTokenizer, AutoModel
from torch.utils.data import DataLoader, SequentialSampler,TensorDataset
import torch
import torch.nn.functional as F
import json
import numpy as np
from tqdm import tqdm
import sys
from .location import Location
from .location import getCodes
import glob
import hashlib

from typing import List

MAX_LEN = 512
CHUNK_SIZE = 50

def loadPrecomputedModel():
    # load precomputed model
    device = torch.device("cuda" if torch.cuda.is_available() else "cpu")
    tokenizer = AutoTokenizer.from_pretrained("microsoft/graphcodebert-base")
    model = AutoModel.from_pretrained("microsoft/graphcodebert-base")
    torch.cuda._initialized = True
    model.to(device)
    model.eval()
    return model, tokenizer

# Obtains chunks of list. Used to read pieces of candidates
def chunks(lst, n):
    """Yield successive n-sized chunks from lst."""
    for i in range(0, len(lst), n):
        yield lst[i:i + n]

def generateAndSaveEmbeddingsForPredictions(dictPredRepr, baseFolder, queryType):
    embbedingsGenerator = EmbbedingsGenerator(baseFolder, queryType, MAX_LEN, CHUNK_SIZE)        
    # Generate and save embeddings for set of sinks for each repr
    print(len(dictPredRepr.keys()))
    for repr in dictPredRepr.keys():
        print(repr)
        embbedingsGenerator.generateEmbeddingsForRepr(dictPredRepr, repr)


class EmbbedingsGenerator:
    def __init__(self, baseFolder, queryType, max_len = MAX_LEN, chunk_size = CHUNK_SIZE):
        self.baseFolder = baseFolder
        self.queryType = queryType
        self.chunk_size = chunk_size
        self.max_len = max_len
        self.model, self.tokenizer = loadPrecomputedModel()

    def encode(self, inputs):
        outputs = self.model(inputs,attention_mask = inputs.ne(1))[0]
        # Fixed mean pooling
        outputs = outputs = (outputs*inputs.ne(1).unsqueeze(-1)).sum(1)/inputs.ne(1).sum(-1).unsqueeze(-1)
        # F2 norm 
        outputs = F.normalize(outputs, p=2, dim=1)
        return outputs
        
    def getVectors(self, codes):
        # build dataset
        inputs = self.tokenizer(codes,return_tensors='pt',max_length=self.max_len, padding=True,truncation=True)['input_ids']
        embeddings = self.encode(inputs).cpu()
        # dataset = TensorDataset(inputs)
        # dataloader = DataLoader(dataset, sampler=SequentialSampler(dataset), batch_size=32)   
        # # obtain embeddings
        # embeddings = []
        # for batch in tqdm(dataloader):
        #     print(batch)
        #     embeddings.append(encode(batch[0]))
        
        # embeddings = torch.cat(embeddings,0).cpu()

        return embeddings

    # Generate and save embeddings for set of sinks for the repr
    def generateEmbeddingsForRepr(self, dictPredRepr, repr):
        allLocs = list(dictPredRepr[repr])
        locsStm =  [locStm for (loc,locStm,locFunc) in allLocs]
        locsFunc =  [locFunc for (loc,locStm,locFunc) in allLocs]
        page = 0
        for locs in chunks(locsStm, self.chunk_size):
            print(len(locs))
            hash = hashlib.md5(repr.encode())
            filename = os.path.join(self.baseFolder, "embs", "sql",  "emb_"+str(page)+"_"+hash.hexdigest()+".pickle" )
            if not os.path.isfile(filename):
                knownCodeStm = getCodes(locs, self.baseFolder, self.queryType)
                    # print(knownCodeStm)
                embsStm = self.getVectors(knownCodeStm)
                torch.save(embsStm, filename)
            else: 
                print("File: ", filename, " for ", repr, " ", page, " exists")
            page = page + 1
        page = 0
        for locs in chunks(locsFunc, self.chunk_size):
            print(len(locs))
            hash = hashlib.md5(repr.encode())
            filename = os.path.join(self.baseFolder, "embs", "sql", "embF_"+str(page)+"_"+hash.hexdigest()+".pickle" )
            if not os.path.isfile(filename):
                knownCodeStm = getCodes(locs, self.baseFolder, self.queryType)
                    # print(knownCodeStm)
                embsFunc = self.getVectors(knownCodeStm)
                torch.save(embsFunc, filename)
            else:
                print("File: ", filename, " for ", repr, " ", page, " exists")
            page = page + 1






