import os
import json

# from similarity import generateAndSaveEmbeddings, Location
from similarity import getSimilarSinks, Location

# Creates a dictionary repr -> [loc, stmLoc, funcLoc] out of the prediction json in memory
def createReprDict(predictions):
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
        # the enclosing stm 
        locStm = elem["locationEnclosingStm"]
        locationStm = Location(project, path, 
                            locStm["startLine"],locStm["startColumn"], 
                            locStm["endLine"], locStm["endColumn"])
        # the enclosing function 
        locFunc = elem["locationEnclosingFunc"]
        locationFunc = Location(project, path, 
                            locFunc["startLine"],locFunc["startColumn"], 
                            locFunc["endLine"], locFunc["endColumn"])
        if repr not in reprDict.keys():
            reprDict[repr] = list()
        # reprDict[repr].append((location.toString(),  locationStm.toStringFlat(), locationFunc.toStringFlat()))
        reprDict[repr].append((location,  locationStm, locationFunc))
    return reprDict

# Creates a dictionary repr -> [loc, stmLoc, funcLoc] out of the prediction json file
def readJsonPredictions(fileName):
    with open(fileName, encoding="utf-8") as source:
        data = json.load(source)        
        dictPredRepr = createReprDict(data)
        return dictPredRepr

if __name__ == "__main__":
    # testing embeddings for negative examples
    predictionsFile = "../triager/data/predictions.json.updated"
    dictPredRepr = readJsonPredictions(predictionsFile)

    # generateAndSaveEmbeddings(dictPredRepr)
    # exit()
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


    similar = getSimilarSinks(locStm, locFunc, repr)
    print(similar)
