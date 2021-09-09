# Computing similarity based on embbedings (DRAFT)

The goal is trying to leverage on code model to compute similarity between code snippets.
We use similarity either for grouping together similar sink candidates (e.g, to ban sinks similar to a negative example at the UX level of the sink prediction app) and for updating the scores of sink candidates, based on their similarity to already known sinks.

We use [CodeBert's clone detection precomputed models](https://github.com/microsoft/CodeBERT/tree/master/GraphCodeBERT/clonedetection) to compute the embeedings. 


In both cases we take a set of sink locations  (either known sinks or sink candadites) and pre compute the embedding for two kind of code snipper: i) the sink enclosing statement, ii) the sink enclosing function from the beginning until the end of the enclosing statement. 

This embeddings are gruoped by representation (e.g. all sinks matching a repr `parameter 0 (member get *)`) in chunks of 50 sinks per file.  For instance is there is 75 sinks matching the repr `parameter 0 (member get *)` there will be 4 files with embeddings: 2 files for the enclosing statement (50+25 embeddings) and 2 files for the enclosing function.

## Computing embeddings for sink predictions

Given a set of sink candidates from the file `predcitions.json` computed by the sink prediction app, we aim at obtaining a set of precomputed embeddings that could be used to quickly find similar candidates within the set of predctions.

At the UX level, we use this feature for banning similar candidates of a negative examples. 

Given a `predcitions.json` file, the query type (e.g, `Sql`) `createEmbeddings.py` uses the codeql databases to obtain the code snippets of the enclosing statements and functions and save the embeddings in the folder  `$baseFolder/embs/queryType/`.

## Querying similar sink candidates
Once embedgins are precomputed  for the prediction file we can use then to query similar examples. 

Given a sink candidate describe by a pair (enclosing statement, enclosing function) and its repr, the function `getSimilarSinks` (and similarly `getSimilarSinksPaginated`, a version with less memory requirements) yield the set of locations of the sinks that are similar for that repr.

It is worth noticing that this function does not require the use of CodeBert models as it is already precomputed, even for the  sink candidate used for the query. 

These functions are use by `server.py` which is a web service used by the UX for getting similar candidates of a banned example.  
## Computing embeddings for known sources

We also generate embeddings for a set of known sinks.
In order to so that we generate a `csv` that a set of codeql queries (e.g., SqlInjection, NoSqlInjection, TaintedPath, etc) and a set of training databases collects a set of known sinks, locations together with the corresponding enclosing statement and enclosing function locations.    

For instance, using a set of SqlInjection DBs for the training set we can execute to produce the file `KnownEnc.csv` with the known sinks information of thoese DBs.

```
for db in  `cat ~/experiments/sql/sql_projects.txt` ; do echo DB=$db; codeql query run  --database=~/experiments/sql/$db  ../ql/tsm/Sql/Known-Enc.ql --search-path=~/tsm-js/ql:/persistent/diegog/repo2/codeql-main/codeql/ --external knownSink=~/wrk/sql/data/$db/$db-sinks-Sql.prop.csv -o /persistent/$db-ks.bqrs ; done

for db in /persisten2/experiment/sql ; do echo DB=$db; codeql bqrs decode /persistent/$db-ks.bqrs; done > KnownEnc.csv
```

Once there is a `csv` files with known sinks information, we use the script `generateKnownSourcesEmb.py` that will read this file and the the DBs from the training set an will generate embeddings gruopped by repr, in a similar fashion to the generation of embeddings for the sinks candidates. 

## Updating prediction scores

The `prediction.json` uses the scores computed by TSM. The problem with those score is that is it computed for repr rather than individual sink candidates. Therefore, when a sink candidate was the same repr as a known sink it will be assigned an score of one. 
By comparing each sink candidate by similarity with a set of known sinks we update the score based on how likely the sink candidate is to a known sink. 
In particular, given a sink candidate the script `updatePredictions.py` compare the sinks against all known sinks for its corresponding repr, obtainting the score of the closest known sink. We  update the scores in the prediction file with the average between the original TSM score and score based on similarity. 
