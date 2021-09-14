# Computing similarity based on embeddings (DRAFT)

The goal is trying to leverage code models to compute similarity between code snippets.
We use similarity both for grouping together similar sink candidates (e.g., to ban sinks similar to a negative example at the UX level of the sink prediction app) and for updating the scores of sink candidates, based on their similarity to already known sinks.

We use [CodeBERT's clone-detection precomputed models](https://github.com/microsoft/CodeBERT/tree/master/GraphCodeBERT/clonedetection) to compute the embeddings.

In both cases we take a set of sink locations  (either known sinks or sink candidates) and precompute the embedding for two kind of code snippets: 
i) the enclosing statement of the sink, ii) the enclosing function of the sink from the beginning until the end of the enclosing statement.

These embeddings are grouped by representation (e.g., all sinks matching representation `parameter 0 (member get *)`) and stored in chunks of 50 sinks.  For instance, if there are 75 sinks matching the repr `parameter 0 (member get *)` there will be four chunks for their embeddings: two chunks for the enclosing statement (50+25 embeddings) and two chunks for the enclosing function (50+25 embeddings).

## Computing embeddings for sink predictions

Given a set of sink candidates in the `predictions.json` file computed by the [sink-prediction workflow](https://github.com/github/ml-ql-taint-specification-mining/actions/workflows/predict.yml), we aim at obtaining a set of precomputed embeddings that could be used to quickly find similar candidates within the set of predictions.

At the UX level, we use this feature to blanket-ban similar candidates of negative examples.

Given a set of CodeQL databases, a `predictions.json` file and the query type (e.g., `Sql`), the script [`createEmbeddings.py`](createEmbeddings.py) uses the CodeQL databases to obtain the code snippets of the enclosing statements and functions of each predicted sink and save the embeddings in the embeddings folder (currently `$baseFolder/embs/$queryType/`).

## Querying similar sink candidates

Once all embeddings are precomputed for the prediction file, we can use them to query similar examples.

Given a sink candidate described by its position and its repr, the function `get_embeddings` yields a pair of embeddings for the candidate, one representing the enclosing statement and one the enclosing function. Given such a pair of embeddings, the function `get_similar_sinks` computes the set of locations of the sinks that have similar embeddings. This function loads the precomputed embeddings for the repr and computes the similarity to the sink candidate using cosine similarity.

It is worth noticing that these functions do not require the use of CodeBERT models as it is already precomputed, even for the sink candidate used for the query.

These functions are used by [`server.py`](server.py) which is a web service used by the UX for getting similar candidates of a banned example.

It can be used in two modes: with merged predictions (the default) or with split predictions. In merged mode, the server expects a single `predictions.json` file containing all sink candidates, and a single folder in which all embeddings are stored. In split mode, it expects a folder in which predictions are stored organized by project, and a parent folder under which folders containing embeddings for each project are stored.

The `combined.zip` file produced by the `predict.yml` workflow can be used in split mode, as follows:

- Download the `combined` artifact produced by the workflow and unzip it into a folder. (Note that you need to create that folder yourself and unzip the downloaded artifact inside it.)
- Copy the `predictions/predictions.json` file over `triager/data/predictions.json` in this repo.
- Start the server: `similarity/server.py --split-predictions --predictions /path/to/folder --embeddings /path/to/folder`.
- Start the triaging webapp: `cd triager && npm run dev`
- The webapp is now accessible through `http://localhost:3005/`.

Note that the workflow may fail to create embeddings for some (many) projects due to running out of memory. No similarity information is available for predictions on those projects, so if you try to "ban similar" it will only ban the prediction itself.

## Computing embeddings for known sinks

We also generate embeddings for a set of known sinks.
In order to do so that we generate a CSV file containing known sink from a set of CodeQL queries (e.g., SqlInjection, NoSqlInjection, TaintedPath, etc.) executed on a set of training databases. The file contains the sink source locations together with the corresponding enclosing statement and enclosing function locations.

For instance, using a set of SqlInjection DBs for the training set we can execute the following commands to produce the file `KnownEnc.csv` with the known sinks information for these DBs.

```sh
for db in  `cat ~/experiments/sql/sql_projects.txt`
do
  echo DB=$db;
  codeql query run \
   --database=~/experiments/sql/$db  \
   --search-path=~/tsm-js/ql:/persistent/diegog/repo2/codeql-main/codeql/ \
   --external knownSink=~/wrk/sql/data/$db/$db-sinks-Sql.prop.csv \
   -o /persistent/$db-ks.bqrs \
   ../ql/tsm/Known-Enc.ql
done

for db in /persisten2/experiment/sql
do
  echo DB=$db
  codeql bqrs decode /persistent/$db-ks.bqrs
done > KnownEnc.csv
```

The script [`generateKnownSourcesEmb.py`](generateKnownSourcesEmb.py) generates embeddings grouped by repr, in a similar fashion to the generation of embeddings for the sinks candidates. To do so, it obtains the known sink information from `KnownEnc.csv` and the code from DBs from the training set.

## Updating prediction scores

The `prediction.json` file uses the scores computed by TSM.
The problem with those scores is that they are computed for each repr rather than for individual sink candidates. Therefore, when a sink candidate hs the same repr as a known sink it will be assigned maximum score (i.e., score = 1), even if this particular candidate is not actually a known sink.
By comparing each sink candidate by similarity with a set of known sinks we can update the score based on how similar the sink candidate is to a known sink.
In particular, given a sink candidate the script [`updatePredictions.py`](updatePredictions.py) compares the sinks against all known sinks for its corresponding repr, obtaining the score of the closest known sink.
We  update the scores in the prediction file with the average between the original TSM score and score based on similarity.
