import os
import json

# from similarity import generateAndSaveEmbeddings, Location
from similarity import  EmbeddingsReader, Location


""" 
This program just test that the embeddings are working properly
Use this before running server.py that also uses `getSimilarSinks` 
"""
if __name__ == "__main__":
    # testing embeddings for negative examples
    predictionsFile = "../triager/data/predictions.json.updated"
    baseFolder = "./dbs"
    queryType = "sql"

    embeddingsReader = EmbeddingsReader(predictionsFile, baseFolder, queryType, 50)

    locationStm = Location("g/chaibio/chaipcr", "frontend/javascripts/libs/angular-sanitize.js",
                468, 7, 468, 69)
    locationFunc = Location("g/chaibio/chaipcr", "frontend/javascripts/libs/angular-sanitize.js",
                    457, 5, 468, 69)
    repr =  "(parameter 0 (member open *))"
    # selectedSinks = getSimilarSinks(locationStm, locationFunc)

    locStm = Location.fromString("g_magda-io_magda||file:///magda-gateway/src/createAuthPluginRouter.ts:69:9:69:64")
    locFunc = Location.fromString("g_magda-io_magda||file:///magda-gateway/src/createAuthPluginRouter.ts:62:23:69:64")
    # repr = request.args.get('repr')
    repr = "(parameter 0 (member end *))"

    locStm = Location("g/bkimminich/juice-shop", "routes/chatbot.ts",
                    62, 3, 64, 3)
    locFunc = Location("g/bkimminich/juice-shop", "routes/chatbot.ts",
                    43, 1, 64, 3)
    repr = "(parameter 0 (member run *))"


    similar = embeddingsReader.getSimilarSinks(locStm, locFunc, repr)
    print(similar)
