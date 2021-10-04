#! /usr/bin/env python

import csv
import json
import os
import sys

sys.path.insert(1, os.path.join(
    os.path.dirname(__file__), '../../similarity-api'))
import server

artifacts = sys.argv[1]
true_positives_csv = sys.argv[2]

server.setup_split_embeddings_readers(artifacts, artifacts, 1)

predictions = {}
num_predictions = 0
repr2num_predictions = {}
with open(os.path.join(artifacts, 'predictions.json')) as f:
    for prediction in json.load(f):
        location = prediction['location']
        projectName = location['projectName']
        path = location['path']
        startLine = location['startLine']
        repr = prediction['repr']
        key = f'{projectName}/{path}#L{startLine}'
        if key not in predictions:
            predictions[key] = []
        predictions[key].append(prediction)
        num_predictions += 1
        repr2num_predictions[repr] = repr2num_predictions.get(repr, 0) + 1


headers = ['projectName', 'path', 'startLine',
           'startColumn', 'endLine', 'endColumn', 'repr', 'query']
min_score = 1
prediction_with_min_score = None
max_repr_size = 0
repr_with_max_size = None
similar = {}
true_positives = set()
with open(true_positives_csv, 'r') as f:
    reader = csv.reader(f)
    for row in reader:
        if reader.line_num == 1:
            continue
        key = f'{row[0]}/{row[1]}#L{row[2]}'
        if key not in predictions:
            continue
        for prediction in predictions[key]:
            repr = prediction['repr']
            if repr != row[6]:
                continue

            score = prediction['score']
            if score < min_score:
                min_score = score
                prediction_with_min_score = f'{key}: {repr}'

            repr_size = repr2num_predictions[repr]
            if repr_size > max_repr_size:
                max_repr_size = repr_size
                repr_with_max_size = repr

            loc = server.unserializeLocation(prediction['location'])
            locStm = server.unserializeLocation(
                prediction['locationEnclosingStm'])
            true_positives.add((loc, repr))
            if (loc, repr) not in similar:
                sim = server.get_similar(locStm, repr)
                similar[(loc, repr)] = sim
                for s, _ in sim:
                    if (s, repr) not in similar:
                        similar[(s, repr)] = sim

for (loc, repr) in true_positives:
    max_fp_similarity_score = 0
    for sim, similarity_score in similar[(loc, repr)]:
        if (sim, repr) not in true_positives:
            if similarity_score > max_fp_similarity_score:
                max_fp_similarity_score = similarity_score
    if max_fp_similarity_score > 0:
        print(f'True positive {loc} {repr} is similar to a false positive (similarity score {max_fp_similarity_score})')

print(
    f'Prediction with minimum score: {prediction_with_min_score} ({min_score}))')
print(
    f'Coarsest repr: {repr_with_max_size} ({max_repr_size}/{num_predictions}={max_repr_size/num_predictions})')
