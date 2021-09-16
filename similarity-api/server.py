#! /usr/bin/env python3

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


merged_predictions = True


def get_embeddings_reader(locStm):
    key = '*' if merged_predictions else locStm.db.replace('/', '_')
    return embeddingsReaders.get(key)


def get_all_embeddings_readers():
    return embeddingsReaders.values()


@app.route('/similar', methods=['POST'])
def calculate():
    body = request.get_json(force=True)
    locStm, _, repr = unserializeJsonBody(body)

    similar = set()
    embeddings_reader = get_embeddings_reader(locStm)
    if embeddings_reader is not None:
        embStm, embFunc = embeddings_reader.get_embeddings(locStm, repr)
        if embStm is not None and embFunc is not None:
            print("Negative example: ", locStm)
            for embeddings_reader in get_all_embeddings_readers():
                similar.update(embeddings_reader.get_similar_sinks(
                    embStm, embFunc, repr))

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
    # server.py [--split-predictions] [--predictions FILE|DIR] [--embeddings DIR] [--chunk-size NUMBER]
    parser = argparse.ArgumentParser(
        description='Create a web server providing embedding-based similarity information for the given predictions.')
    here = os.path.dirname(__file__)
    parser.add_argument('--split-predictions', action='store_true',
                        help='Predictions are stored separately for each project.')
    parser.add_argument('--predictions', type=str, help='Predictions file or directory if --split-predictions is specified.',
                        default=os.path.join(here, '../triager/data/predictions.json.updated'))
    parser.add_argument('--embeddings', type=str, help='Directory under which the corresponding embeddings are stored.',
                        default=os.path.join(here, 'dbs/embs/sql'))
    parser.add_argument('--chunk-size', type=int, help='Number of predictions stored in one batch.',
                        default=50)
    args = parser.parse_args()

    merged_predictions = not args.split_predictions
    if merged_predictions:
        embeddingsReaders = {
            '*': EmbeddingsReader(args.predictions, args.embeddings, args.chunk_size)
        }
    else:
        embeddingsReaders = {}
        for file in os.listdir(args.predictions):
            if file.endswith('-predictions'):
                key = file[:-len('-predictions')]
                predictions = os.path.join(
                    args.predictions, file, file + '.json')
                embeddings = os.path.join(args.embeddings, key + '-embeddings')
                if os.path.isfile(predictions) and os.path.isdir(embeddings):
                    print(
                        f"Creating embeddings reader for f{key} with predictions in {predictions} and embeddings under {embeddings}")
                    embeddingsReaders[key] = EmbeddingsReader(
                        predictions, embeddings, args.chunk_size)

    app.run(host=os.getenv('IP', '0.0.0.0'),
            port=int(os.getenv('PORT', 4444)), debug=True)
