#!/bin/sh
python run.py \
   --query-name NoSql \
   --project-list nosql_projects.txt \
   --CodeQL-executable /home/wright/codeql-home/codeql/codeql \
   --QL-source-code ../ql
