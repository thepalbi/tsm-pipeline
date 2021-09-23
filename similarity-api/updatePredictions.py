import argparse
import json
import os
from typing import List
from unittest import result

import numpy as np
import torch
from sklearn.metrics.pairwise import cosine_similarity
import zipfile

from similarity import EmbeddingsReader, Location
import hashlib

def get_embeddings_reader(locStm):
    key = '*' if merged_predictions else locStm.db.replace('/', '_')
    return embeddingsReaders.get(key)


def get_all_embeddings_readers():
    return embeddingsReaders.values()

"""
Read the csv file of known sinks produced with the query Known-Enc.ql
Applying that query to a set of DBs produces the csv file that is read 
with this function.
Note: We plan to eventually remove this function and read directly the embeddings
from a pickle files without resorting on the cvs file.  
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
                knownsStm[repr] = list()
            knownsStm[repr].append(location)
            if repr not in knownsFunc.keys():
                knownsFunc[repr] = list()
            knownsFunc[repr].append(locationFunc)
            
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

# load  only one page of precomputed  embeddings  for a given repr into one tensor 
def loadKnownSinkEmbForRepChunk(repr, knownSinksLoc, embeddingsFolder,  prefix, page, chunk_size, useZipFile = False):
    if repr in knownSinksLoc.keys():     
        allLocs = list(knownSinksLoc[repr])[page*chunk_size:(page+1)*chunk_size]
        # print(repr, len(allLocs))
        # page = 0
        embs = None
        try:            
            hash = hashlib.md5(repr.encode())
            filename = os.path.join(prefix + str(page)+"_"+hash.hexdigest()+".pickle" )
            if useZipFile:
                zipFile = os.path.join(embeddingsFolder,"EmbKnownFunc.zip")
                if prefix == "knownStm_":
                    zipFile = os.path.join(embeddingsFolder,"EmbKnownStm.zip")
                with zipfile.ZipFile(zipFile) as z:
                    print("Extracting: ", filename)
                    z.extract(filename, embeddingsFolder)
                    embs = torch.load(os.path.join(embeddingsFolder,filename))
                    os.remove(os.path.join(embeddingsFolder,filename))
            else:
                embs = torch.load(os.path.join(embeddingsFolder,filename))
               # print(embs.size())
        except Exception as e:
            print(f"There was a problem loading ks embeddings: {e}")
        return embs, allLocs
    return None, None

def getMostSimilarCandidateWithEmb(locCodes, code_vecs, emb):
    """
    Query a candidate (that exists in the repr) against the set of other candidates for the repr.
    Return the candidate with highest similarity.
    """
    # calculate
    # test using cosine:
    similarity = cosine_similarity([emb], code_vecs)
    scores = torch.tensor(similarity)[0]
    # print("scores:", scores)
    probs, ids = scores.topk(1)
    results = list([(float(x),locCodes[int(y)]) for x,y in zip(probs, ids)])[0]
    return (results[1], results[0])

def chunks(lst, n):
    """Yield successive n-sized chunks from lst."""
    for i in range(0, len(lst), n):
        yield lst[i:i + n]


def predictionsJsonToMemory(fileName):
    with open(fileName, encoding="utf-8") as predictionsFile:
        source = predictionsFile.read()
        if source.strip() == "":
            return []
        data = json.loads(source)
        return data


def processOneLocationWithEmbedding(location, embLoc, knownSinksLoc, embeddingsFolder, prefix, allLocs, repr, chunk_size):
    maxScore = 0
    maxLoc = None
    page = 0
    # check if the repr has embeddings
    if repr in knownSinksLoc.keys():     
        # access the embeddings in chunks
        for locs in chunks(allLocs, chunk_size):
            #print(page, " ", repr, " ", prefix, " alllocs:", len(allLocs))
            embs, allLocsChunk = loadKnownSinkEmbForRepChunk(repr, knownSinksLoc, embeddingsFolder, prefix, page, chunk_size)
            page = page + 1
            # compute distance between the enclosing stm and the closest sink candidate 
            if embs is not None:
                code_vec_np = embs.detach().numpy()
                result = getMostSimilarCandidateWithEmb(allLocsChunk, code_vec_np, embLoc)
                # print("Match with:", result[0].toString(),  result[1])
                # print(result[0].read(os.path.join(baseFolder)))

                mostSimilarLoc = result[0] 
                score = result[1]
                #print("Score: ",score)

                # compute maximum score for enclosing stm
                if maxScore<score:
                    maxScore = score
                    maxLoc = mostSimilarLoc
            else:
                print("Is None for ", repr)

    # if the repr has no embeddings we cannot compare 
    else:
        print(repr," not found, using original scores")
        maxLoc = location
        maxScore = originalScore

    print("maxScore:",prefix," ", maxScore)
    return (maxLoc, maxScore)


def unserializeJsonElem(elem):
    serializedLocStm = elem['locationEnclosingStm']
    serializedLocFunc = elem['locationEnclosingFunc']
    repr = elem["repr"]
    locStm = unserializeLocation(serializedLocStm)
    locFunc = unserializeLocation(serializedLocFunc)
    return locStm, locFunc, repr


def unserializeLocation(sLoc):
    loc = Location(
        sLoc["projectName"],
        sLoc["path"],
        sLoc["startLine"],
        sLoc["startColumn"],
        sLoc["endLine"],
        sLoc["endColumn"])
    return loc


if __name__ == '__main__':
    # updatePredictions.py [--split-predictions] [--predictions FILE|DIR] [--embeddings DIR] [--ksembeddings DIR] [--chunk-size NUMBER] [--chunk-size-ks NUMBER]
    parser = argparse.ArgumentParser(
        description='Update prediction scores based on their similarity to known sinks.')
    here = os.path.dirname(__file__)
    parser.add_argument('--split-predictions', action='store_true',
                        help='Predictions are stored separately for each project.')
    parser.add_argument('--predictions', type=str, help='Predictions file or directory',
                        default=os.path.join(here, '../triager/data/predictions.json'))
    parser.add_argument('--embeddings', type=str, help='Directory under which the corresponding embeddings are stored.',
                        default=os.path.join(here, 'dbs/embs/sql'))
    parser.add_argument('--ksembeddings', type=str, help='Directory under which the known sinks embeddings are stored.',
                        default=os.path.join(here, 'ksEmbs'))
    parser.add_argument('--chunk-size', type=int, help='Number of predictions stored in one batch.',
                        default=50)
    parser.add_argument('--chunk-size-ks', type=int, help='Number of known sinks stored in one batch.',
                        default=50)
    args = parser.parse_args()

    merged_predictions = not args.split_predictions
    prediction_files = []
    if merged_predictions:
        embeddingsReaders = {
            '*': EmbeddingsReader(args.predictions, args.embeddings, args.chunk_size)
        }
        prediction_files.append(args.predictions)

    else:
        embeddingsReaders = {}
        for file in os.listdir(args.predictions):
            if file.endswith('-predictions'):
                key = file[:-len('-predictions')]
                predictions = os.path.join(
                    args.predictions, file, file + '.json')
                
                prediction_files.append(predictions)

                embeddings = os.path.join(args.embeddings, key + '-embeddings')
                if os.path.isfile(predictions) and os.path.isdir(embeddings):
                    print(
                        f"Creating embeddings reader for f{key} with predictions in {predictions} and embeddings under {embeddings}")
                    embeddingsReaders[key] = EmbeddingsReader(
                        predictions, embeddings, args.chunk_size)


    # knownSinksFolder = "/persistent/dbs/test/sql/embs" 
    knownSinksFolder = args.ksembeddings
    knownSinksFilename = os.path.join(knownSinksFolder,"KnownEnc2.csv")
    SIMILARITY_THRESHOLD=0.90
    MAX_LEN = 512

    chunk_size = args.chunk_size
    chunk_size_ks = args.chunk_size_ks

    print("Read known sinks")
    # load locations of knows sinks, and same locations extended to get more context
    knownSinksLocStm,knownSinksLocFunc = readKnownLoc(knownSinksFilename)

    for predictionsFile in prediction_files:
        print("Processing prediction file: ", predictionsFile)

        data = predictionsJsonToMemory(predictionsFile)
        for elem in data:
            locationStm, locationFunc, repr = unserializeJsonElem(elem)
            repr2 = '"'+repr+'"'
            maxScore1 = 0
            maxScore2 = 0
            originalScore = elem["score"]

            if repr2 in knownSinksLocStm.keys(): 
                allLocs = list(knownSinksLocStm[repr2])
                print("Processing: ", repr2, len(allLocs))

                embeddings_reader = get_embeddings_reader(locationStm)
                if embeddings_reader is not None:
                    # get the precomputed embedding for a predicted sink candidate
                    embStm, embFunc = embeddings_reader.get_embeddings(locationStm, repr)
                    if embStm is not None and embFunc is not None:
                        print("Computing scores for location: ", locationStm)
                        # compare the embedding agains the embeddings of all known sink for the repr
                        # a possible optimization is to group several sinks from the prediction together  
                        (loc1, maxScore1) = processOneLocationWithEmbedding(locationStm, embStm, knownSinksLocStm, knownSinksFolder, "knownStm_", allLocs, repr2, chunk_size_ks)
                        
                        (loc2, maxScore2) = processOneLocationWithEmbedding(locationFunc, embFunc, knownSinksLocFunc, knownSinksFolder, "knownF_", allLocs, repr2, chunk_size_ks)

                    if originalScore == 1:
                        newScore = (maxScore1+maxScore2)/2 
                    else: 
                        newScore = ( originalScore + (maxScore1+maxScore2)/2) /2 
        
                    elem["score"] = newScore

        # print(locDict)    
        os.rename(predictionsFile, predictionsFile + '.original' )
        outputFile = predictionsFile
        print("Saving: ", outputFile )
        json.dump( data, open(outputFile, 'w' ), indent=3 )

