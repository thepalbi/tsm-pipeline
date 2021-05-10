#! /bin/bash

MYDIR=`dirname $0`

if [ $# -ne 2 ]; then
  echo "Usage: $0 query_name training_projects"
  exit 1
fi

set -ex

query_name=$1
training_projects=$2

codeql=$(which codeql || true)
if [ -z "$codeql" ]; then
  echo "CodeQL not found."
  exit 1
fi

tsm_ql="$MYDIR/../ql"
if ! [ -d "$tsm_ql" ]; then
  echo "Could not find query library ($tsm_ql is not a directory)."
  exit 1
fi

# write training projects to a temporary file
tmpfile=$(mktemp -t projectsXXX.csv)
for project in $training_projects; do
  echo $project >> $tmpfile
done

# run TSM
python3 $MYDIR/run.py \
  --query-name $query_name --project-list $tmpfile \
  --CodeQL-executable $codeql --QL-source-code $tsm_ql
