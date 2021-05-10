#! /bin/bash

MYDIR=`dirname $0`

if [ $# -ne 4 ]; then
  echo "Usage: $0 query_name scores_file test_projects threshold"
  exit 1
fi

set -e

query_name=$1
scores_file=$2
test_projects=$3
threshold=$4

case "$query_name" in
  "NoSql")
    lib="NosqlInjection"
  ;;
  "Sql")
    lib="SqlInjection"
  ;;
  "Xss")
    lib="DomBasedXss"
  ;;
  "TaintedPath")
    lib="TaintedPath"
  ;;
  *)
    echo "Unsupported query $query_name; should be NoSql, Sql, Xss or TaintedPath."
    exit 1
  ;;
esac

tsm_ql="$MYDIR/../ql"
if ! [ -d "$tsm_ql" ]; then
  echo "Could not find query library ($tsm_ql is not a directory)."
  exit 1
fi

if [ -z "$LGTM_TOKEN" ]; then
  echo "LGTM_TOKEN not set."
  exit 1
fi

# generate query
query=$(mktemp -t queryXXX.ql)
cat >$query <<EOF
/** @kind problem */

$(cat "$tsm_ql/tsm/NodeRepresentation.qll")

$(cat $scores_file)

import semmle.javascript.security.dataflow.${lib}

from DataFlow::Node nd, ${lib}::Configuration cfg, float score
where
  TsmRepr::getReprScore(rep(nd, true), "snk") = score and
  score >= ${threshold} and
  not cfg.isSink(nd) and not cfg.isSink(nd, _)
select nd, "Predicted new sink (score " + score + ")."
EOF

for test_proj in $test_projects; do
  lgtm_url="https://lgtm.com/api/v1.0/projects/${test_proj}"
  proj_id=$(curl -s $lgtm_url | jq .id)

  lgtm_url="https://lgtm.com/api/v1.0/queryjobs?language=javascript&project-id=${proj_id}"
  resp=$(mktemp -t respXXX.json)
  curl -s -o "$resp" -X POST \
       -H "Content-Type: text/plain" \
       -H "Authorization: Bearer $LGTM_TOKEN" \
       -H "Accept: application/json" \
       --data-binary @$query $lgtm_url
  if [ $(jq .code "$resp") = 429 ]; then
    echo "Rate limit exceeded; no further query jobs will be created."
    break
  fi
  query_console_url=$(jq '.["task-result"]["result-url"]' "$resp")
  if [ "$query_console_url" = "null" ]; then
    echo "Unable to determine query console URL."
    echo "Response from LGTM was:"
    cat "$resp"
    echo
  else
    echo "LGTM.com query-console URL: ${query_console_url}"
  fi
done
