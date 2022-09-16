import argparse
from utils.process import run_process, RunProcessError
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
    else:
        search_path = '/tesis/v0/'

    query_file = path.join(
        root_dir, 'tsm-atm-pipeline/src/tsm/evaluation/NosqlInjectionWorseTSM.ql')

    query_cmd = [
        'codeql query run',
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
