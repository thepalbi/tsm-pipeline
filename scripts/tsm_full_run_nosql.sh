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

# echo "Combining scores"
# python ../code/misc/combinescores.py --query-name NosqlInjectionWorse

