#! /usr/bin/env python3

import argparse
import os

from similarity import generateAndSaveEmbeddingsForPredictions

if __name__ == "__main__":
    # createEmbeddings.py [--predictions FILE] [--databases DIR] [--query-type TYPE] [--output DIR]
    parser = argparse.ArgumentParser(
        description='Create embeddings for the given predictions.')
    here = os.path.dirname(__file__)
    parser.add_argument('--predictions', type=str, help='Path to the predictions file.',
                        default=os.path.join(here, '../triager/data/predictions.json.updated'))
    parser.add_argument('--databases', type=str, required=False,
                        help='Path to the directory under which the corresponding CodeQL databases are stored.')
    parser.add_argument('--query-type', type=str,
                        default='sql', help='Type of query to use.')
    parser.add_argument('--output', type=str, required=False,
                        help='Path to the directory under which the embeddings should be stored.')
    args = parser.parse_args()
    if args.databases is None:
        args.databases = os.path.join(here, 'dbs', args.query_type)
    if args.output is None:
        args.output = os.path.join(args.databases, 'embs', args.query_type)

    generateAndSaveEmbeddingsForPredictions(
        args.predictions, args.databases, args.query_type, args.output)
