#!/bin/bash

ROOT=$(git rev-parse --show-toplevel)

OUTPUT=$1
OUTPUT_CMD=""
if [[ "$1" != "" ]]; then
    echo "Writing query output to BQRS file: $1"
    OUTPUT_CMD="--output=$1"
fi

codeql query run $OUTPUT_CMD \
    -d /tesis/dbs/2.5.2/firewalla/firewalla/ae3090c680a7264255bd1b05a7297e0daf51e470 \
    --search-path=$ROOT/lib-worse/codeql \
    $ROOT/tsm-atm-pipeline/src/tsm/evaluation/NosqlInjectionWorseTSM.ql