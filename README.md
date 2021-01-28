# tsm-js
Taint Specification Mining for JavaScript. A tool to mine likely specification for CodeQL security queries in JavaScript.

## Important

The tool takes a CodeQL query and boosts it by inferring new sink candidates.
In order to work properly the tool must point to a version of the CodeQL library containing the libraries to boost.
They should be installed (or linked) under the folder `lib-worse/codeql` of the root folder.
Current version of libraries to boost is: [commit `e277a2ef6c9998c927cb6e4b277a0ac51fd6b9dd` from CodeQl repo](https://github.com/github/codeql/commit/e277a2ef6c9998c927cb6e4b277a0ac51fd6b9dd)

## Installing dependencies

Execute: `python3 -m pip install -r requirements.txt`

Then try `python -m pip install -i https://pypi.gurobi.com gurobipy` to install Python support for the `gurobi` solver.   

In OSX you may need to install `girubi` support for Python manually by executing this command: `python3 /Library/gurobiXXX/mac64/setup.py install`, where `XXX` is the version installed in your computer. Recall that you need a license to run gurobi. Academic licences are available [here](https://www.gurobi.com/academia/academic-program-and-licenses/).

## Downloading databases from LGTM

The files `nosqlinjection_projects.txt`, `sqlinjection_projects.txt`, and `xss_projects.txt` contains each one a a list of databases to be fetched from the LGTM site.

Run `python3 -m misc.scrape -dld [project-slug] -o [outputdirectory]` where
`project-slug` is one database listed in the three aforementioned files (e.g. `1046224544/fontend`). The result of the script is a zip file (e.g., `outputdirectory/1046224544-fontend.zip`) which will be placed in the folder `outputdirectory` that must exist beforehand.

Finally unzip the zip file corresponding to the downloaded database (e.g., `output/1046224544-fontend.zip`)

# Executing the analysis pipeline using the Orchestrator
The `Orchestrator` can be used to execute each phase of the analysis pipeline.
The pipeline at the moment has the following steps implemented:

- `generate_entities`: Generate `repr` functions for sources/sinks/sanitizers, propagation graph nodes and edges and a node-to-`repr` mapping  (intermediate results in `working-dir/data`).
- `generate_model`: Generate `gurobi` model to optimize (intermediate results in `working-dir/constrains`)
- `optimize`: Run `gurobi` with the model generated in the `generate_model` step (intermediate results in `working-dir/model`)
-  (disabled)  `generate_tsm_query`: Build a TSM query out of the resulting scores.
- `count_reps`: Additional step that allows for computing the number of occurrences. That can be used in the `generate_model` step to filter infrequent representations.


These steps can be executed individually or all together in an end-to-end runner. You can use the orchestrator in code, or with its CLI. The latter one is located in `main.py`.

First, configure the `config.json` file, which has to be located at the `constraintsolving/` root dir. It has the following properties:

```json
{
  "codeQLExecutable": "absolute path to the CodeQL executable",
  "codeQLSourcesRoot": "absolute path to this project's root directory (where the `.git` folder lives)",
  "workingDirectory": "absolute path to the working directory",
  "resultsDirectory": "absolute path to the results dir",
  "searchPath": "absolute path where the CodeQL libraries resides",
  "worseLibSearchPath": "absolute path where the CodeQL libraries (containing the worse version) resides"
}
```

The `workingDirectory` determines the location where all working files (e.g., csv files, constraints, and gurobi model) are placed.
`resultsDirectory` is the place where the resulting files of the process (e.g, `reprScores.txt`)
are placed. Both directories can be overwritten by using (optional) command line options.

Then, you can either run the whole pipeline

```bash
python main.py --project-dir output/abhinavkumarl-bidding-system/ --query-type Xss --query-name DomBasedXssWorse --results-dir /results/xss --working-dir /wrk/xss --steps=generate_entities,generate_model,optimize run
```

or only specific steps. For instance the following command will first compute the occurrences and then use then to filter the less frequent representations before building the model.

```bash
python main.py --project-dir output/abhinavkumarl-bidding-system/ --steps=count_reps,generate_model,optimize --query-type Xss --query-name DomBasedXssWorse run
```

Additionally, a set of databases can be processed (either a single step or all steps) by using the option `--projects-list`. For instance:

```bash
# Run the whole pipeline on multiple projects:
python main.py --project-dir output/xss/ --query-type Xss --query-name DomBasedXssWorse --results-dir /results/xss --working-dir /wrk/xss --project-list xss_projects.txt generate_model,optimize run
```

Because some of the step generate large intermediary files, we have added a clean step. At the moment (https://github.com/garbervetsky/ql/commit/91b21f301b871dd44213f2b60d27d324c44509c7), this just cleans the following intermediate folders:
- `models`
- `constraints`
- `logs`

To run in clean mode, use the following command:

```bash
python main.py --project-dir output/abhinavkumarl-bidding-system/ --query-type Xss --query-name DomBasedXssWorse clean
```

To see more options or get help from the CLI:

```bash
python main.py --help
```

## Combine the scores from each database
Once the pipeline has been executed, individual results can be combined to get an aggregated result for a set of DBs.

Use `python3 misc/combinescores.py` to combine the scores from each database.
This will generate the file `allscores_[query_type]_avg.txt`.
This file must be included in the target `query-type`:  `codeql/javascript/ql/src/TSM/tsm_repr_pred.qll` and then re-execute the `generate_tsm_query` step.
This can be done with the command:

```bash
 python3 main.py --project-dir output  --query-name DomBasedXssWorse --query-type Xss  --results-dir .  --working-dir /wrk/xss --project-list xss_projects.txt  --single-step generate_tsm_query --scores-file allscores_DomBasedXssWorse_avg.txt
 ```

This command will recompute the queries on *all* the projects contained in the list `xss_projects.txt` using the the combined score `allscores_DomBasedXssWorse_avg.txt` intead of the individual `reprScores.txt` of each individual project.

You can also include the option `--multiple` in `main.py` to build a model for all projects together. This will generate one `reprScores.txt` in a special folder named `multiple`.
