#! /usr/bin/env python3

import argparse
import os

from similarity import generateAndSaveEmbeddingsForPredictions

if __name__ == "__main__":
    # createEmbeddings.py [--predictions FILE] [--databases DIR] [--output DIR] [--chunk-size NUMBER]
    parser = argparse.ArgumentParser(
        description='Create embeddings for the given predictions.')
    here = os.path.dirname(__file__)
    parser.add_argument('--predictions', type=str, help='Path to the predictions file.',
                        default=os.path.join(here, '../triager/data/predictions.json.updated'))
    parser.add_argument('--databases', type=str, help='Path to the directory under which the corresponding CodeQL databases are stored.',
                        default=os.path.join(here, 'dbs/sql'))
    parser.add_argument('--output', type=str, help='Path to the directory under which the embeddings should be stored.',
                        default=os.path.join(here, 'dbs/embs/sql'))
    parser.add_argument('--chunk-size', type=int, help='Number of predictions to process in one batch.',
                        default=50)
    args = parser.parse_args()

    generateAndSaveEmbeddingsForPredictions(
        args.predictions, args.databases, args.output, args.chunk_size)
