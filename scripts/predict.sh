#! /bin/bash

MYDIR=`dirname $0`

if [ $# -ne 4 ]; then
  echo "Usage: $0 scores_file test_projects output_file query_name"
  exit 1
fi

set -ex

scores_file=$1
test_projects=$2
output_file=$3
query_name=$4

if ! [ -f $scores_file ]; then
  echo "scores file $scores_file does not exist"
  exit 1
fi

tsm_ql="$MYDIR/../ql"
if ! [ -d "$tsm_ql" ]; then
  echo "Could not find query library ($tsm_ql is not a directory)."
  exit 1
fi

# manually splice scores into query
query=$tsm_ql/predict-sinks.ql
cat $scores_file | tail -n +2 | head -n -1 >$scores_file.body
sed -i -e "/external float getReprScore/{r $scores_file.body" -e "d}" $query

echo "Query:"
cat $query

# run it on all databases
dbRoot=$MYDIR/databases
$MYDIR/fetch_database.py $dbRoot $test_projects $query_name
for db in $dbRoot/*; do
  mkdir -p $db/results
  codeql query run -o $db/results/sink-predictions.bqrs -d $db $query
done

# generate JSON representation of results
$MYDIR/../triager/predictions2json.js $dbRoot $test_projects >$output_file