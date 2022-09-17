#!/bin/bash

RESULTS_DIR=$2

# Docker based run of the orchestrator pipeline
# Runs the dockerized version of TSM pipeline, mounting the necessary bind volumes
function tsm-run() {
    docker run \
        -v /tesis/clis/codeqlcli-v2.10.5:/cli: \
        -v /tesis/repos/tsm-pipeline/ql:/ql: \
        -v /tesis/repos/tsm-pipeline/lib-worse/codeql/javascript/ql/src:/worse_lib: \
        -v /tesis/tmp:/bigtmp: \
        -v $RESULTS_DIR:/results: \
        -v /tesis/dbs:/dbs \
        github.com/thepalbi/tsm-main:latest $@
}

if [[ "$1" == "--help" ]] ; then
    tsm-run --help
    exit 0
fi

if [[ "$1" == "" ]] ; then
    echo "Missing project list file"
    exit 1
fi

PROJECT_LIST_FILE=$1

if [[ "$RESULTS_DIR" == "" ]] ; then
    echo "Missing results dir"
    exit 1
fi

# Run the TSM learning pipeline for the provided project list. This will have the following characteristics:
# - Use CBC as solver
# - Run the whole orchestrator for each project individually
tsm-run --steps generate_entities,generate_model,optimize \
    --project.cache_dir /dbs \
    --project-list $PROJECT_LIST_FILE \
    --query-type Path \
    --query-name TaintedPathWorse \
    --solver CBC \
    run

# Combine scores generated for all the results above
python -m misc.combinescores --results-dir $RESULTS_DIR --query-name TaintedPathWorse --out $RESULTS_DIR/averaged-results.txt