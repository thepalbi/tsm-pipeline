#!/bin/bash

VERSION=$1

if [[ "$VERSION" == "" ]]; then
    AVAILABLE=$(ls /tesis/clis/)
    echo "Available CLI versions"
    echo "$AVAILABLE"
    exit 1
fi

shift 1
ARGS=$@

CLI_PATH=$(python -m scripts.codeql_cli_path $VERSION)
$CLI_PATH $ARGS

