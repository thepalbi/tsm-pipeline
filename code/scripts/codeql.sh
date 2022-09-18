#!/bin/bash

set -o pipefail

VERSION=$1

if [[ "$VERSION" == "" ]]; then
    echo "Available CodeQL CLI versions:"
    for CLI in $(ls /tesis/clis/codeqlcli-*/codeql); do
        echo "* $($CLI version -q)"
    done
    echo "Usage: $0 <version> commands..."
    exit 1
fi

shift 1
ARGS=$@

CLI_PATH=$(python -m scripts.codeql_cli_path $VERSION)
$CLI_PATH $ARGS

