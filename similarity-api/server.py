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


def get_similar(locStm, repr):
    similar = set()
    embeddings_reader = get_embeddings_reader(locStm)
    if embeddings_reader is not None:
        embStm, embFunc = embeddings_reader.get_embeddings(locStm, repr)
        if embStm is not None and embFunc is not None:
            for embeddings_reader in get_all_embeddings_readers():
                similar.update(embeddings_reader.get_similar_sinks(
                    embStm, embFunc, repr))
    return similar


@app.route('/similar', methods=['POST'])
def calculate():
    body = request.get_json(force=True)
    locStm, _, repr = unserializeJsonBody(body)
    similar = get_similar(locStm, repr)

    print(similar)
    response_to_serialize = [
        {
            "location": Location.fromString(loc.toString()).as_dict(),
            "score": score
        }
        for (loc, score) in similar
    ]
    return jsonify(response_to_serialize)


def setup_merged_embeddings_reader(predictions, embeddings, chunk_size):
    global embeddingsReaders, merged_predictions
    merged_predictions = True
    embeddingsReaders = {
        '*': EmbeddingsReader(predictions, embeddings, chunk_size)
    }


def setup_split_embeddings_readers(predictions, embeddings, chunk_size):
    global embeddingsReaders, merged_predictions
    merged_predictions = False
    embeddingsReaders = {}
    for file in os.listdir(predictions):
        if file.endswith('-predictions'):
            key = file[:-len('-predictions')]
            predictions_json = os.path.join(predictions, file, file + '.json')
            embeddings_dir = os.path.join(embeddings, key + '-embeddings')
            if os.path.isfile(predictions_json) and os.path.isdir(embeddings_dir):
                embeddingsReaders[key] = EmbeddingsReader(
                    predictions_json, embeddings_dir, chunk_size)


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

    if not args.split_predictions:
        setup_merged_embeddings_reader(
            args.predictions, args.embeddings, args.chunk_size)
    else:
        setup_split_embeddings_readers(
            args.predictions, args.embeddings, args.chunk_size)

    app.run(host=os.getenv('IP', '0.0.0.0'),
            port=int(os.getenv('PORT', 4444)), debug=True)
