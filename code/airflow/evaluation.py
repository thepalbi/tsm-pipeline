from datetime import date, timedelta, datetime
from airflow import DAG
from airflow.operators.bash import BashOperator
from textwrap import dedent

with DAG(
    'tsm-evaluation',
    default_args={
        'depends_on_past': False,
        'retries': 1,
        'retry_delay': timedelta(seconds=10)
    },
    description="TSM evaluation pipeline [WIP]",
    schedule_interval=None,
    tags=["TSM"],
    start_date=datetime(2022, 9, 16),
) as dag:

    target_project = "/tesis/dbs/2.5.2/firewalla/firewalla/ae3090c680a7264255bd1b05a7297e0daf51e470"
    def bqrs_output(
        query): return "/tesis/outputs/firewalla-%s-3.bqrs" % (query)

    def csv_output(query): return "/tesis/outputs/firewalla-%s-3.csv" % (query)

    evaluate_worse_and_boosted = BashOperator(
        task_id="evaluate_worse_and_boosted",
        bash_command=dedent("""
        python -m scripts.evaluate \
            --db  %s\
            --codeql-source %s \
            --output %s 
        """ % (target_project, "worse", bqrs_output("worse"))),
        cwd="/tesis/repos/tsm-pipeline/code"
    )

    decode_worse_boosted = BashOperator(
        task_id="decode_worse_boosted",
        bash_command=dedent("""
        ./scripts/codeql.sh 2.5.2 bqrs decode --result-set=#select --format csv \
            --output %s %s 
        """ % (csv_output("worse"), bqrs_output("worse"))),
        cwd="/tesis/repos/tsm-pipeline/code"
    )

    evaluate_worse_and_boosted >> decode_worse_boosted
