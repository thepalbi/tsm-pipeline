#!/bin/bash
# fail on first error
set -e

ROOT_DIR=$(git rev-parse --show-toplevel)

# Load configs
. $ROOT_DIR/code/scripts/config.sh

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

# Create log directory in temp if no present
if [ ! -d $TMP_DIR/log ]; then
    echo "Creating log dir at $TMP_DIR/log"
    mkdir $TMP_DIR/log
fi

PROJECT_LIST_FILE=$1
if [ "${PROJECT_LIST_FILE:0:1}" != "/" ]; then
    echo "Prject list path should be absolute"
    exit 1
fi

MOUNTED_LIST_FILE=/data/list.txt

RESULTS_DIR=$2

if [[ "$RESULTS_DIR" == "" ]] ; then
    echo "Missing results dir"
    exit 1
fi

O11Y_EXPERIMENT_NAME=$3
if [[ "$O11Y_EXPERIMENT_NAME" == "" ]] ; then
    echo "experiment name shoulnd't be empty"
    exit 1
fi


# This is hardcoded
O11Y_DB_DIR="/tesis/repos/tsm-pipeline/code/tsm.db"
O11Y_CONTAINER_DB_DIR="/data/tracking.db"

# Docker based run of the orchestrator pipeline
# Runs the dockerized version of TSM pipeline, mounting the necessary bind volumes
function tsm-run() {
    docker run \
    -e "CODEQL_CLIS_ROOT=$CODEQL_CLIS_ROOT" \
    -v $CLI_DIR:/cli: \
    -v $QL_LIB_DIR:/ql: \
    -v $QL_LIB_WORSE_DIR:/worse_lib: \
    -v $TMP_DIR:/bigtmp: \
    -v $RESULTS_DIR:/results: \
    -v $CACHE_DBS_DIR:/dbs: \
    -v $PROJECT_LIST_FILE:$MOUNTED_LIST_FILE:ro \
    -v $O11Y_DB_DIR:$O11Y_CONTAINER_DB_DIR:rw \
    github.com/thepalbi/tsm-main:latest $@
}

cat << EOF
Running TSM in docker:
- Reading projects from: $PROJECT_LIST_FILE
- Results will be in: $RESULTS_DIR

Beggining container execution...
EOF

# Run the TSM learning pipeline for the provided project list. This will have the following characteristics:
# - Use CBC as solver
# - Run the whole orchestrator for each project individually
tsm-run \
--steps generate_entities,generate_model,optimize \
--project.cache_dir /dbs \
--project-list $MOUNTED_LIST_FILE \
--query-type Path \
--query-name TaintedPathWorse \
--solver CBC \
--o11y.db_path $O11Y_CONTAINER_DB_DIR \
--o11y.name $O11Y_EXPERIMENT_NAME \
run

# Combine scores generated for all the results above
python -m misc.combinescores --results-dir $RESULTS_DIR --query-name TaintedPathWorse --out $RESULTS_DIR/averaged-results.txt --raw-out $RESULTS_DIR/averaged-results.csv