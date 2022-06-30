#!/bin/bash

if [[ "$1" == "" ]] ; then
    echo "Missing project list file"
    exit 1
fi

# Used for legacy method of fetching project databases
# --project-dir /tesis/dbs/2.5.2/AdguardTeam/Scriptlets/25df590 \

python main.py \
    --steps generate_entities,generate_model,optimize \
    --project.cache_dir /tesis/dbs \
    --project-list $1 \
    --query-type Path \
    --query-name TaintedPathWorse \
    --solver CBC \
    run