#!/bin/sh
echo "Processing databases"
python ../code/main.py \
   --project-dir /home/wright/ATM-JavaScript-Databases/nosql_databases \
   --query-name NosqlInjectionWorse \
   --query-type NoSql \
   --solver=CBC \
   --project-list nosql_projects.txt \
   --steps=generate_entities,generate_model,optimize \
   run
echo "Combining scores"
# N.B. --project-dir parameter is misnamed, it's value should be results-dir
python ../code/misc/combinescores.py --project-dir /home/wright/coding/ml-ql-taint-specification-mining/results --query-name NosqlInjectionWorse
echo "Completed: see allscores_*_avg.txt"
