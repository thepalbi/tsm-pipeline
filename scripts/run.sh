#!/bin/sh
python run.py \
   --query-name NoSql \
   --project-list nosql_projects.txt \
   --project-dir /home/wright/ATM-JavaScript-Databases/nosql_databases \
   --CodeQL-executable /home/wright/codeql-home/codeql/codeql \
   --QL-source-code ../ql
