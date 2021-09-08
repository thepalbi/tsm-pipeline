# Computing similarity based on embbedings (DRAFT)

The goal is trying to leverage on code model to compute similarity between code snippets.
We use similarity either for grouping together similar sink candidates (e.g, to ban sinks similar to a negative example at the UX level of the sink prediction app) and for updating the scores of sink candidates, based on their similarity to already known sinks.

We use [CodeBert's clone detection precomputed models](https://github.com/microsoft/CodeBERT/tree/master/GraphCodeBERT/clonedetection) to compute the embeedings. 



In both cases we take a set of sink locations  (either known sinks or sink candadites) and pre compute the embedding for two kind of code snipper: i) the sink enclosing statement, ii) the sink enclosing function from the beginning until the end of the enclosing statement. 

This embeddings are gruoped by representation (e.g. all sinks matching a repr `parameter 0 (member get *)`) in chunks of 50 sinks per file.  For instance is there is 75 sinks matching the repr `parameter 0 (member get *)` there will be 4 files with embeddings: 2 files for the enclosing statement (50+25 embeddings) and 2 files for the enclosing function.

## Computing embeddings for sink predictions

Given a set of sink candidates from the file `predcitions.json` computed by the sink prediction app, we aim at obtaining a set of precomputed embeddings that could be used to quickly find similar candidates within the set of predctions.

At the UX level, we use this feature for banning similar candidates of a negative example. 


## Computing embeddings for known sources

We need to generate a csv file with the location of all known sources.

```
#!/bin/bash

for db in  `cat /persistent2/experiments/sql/sql_projects.txt` ; do echo DB=$db; codeql query run  --database=/persistent2/experiments/sql/$db  ../ql/tsm/Sql/Known-Enc.ql --search-path=/home/diegog/repos/microsoft/MSR-collab2020/tsm-js/ql:/persistent/diegog/repo2/codeql-main/codeql/ --external knownSink=/persistent2/wrk/sql/data/$db/$db-sinks-Sql.prop.csv -o /persistent/$db-ks.bqrs ; done

for db in /persisten2/experiment/sql ; do echo DB=$db; codeql bqrs decode /persistent/$db-ks.bqrs; done > KnownEnc.csv

```
