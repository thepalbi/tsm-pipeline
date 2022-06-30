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

## Docker setup
- Enable [docker buildkit](https://docs.docker.com/develop/develop-images/build_enhancements/) for [this](https://www.docker.com/blog/introduction-to-heredocs-in-dockerfiles/)

Last error got from dockerized run:
```
[INFO   2022-06-30 05:25:00,159] DataGenerator  Generating Known data in file=[/bigtmp/wd/data/25df590/25df590-sanitizers-Path.prop.csv]
[INFO   2022-06-30 05:25:00,159] CodeQLWrapper  Running 'bqrs decode' for bqrs_file=[/dbs/2.5.2/AdguardTeam/Scriptlets/25df590/results/tsm-js/tsm/Path/Known-Path.bqrs] and result_set=[sanitizerPathClasses]
[DEBUG  2022-06-30 05:25:00,159] CodeQLWrapper  command issued: /cli/codeql bqrs decode /dbs/2.5.2/AdguardTeam/Scriptlets/25df590/results/tsm-js/tsm/Path/Known-Path.bqrs --entities=string,url --result-set sanitizerPathClasses --format=csv --output=/bigtmp/wd/data/25df590/25df590-sanitizers-Path.prop.csv
[DEBUG  2022-06-30 05:25:00,711] CodeQLWrapper  Output from codeql:
CompletedProcess(args=['/cli/codeql bqrs decode /dbs/2.5.2/AdguardTeam/Scriptlets/25df590/results/tsm-js/tsm/Path/Known-Path.bqrs --entities=string,url --result-set sanitizerPathClasses --format=csv --output=/bigtmp/wd/data/25df590/25df590-sanitizers-Path.prop.csv'], returncode=0, stdout='', stderr='')
[INFO   2022-06-30 05:25:00,712] CodeQLWrapper  Running 'database analyze' for project=[/dbs/2.5.2/AdguardTeam/Scriptlets/25df590] and query_file=[/ql/tsm/Path/PropagationGraph-25df590-Path.ql]
[DEBUG  2022-06-30 05:25:00,712] CodeQLWrapper  command issued: /cli/codeql database analyze /dbs/2.5.2/AdguardTeam/Scriptlets/25df590 /ql/tsm/Path/PropagationGraph-25df590-Path.ql --format=csv --logdir=/bigtmp/log/wrapper_logs --output=/results/logs//js-results.csv --search-path=/seach_path --threads=0 --external=knownSource=/bigtmp/wd/data/25df590/25df590-sources-Path.prop.csv --external=knownSink=/bigtmp/wd/data/25df590/25df590-sinks-Path.prop.csv --external=knownSanitizer=/bigtmp/wd/data/25df590/25df590-sanitizers-Path.prop.csv
[ERROR  2022-06-30 05:25:02,936] CodeQLWrapper  Error when executing codeql:
Running queries.
ERROR: Ambiguous dependency: codeql-javascript (/ql/qlpack.yml:1,1-1)
A fatal error occurred: Could not resolve library path for /ql

result candidates = ['/results/25df590/TaintedPathWorse-1656558072', '/results/25df590/TaintedPathWorse-1650831042', '/results/25df590/TaintedPathWorse-1650830993', '/results/25df590/TaintedPathWorse-1656556806', '/results/25df590/TaintedPathWorse-1656554010', '/results/25df590/TaintedPathWorse-1656556153', '/results/25df590/TaintedPathWorse-1656550689']
Result candidates exist
results folder = /results/25df590/TaintedPathWorse-1656558072
FAIL: Command was  ['/cli/codeql database analyze /dbs/2.5.2/AdguardTeam/Scriptlets/25df590 /ql/tsm/Path/PropagationGraph-25df590-Path.ql --format=csv --logdir=/bigtmp/log/wrapper_logs --output=/results/logs//js-results.csv --search-path=/seach_path --threads=0 --external=knownSource=/bigtmp/wd/data/25df590/25df590-sources-Path.prop.csv --external=knownSink=/bigtmp/wd/data/25df590/25df590-sinks-Path.prop.csv --external=knownSanitizer=/bigtmp/wd/data/25df590/25df590-sanitizers-Path.prop.csv'] , return code= 2 , stdout:   , stderr:  Running queries.
ERROR: Ambiguous dependency: codeql-javascript (/ql/qlpack.yml:1,1-1)
A fatal error occurred: Could not resolve library path for /ql

FAIL: Error when executing codeql, stderr: Running queries.
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