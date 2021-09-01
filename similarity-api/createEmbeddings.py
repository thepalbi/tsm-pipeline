import os
import json

from similarity import generateAndSaveEmbeddingsForPredictions, readJsonPredictions, Location

if __name__ == "__main__":
    # testing embeddings for negative examples
    predictionsFile = "../triager/data/predictions.json.updated"
    baseFolder = "./dbs"
    queryType = "sql" 

    generateAndSaveEmbeddingsForPredictions(predictionsFile, baseFolder, queryType)
    exit()
