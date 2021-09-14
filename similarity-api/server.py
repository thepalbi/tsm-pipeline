from flask import request
from flask import Flask
from flask import jsonify
from flask_cors import CORS

import argparse
import os

from similarity import EmbeddingsReader, Location

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
    # server.py [--predictions FILE] [--embeddings DIR]
    parser = argparse.ArgumentParser(
        description='Create a web server providing embedding-based similarity information for the given predictions.')
    here = os.path.dirname(__file__)
    parser.add_argument('--predictions', type=str, help='Path to the predictions file.',
                        default=os.path.join(here, '../triager/data/predictions.json.updated'))
    parser.add_argument('--embeddings', type=str, help='Path to the directory under which the corresponding embeddings are stored.',
                        default=os.path.join(here, 'dbs/embs/sql'))
    args = parser.parse_args()

    embeddingsReader = EmbeddingsReader(args.predictions, args.embeddings, 50)

    app.run(host=os.getenv('IP', '0.0.0.0'),
            port=int(os.getenv('PORT', 4444)), debug=True)
