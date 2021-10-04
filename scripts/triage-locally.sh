#! /bin/bash

set -e

MYDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
DATA=$1
CHUNK_SIZE=${2:-1}

if [ -z "$DATA" ]; then
  echo "Usage: $0 {<workflow run id>|<archive>} [<chunk size>]"
  exit 1
fi

DATA_DIR=`mktemp -d`
echo "Storing artifacts in $DATA_DIR"

if [ -f "$DATA" ]; then
    unzip -q -o -d $DATA_DIR $DATA
else
    WORKFLOW_RUN_ID=$DATA
    gh run download "$WORKFLOW_RUN_ID" -D "$DATA_DIR" -n _results
fi

echo "Copying predictions.json file to the dashboard data directory"
cp "$DATA_DIR/predictions.json" "$MYDIR/../triager/data/predictions.json"
echo "Starting similarity server"
"$MYDIR/../similarity-api/server.py" --split-predictions --predictions "$DATA_DIR" --embeddings "$DATA_DIR" --chunk-size "$CHUNK_SIZE" &
SERVER_PID=$!
echo "Starting triaging webapp"
cd "$MYDIR/../triager"
npm run dev &
TRIAGER_PID=$!

clean_up () {
    echo "Killing child processes..."
    if [ -n "$SERVER_PID" ]; then
        kill $SERVER_PID
    fi
    if [ -n "$TRIAGER_PID" ]; then
        kill $TRIAGER_PID
    fi
    ARG=$?
    exit $ARG
}
trap clean_up EXIT

sleep 10
echo "Triaging dashboard is running on http://localhost:3005/"
echo "Press Ctrl-C to stop the server and the dashb"
read -r -d '' _ </dev/tty
