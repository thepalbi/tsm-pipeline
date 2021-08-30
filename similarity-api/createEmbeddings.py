import os
import json

from similarity import generateAndSaveEmbeddings, readJsonPredictions, Location

if __name__ == "__main__":
    # testing embeddings for negative examples
    predictionsFile = "../triager/data/predictions.json.updated"
    dictPredRepr = readJsonPredictions(predictionsFile)

    generateAndSaveEmbeddings(dictPredRepr)
    exit()
