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


### FAQ

**Cuál es la diferencia entre `combinescores` y `compute_scores`?**

- [combinescores.py](../code/misc/combinescores.py): Combine scores toma una directorio con resultados (esta lógica es medio críptica) donde hay múltiples archivos de facts, y combina los puntajes asignados a cada nodo tomando una métrica de agregación (sólo AVG por ahora).
- [compute_scores.py](../code/optimizer/compute_scores.py): Este archivo contiene la lógica para a paratir de los resultados del optimizador, generar el archivo que contiene los facts (reprScores.txt). Y a partir del archivo de facts, generarl una query QL que implemenete `getReprScore`.