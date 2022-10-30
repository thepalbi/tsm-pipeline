#!/bin/bash

ROOT_DIR=$(git rev-parse --show-toplevel)

# Load configs
. $ROOT_DIR/code/scripts/config.sh

RESULTS_DIR=$2

# Docker based run of the orchestrator pipeline
# Runs the dockerized version of TSM pipeline, mounting the necessary bind volumes
function tsm-run() {
    docker run \
        # Configure CodeQL CLIs repository
        -e "CODEQL_CLIS_ROOT=$CODEQL_CLIS_ROOT" \
        -v $CLI_DIR:/cli: \
        -v $QL_LIB_DIR:/ql: \
        -v $QL_LIB_WORSE_DIR:/worse_lib: \
        -v $TMP_DIR:/bigtmp: \
        -v $RESULTS_DIR:/results: \
        -v $CACHE_DBS_DIR:/dbs \
        github.com/thepalbi/tsm-main:latest $@
}

if [[ "$1" == "--help" ]] ; then
    echo "
    HELP:
    $0 <project list file in CONTAINER volume> <results dir in HOST>
    "

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

cat << EOF
Running TSM in docker:
- Reading projects from: $PROJECT_LIST_FILE
- Results will be in: $RESULTS_DIR

Beggining container execution...
EOF

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
python -m misc.combinescores --results-dir $RESULTS_DIR --query-name TaintedPathWorse --out $RESULTS_DIR/averaged-results.txt --raw-out $RESULTS_DIR/averaged-results.csv