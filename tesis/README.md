## Installation

See [installation](../docs/installation.md)

## Downdloading a db
The expected format for database keys is:
```
<github username>/<github repo name>/<commit hash>
```

The database cache CLI supports downloading a list of databases by using the command:
```
python -m database.cli  --list <new line separated file of db keys> --cache-root <cache root, /tesis/dbs> --cli-version <compiler version>
```

If not a single db can be cached with:
```
python -m database.cli  --key <database key> --cache-root /tesis/dbs/ --cli-version <compiler version>
```

If the same dbs are needed for multiple CLI versions, a list of versions can be specified

```
python -m database.cli  --key <database key> --cache-root /tesis/dbs/ --cli-version <compiler version1>,<compiler version 2>
```

## Docker setup
Add a configuration file under `code/scripts/config.sh`, with the following contents according to your system:
```bash
# Directory where the tsm-pipelien QL sources are located
export QL_LIB_DIR=/home/pablo/tesis/tsm-pipeline/ql
# Lib worse CodeQL javascript library
export QL_LIB_WORSE_DIR=/home/pablo/tesis/tsm-pipeline/lib-worse/codeql/javascript/ql/lib
# dependency lib of worse
export QL_JAVASCRIPT_UPGRADES=/home/pablo/.codeql/packages/codeql/javascript-upgrades/0.0.3
# tmp
export TMP_DIR=/tmp
# database cache root directory
export CACHE_DBS_DIR=/home/pablo/dbcache
# Root dir for the CodeQL clis directory
export CODEQL_CLIS_ROOT=/home/pablo/clis
# Directory where the CodeQL CLI binary is located
export CLI_DIR=/home/pablo/clis/codeqlcli-v2.13.1
```

## Running notes
### 24-04-2022
- Got this query running: `tsm-atm-pipeline/src/tsm/evaluation/TaintedPathWorseTSM.ql`
- Pude hacer un corrida e2e con el proyecto de abajo
```
python main.py \
    --steps generate_entities,generate_model,optimize \
    --project-dir /tesis/dbs/2.5.2/AdguardTeam/Scriptlets/25df590 \
    --query-type Path \
    --query-name TaintedPathWorse \
    --solver CBC \
    run
```


## Notes
- lib-worse commit that doens't work: 2d618d6b92. Error:
- trying commits a1c38b78a9bf7ad7efc9d3559a93e9415bbdd182 found in Diego's vscode workspace

```
A fatal error occurred: The CodeQL database at /tesis/dbs/zuzak_gov.zk_859ae98
is not compatible with the QL library ../ql/tsm/Path/Known-Path.ql uses.
The database may be too new for the QL libraries the query is using; try upgrading them.
Alternatively, running 'codeql database upgrade /tesis/dbs/zuzak_gov.zk_859ae98' with an appropriate --search-path option might help.
```

Got it working after:
- Using commit `a1c38b78a9` for CodeQL libraries
- Using CLI [v2.5.2](https://github.com/github/codeql-cli-binaries/releases/tag/v2.5.2) and [v2.10.5](https://github.com/github/codeql-cli-binaries/releases/tag/v2.10.5)
- Generating the database from the sourcecode
    - Idea: Implement a step that generates the database, and use a cache to previously generated dbs with the following directory structure: `gh_user`/`gh_repo`/`commit_hash`/