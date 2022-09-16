import argparse
from utils.process import run_process, RunProcessError
from utils.clis import resolve_codeqlcli_path
from os import path

if __name__ == "__main__":
    args = argparse.ArgumentParser()
    args.add_argument(
        '--codeql-source',
        choices=['worse', 'v0'],
        dest='sources',
        required=True
    )
    args.add_argument(
        '--db',
        type=str,
        required=True,
        help='Path to the CodeQL DB being evaluated'
    )
    args.add_argument(
        '--output',
        type=str,
        required=True,
        help='BQRS output file'
    )
    pa = args.parse_args()

    root_dir = run_process('git rev-parse --show-toplevel').stdout.rstrip('\n')
    print("Root dir configured to: %s" % (root_dir))

    search_path = ''
    if pa.sources == 'worse':
        search_path = path.join(root_dir, 'lib-worse/codeql')
        query_file = 'tsm-atm-pipeline/src/tsm/evaluation/TaintedPathWorseTSM.ql'
        cli_version = '2.5.2'
    else:
        search_path = '/tesis/v0/javascript/ql/lib'
        query_file = 'tsm-evaluation/tsm-evaluation/src/PathEvaluation.ql'
        cli_version = '2.10.5'

    cli_path = resolve_codeqlcli_path(cli_version)
    query_file = path.join(root_dir, query_file)

    query_cmd = [
        '%s query run' % (cli_path),
        '-d %s' % (pa.db),
        '--search-path=%s' % (search_path),
        '--output=%s' % (pa.output),
        query_file
    ]

    try:
        ran_query = run_process(query_cmd)
        print('''
        /dev/stdout:\n%s
        /dev/stderr:\n%s
        ''' % (ran_query.stdout, ran_query.stderr))
    except RunProcessError as e:
        print("Failed to ran query: %s.\n%s\n%s" %
              (e.cmd, e.stdout, e.stderr))
