# Computing similarity based on embbedings (DRAFT)

The goal is trying to leverage on code model to compute similarity between code snippets.
We use similarity either for grouping together similar sink candidates (e.g, to ban sinks similar to a negative example at the UX level of the sink prediction app) and for updating the scores of sink candidates, based on their similarity to already known sinks.

We use [CodeBert's clone detection precomputed models](https://github.com/microsoft/CodeBERT/tree/master/GraphCodeBERT/clonedetection) to compute the embeedings. 


In both cases we take a set of sink locations  (either known sinks or sink candadites) and pre compute the embedding for two kind of code snippets: 
i) the sink enclosing statement, 
ii) the sink enclosing function from the beginning until the end of the enclosing statement. 

These embeddings are gruoped by representation (e.g. all sinks matching a repr `parameter 0 (member get *)`) using chunks of 50 sinks per file.  For instance, if there are 75 sinks matching the repr `parameter 0 (member get *)` there will be 4 files for their embeddings: 2 files for the enclosing statement (50+25 embeddings) and 2 files for the enclosing function (50+25 embeddings).

## Computing embeddings for sink predictions

Given a set of sink candidates in the `predcitions.json` file computed by the sink prediction app, we aim at obtaining a set of precomputed embeddings that could be used to quickly find similar candidates within the set of predctions.

At the UX level, we use this feature to automatically ban similar candidates of negative examples. 

Given a `predcitions.json` file, the query type (e.g, `Sql`) `createEmbeddings.py` uses the codeQL databases to obtain the code snippets of the enclosing statements and functions of each predicted sink and save the embeddings in the embeddings folder (currently `$baseFolder/embs/queryType/`).

## Querying similar sink candidates
Once all embedgins are precomputed for the prediction file, we can use then to query similar examples. 

Given a sink candidate described by a pair (enclosing statement, enclosing function) and its repr, the function `getSimilarSinks` yields the set of locations of the sinks that are similar for that repr. This function loads the precomputed embeddings for the repr and compute the similarity to the sink candidate using cosine similarity. 

It is worth noticing that this function does not require the use of CodeBert models as it is already precomputed, even for the  sink candidate used for the query. 

The alternative function `getSimilarSinksPaginated` with less memory requirements perform a similar task but it computes the similiraty between the sink candidate and each chunk. In this way only a chunk of embeeddins needs to be held in memory.   

These functions are used by `server.py` which is a web service used by the UX for getting similar candidates of a banned example.  

## Computing embeddings for known sinks

We also generate embeddings for a set of known sinks.
In order to do so that we generate a `csv` containing known sink from a set of codeql queries (e.g., SqlInjection, NoSqlInjection, TaintedPath, etc) executed on a set of training databases. The file containt the sink source locations together with the corresponding enclosing statement and enclosing function locations.    

For instance, using a set of SqlInjection DBs for the training set we can execute a followin commands to produce the file `KnownEnc.csv` with the known sinks information for thoese DBs.

```
for db in  `cat ~/experiments/sql/sql_projects.txt` ; do echo DB=$db; codeql query run  --database=~/experiments/sql/$db  ../ql/tsm/Known-Enc.ql --search-path=~/tsm-js/ql:/persistent/diegog/repo2/codeql-main/codeql/ --external knownSink=~/wrk/sql/data/$db/$db-sinks-Sql.prop.csv -o /persistent/$db-ks.bqrs ; done

for db in /persisten2/experiment/sql ; do echo DB=$db; codeql bqrs decode /persistent/$db-ks.bqrs; done > KnownEnc.csv
```

The script `generateKnownSourcesEmb.py`  generates embeddings gruopped by repr, in a similar fashion to the generation of embeddings for the sinks candidates. To do so, it obtains the known sink information from `KnownEnc.csv` and the code from DBs from the training set. 

## Updating prediction scores

The `prediction.json` file uses the scores computed by TSM. 
The problem with those scores is that they are computed for each repr and rather than individual sink candidates. Therefore, when a sink candidate hs the same repr as a known sink it will be assigned maximum score (i.e., score =1). 
By comparing each sink candidate by similarity with a set of known sinks we can update the score based on how likely the sink candidate is to a known sink. 
In particular, given a sink candidate the script `updatePredictions.py` compares the sinks against all known sinks for its corresponding repr, obtainting the score of the closest known sink. 
We  update the scores in the prediction file with the average between the original TSM score and score based on similarity. 
