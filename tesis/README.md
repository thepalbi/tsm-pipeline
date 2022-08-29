## Environment setup
- [Install NodeJS](https://nodejs.org/es/download/current/)
- Install Python, virutal env, configure it, and install pip `requirements.txt` file:
```bash
cd code
sudo add-apt-repository ppa:deadsnakes/ppa
sudo apt-get install python3.10 python3.10-venv build-essential
python3.10 -m venv env
source env/bin/activate
pip install -r requirements.txt
```
- Install CBC solver: `sudo apt-get install coinor-cbc`

## Downdloading a db
The expected format for database keys is:
```
<github username>/<github repo name>/<commit hash>
```

The database cache CLI supports downloading a list of databases by using the command:
```
python -m database.cli  --list <new line separated file of db keys> --cache-root <cache root, /tesis/dbs>
```

If not a single db can be cached with:
```
python -m database.cli  --key <database key> --cache-root /tesis/dbs/
```

## Docker setup
- Enable [docker buildkit](https://docs.docker.com/develop/develop-images/build_enhancements/) for [this](https://www.docker.com/blog/introduction-to-heredocs-in-dockerfiles/)

Last error got from dockerized run:
```
./scripts/docker_run.sh /bigtmp/path-sample-run.txt

FAIL: Command was  ['/cli/codeql database analyze /dbs/2.5.2/CartoDB/grainstore/a28f8c3 /ql/tsm/Path/PropagationGraph-a28f8c3-Path.ql --format=csv --logdir=/bigtmp/log/wrapper_logs --output=/results/logs//js-results.csv --search-path=/seach_path --threads=0 --external=knownSource=/bigtmp/wd/data/a28f8c3/a28f8c3-sources-Path.prop.csv --external=knownSink=/bigtmp/wd/data/a28f8c3/a28f8c3-sinks-Path.prop.csv --external=knownSanitizer=/bigtmp/wd/data/a28f8c3/a28f8c3-sanitizers-Path.prop.csv'] , return code= 2 , stdout:   , stderr:  Running queries.
ERROR: Ambiguous dependency: codeql-javascript (/ql/qlpack.yml:1,1-1)
A fatal error occurred: Could not resolve library path for /ql

g: /tesis/tmp/results//*/TaintedPathWorse-*/reprScores.txt
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
- Using CLI v2.5.2
- Generating the database from the sourcecode
    - Idea: Implement a step that generates the database, and use a cache to previously generated dbs with the following directory structure: `gh_user`/`gh_repo`/`commit_hash`/