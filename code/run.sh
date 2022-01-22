#!/bin/bash

python main.py \
    --solver CBC \
    --project-dir /tesis/dbs/zuzak_gov.zk_859ae98 \
    --query-type Path \
    --query-name TaintedPathWorse \
    --steps $1 \
    run