/**
 * @kind graph
 * @id javascript/propagation-graph
 */

import javascript
import tsm.Triples

predicate targetLibraries = packageListFromFrecuency/0;

private string npmLibraries() {
  result in [
      "sql", "sql.js", "sqlstring", "mssql", "mysql", "sequelize", "sqlite3", "better-sqlite3",
      "knex", "postgres", "oracledb", "tedious", "pretty-data", "db-migrate"
    ]
}

private string packageListFromFrecuency() {
  result in [
      "express", "mysql", "body-parser", "process", "path", "fs", "http", "crypto",
      "express-handlebars", "url", "morgan", "multer", "util", "child_process", "jsonwebtoken",
      "method-override", "pg", "fs-extra", "socket.io", "https"
    ]
}

private string allLibraries() { exists(API::Node imp | imp = API::moduleImport(result)) }

private string targetLibraryWorse() {
  result in [
      "mysql", "pg", "sqlite3", "express", "azure-storage", "mssql", "process", "multiparty",
      "async/eachLimit", "body-parser"
    ]
}

class AllPackagesAreInteresting extends InterestingPackageForSources {
  AllPackagesAreInteresting() { exists(API::moduleImport(this)) }
}

class SqlIsInteresting extends InterestingPackageForSinks {
  SqlIsInteresting() { this = targetLibraries() }
}

class FilterWorse extends PropagationGraph::NodeFilter {
  FilterWorse() { this = "SrcWorse" }

  // We consider triples starting from known sources only
  override predicate filterSource(DataFlow::Node src) { PropagationGraph::isKnownSource(src) }
}

query predicate pairSanSnk = PropagationGraph::pairSanSnk/2;

query predicate pairSrcSan = PropagationGraph::pairSrcSan/2;

query predicate eventToConcatRep(DataFlow::Node n, string repr) {
  repr = PropagationGraph::getconcatrep(n, _)
}
