#!/bin/bash

# Simple run of the orchestrator pipeline

if [[ "$1" == "" ]] ; then
    echo "Missing project list file"
    exit 1
fi

# Used for legacy method of fetching project databases
# --project-dir /tesis/dbs/2.5.2/AdguardTeam/Scriptlets/25df590 \

# Run the TSM learning pipeline for the provided project list. This will have the following characteristics:
# - Use CBC as solver
# - Run the whole orchestrator for each project individually
python main.py \
    --steps generate_entities,generate_model,optimize \
    --project.cache_dir /tesis/dbs \
    --project-list $1 \
    --query-type Path \
    --query-name TaintedPathWorse \
    --solver CBC \
    run

# Combine scores generated for all the results above
python -m misc.combinescores --results-dir /tesis/tmp/results/ --query-name TaintedPathWorse --out averaged-results.txt