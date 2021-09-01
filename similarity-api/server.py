from flask import request
from flask import Flask
from flask import jsonify
from flask_cors import CORS

import os

from similarity import  EmbeddingsReader, Location

app = Flask(__name__)
CORS(app)

def unserializeJsonBody(body):
    serializedLocStm = body['locStm']
    serializedLocFunc = body['locFunc']
    repr = body["repr"]
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


@app.route('/similar', methods=['POST'])
def calculate():
    body = request.get_json(force=True)
    locStm, locFunc, repr = unserializeJsonBody(body)
    similar = embeddingsReader.getSimilarSinks(locStm, locFunc, repr)
    print(similar)
    response_to_serialize = [
        {
            "location": Location.fromString(loc.toString()).as_dict(),
            "score": score
        }
        for (loc, score) in similar
    ]
    return jsonify(response_to_serialize)


if __name__ == "__main__":
    predictionsFile = "../triager/data/predictions.json.updated"
    baseFolder = "./dbs"
    queryType = "sql"

    embeddingsReader = EmbeddingsReader(predictionsFile, baseFolder, queryType, 50)

    app.run(host=os.getenv('IP', '0.0.0.0'),
            port=int(os.getenv('PORT', 4444)), debug=True)
