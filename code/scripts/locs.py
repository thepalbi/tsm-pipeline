from clients.cli import CLIClient
from database.cache import DatabasesCache, Parsedkey
import tempfile
import argparse

"""
./scripts/codeql.sh 2.13.1 database run-queries --additional-packs=/home/pablo/tesis/tsm-pipeline/lib-worse/codeql/javascript/ql/lib:$HOME/.codeql/packages/codeql/javascript-upgrades/0.0.3/ -- /home/pablo/dbcache/2.5.2/18F/checklistomania/9865774 /home/pablo/tesis/tsm-pipeline/queryplayground/locs.ql
"""

locs_bqrs_path = "getting-started/codeql-extra-queries-javascript/locs.bqrs"
t = "18F/checklistomania/9865774"


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--list", type=str, required=True,
                        help="file containing the list of DBs to work with")
    parser.add_argument("--out", type=str, required=True,
                        help="file where to write LOCs")
    args = parser.parse_args()

    db_keys = []
    with open(args.list, "r") as f:
        for l in f.readlines():
            l = l.rstrip()
            db_keys.append(l)

    cache = DatabasesCache(root_dir="/home/pablo/dbcache", cli_version="2.5.2")
    codeql = CLIClient(version="2.13.1")

    out_file = open(args.out, "w")
    out_file.write("name,locs\n")
    for key in db_keys:
        with tempfile.NamedTemporaryFile() as bqrs_out:
            _, cached_db_path = cache.get(key)
            codeql.query_run(db=cached_db_path,
                             query="/home/pablo/tesis/tsm-pipeline/queryplayground/locs.ql",
                             search_path=[
                                 "/home/pablo/tesis/tsm-pipeline/lib-worse/codeql/javascript/ql/lib",
                                 "/home/pablo/.codeql/packages/codeql/javascript-upgrades/0.0.3/"
                             ], output=bqrs_out.name)
            lines_raw = codeql.bqrs_decode(
                bqrs=bqrs_out.name, format="csv", result_set=None)
            lines = int(lines_raw.split('\n')[1])
            out_line = "%s,%d" % (key, lines)
            out_file.write("%s\n" % out_line)
            print(out_line)

    out_file.close()
