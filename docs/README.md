## Docs

## Project architecture

Running the whole TSM architecture is split in three main phases:
1. Running the orchestrator, which does the extraction, model building and optimization phase
2. Combining the scores of multiple ran projects
3. Evaluating the performance of the learnt specifications

### 1. Running the orchestrator

Use dockerized version here.

Use the script [docker_run.sh](../code/scripts/docker_run.sh).

### 2. Combining the scores of multiple run projects

This involves using the `combinescores.py` script.

<mark>TODO: Specify better waht the results-dir should be</mark>

```
python code/misc/combinescores.py --results-dir <directory with step 1 results> --query-name <query name> --out <output file path>
```

### 3. Evaluation

Por ejemplo tomemeos Tainted Path. Se me ocurre que podría calcular los scores
```
def getmetrics(actual, predicted, c):
    # Precision
    scores = dict()
    scores["actual"] = sum(actual)
    scores["predicted"] = sum(predicted)
    scores["precision"] = precision_score(actual, predicted)
    scores["recall"] = recall_score(actual, predicted)
    scores["f1"] = f1_score(actual, predicted)
    return scores
```
tomando la estrategia que tenemos pensada de `Worse`, `WorseBoosted` y `V0` o `GroundTruth`. Para v0, podría tomar un commit upstream de CodeQL, y utilizar las customizations que hay, por ejemplo [esta](https://github.com/github/codeql/blob/main/javascript/ql/lib/semmle/javascript/security/dataflow/TaintedPathQuery.qll) para TaintedPath.

The command below will run the evaluation evaluation query either worse, or boosted
<mark>TODO: Corroborate that worse is running worse and not boosted</mark>

```
#/tesis/dbs/2.5.2/firewalla/firewalla/ae3090c680a7264255bd1b05a7297e0daf51e470
DB=<CodeQL DB to run against>
python -m scripts.evaluate --db $DB --codeql-source <v0 or worse> --output <file path to write bqrs with results to>
```

After running this for the same DB, in `worse`, `boosted` and `v0`, one can decode the results by doing:
`./scripts/codeql.sh 2.5.2 bqrs decode --result-set=#select --format csv --output <CSV file to write results to> <BQRS file with query results>`

<mark>TODO: Implement given the query results from all 3 flavours, calculte resulting scores.</mark>
<mark>TODO: Implement some way of easily running everything, even for multiple projects</mark>

## Tools

### Cache CLI

The cache CLI can be used to download databases and compile them with a configured CodeQL CLI version, as follows:
```
python -m database.cli  --key <repo key> --cache-root <cache root>
```
Note the `<cache root>` directory is just a plain directory, where the whole cache is structure is maininted. That is:
- A subfolder will be created for the current CodeQL CLI version
- A subfolder will be created for the DB repository owner
- A subfolder will be created for the DB repository name
- A subfolder will be created for the DB repository commit
- Compiled DB is located here


### FAQ

**Cuál es la diferencia entre `combinescores` y `compute_scores`?**

- [combinescores.py](../code/misc/combinescores.py): Combine scores toma una directorio con resultados (esta lógica es medio críptica) donde hay múltiples archivos de facts, y combina los puntajes asignados a cada nodo tomando una métrica de agregación (sólo AVG por ahora).
- [compute_scores.py](../code/optimizer/compute_scores.py): Este archivo contiene la lógica para a paratir de los resultados del optimizador, generar el archivo que contiene los facts (reprScores.txt). Y a partir del archivo de facts, generarl una query QL que implemenete `getReprScore`.