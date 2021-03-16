#!/bin/sh

if ! (codeql version) >/dev/null 2>&1; then
   echo "CodeQL is not on the path."
   exit 1
fi

python3 run.py \
   --query-name NoSql \
   --project-list nosql_projects.txt \
   --CodeQL-executable $(which codeql) \
   --QL-source-code ../ql
