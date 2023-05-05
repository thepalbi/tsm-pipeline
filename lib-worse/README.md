Please include here the CodeQL libraries where the worse versions to boost. The folder should be named `codeql`.

Commit que usaban en CodeQL para obtener los resultados: [5279db09e957b0e6b45b3b0737a949c0ba3ce589](https://github.com/github/codeql/commit/5279db09e957b0e6b45b3b0737a949c0ba3ce589), que pertence a [este branch](https://github.com/max-schaefer/codeql/commits/experimental/benjamin-button) de Max.

Este archivo ([benjamin-button.md](https://github.com/max-schaefer/codeql/blob/experimental/benjamin-button/benjamin-button.md)) contiene los cambios aplicados a las librerias para que sea más "worse".

Pushee el commit que usaban en TSM a mi [fork](https://github.com/thepalbi/codeql/tree/pablo/tesis) de CodeQL, para en todo caso, aplicarle más reverts de forma de hacerla más joven.

**Important**: Please note that the tool currently relies on all the CodeQL files in this folder.
In the future we plan to include only  the libraries to boost and allow for other CodeQL libraries for running the tool.
