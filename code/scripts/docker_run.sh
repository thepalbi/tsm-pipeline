#!/bin/bash

# Docker based run of the orchestrator pipeline

# Runs the dockerized version of TSM pipeline, mounting the necessary bind volumes
function tsm-run() {
    docker run \
        -v /tesis/clis/codeqlcli-v2.5.2:/cli: \
        -v /tesis/repos/tsm-pipeline/ql:/ql: \
        -v /tesis/repos/tsm-pipeline/lib-worse/codeql:/search_path: \
        -v /tesis/repos/tsm-pipeline/lib-worse/codeql/javascript/ql/src:/worse_lib: \
        -v /tesis/tmp:/bigtmp: \
        -v /tesis/tmp/results:/results: \
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

# Run the TSM learning pipeline for the provided project list. This will have the following characteristics:
# - Use CBC as solver
# - Run the whole orchestrator for each project individually
tsm-run --steps generate_entities,generate_model,optimize \
    --project.cache_dir /dbs \
    --project-list $1 \
    --query-type Path \
    --query-name TaintedPathWorse \
    --solver CBC \
    run

# Combine scores generated for all the results above
python -m misc.combinescores --results-dir /tesis/tmp/results/ --query-name TaintedPathWorse --out averaged-results.txt