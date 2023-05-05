---
title: benjamin-button
description: ""
date: 2023-05-05T15:13:56.860Z
preview: ""
draft: true
tags: []
categories: []
---

Descubri que la versión de la CLI no determina que dbs correr, ni que versión de las librerias. Son backwards compatible. Esto quiere decir que tomando la última versión de la CLI (2.13.1), puedo correr:
- [x] Entrenamiento, usando bejamin button como libs (agregandolas en el search path), y usando dbs compiladas con 2.5.2
- [x] Evaluacion v0, usando v0 como libs (agregandolas en el search path), y usando dbs compiladas con 2.5.2
- [ ] Evaluacion worse boosted, usando benjamin button como libs (agregandolas en el search path), agregando los boosteos como external predicates, y usando dbs compiladas con 2.5.2

Ejemplo de corrida de una query de training:
```
(env) ➜  codeql /home/pablo/clis/codeqlcli-v2.13.1/codeql database analyze /home/pablo/dbcache/2.5.2/Sv443/JokeAPI/f2c757a20bdc385edcf57b811ec8cc1a72899432 /home/pablo/tesis/tsm-pipeline/ql/tsm/Path/Known-Path.ql --format=csv --output=/tmp/js-results.csv --search-path=/home/pablo/tesis/tsm-pipeline/lib-worse/codeql/javascript/ql --timeout=600 --threads=0
Running queries.
Compiling query plan for /home/pablo/tesis/tsm-pipeline/ql/tsm/Path/Known-Path.ql.
WARNING: Unused predicate domEventSource (/home/pablo/tesis/tsm-pipeline/lib-worse/codeql/javascript/ql/lib/semmle/javascript/DOM.qll:386,32-46)
WARNING: Unused predicate maybePromisified (/home/pablo/tesis/tsm-pipeline/lib-worse/codeql/javascript/ql/lib/semmle/javascript/frameworks/NodeJSLib.qll:598,32-48)
WARNING: A graph query must define the @id property. (/home/pablo/tesis/tsm-pipeline/ql/tsm/Path/Known-Path.ql:1,1-3,4)
WARNING: A graph query must select an edge relation. (/home/pablo/tesis/tsm-pipeline/ql/tsm/Path/Known-Path.ql:1,1-3,4)
[1/1] Found in cache: /home/pablo/tesis/tsm-pipeline/ql/tsm/Path/Known-Path.ql.
Known-Path.ql: [1/1 eval 11.1s] Results written to tsm-js/tsm/Path/Known-Path.bqrs.
Shutting down query evaluator.
Interpreting results.

```

Ejemplo de corrida de una query de evaluación v0:
```
(env) ➜  codeql /home/pablo/clis/codeqlcli-v2.13.1/codeql query run --database=/home/pablo/dbcache/2.5.2/Sv443/JokeAPI/f2c757a20bdc385edcf57b811ec8cc1a72899432 /home/pablo/tesis/tsm-pipeline/tsm-evaluation/tsm-evaluation/src/PathEvaluation.ql --output=/tmp/js-results-2.csv --search-path=/home/pablo/codeqlv0/javascript/ql/lib --timeout=600 --threads=0       
Compiling query plan for /home/pablo/tesis/tsm-pipeline/tsm-evaluation/tsm-evaluation/src/PathEvaluation.ql.
[1/1] Found in cache: /home/pablo/tesis/tsm-pipeline/tsm-evaluation/tsm-evaluation/src/PathEvaluation.ql.
PathEvaluation.ql: [1/1 eval 3.4s] Results written to /tmp/js-results-2.csv.
Shutting down query evaluator.
```