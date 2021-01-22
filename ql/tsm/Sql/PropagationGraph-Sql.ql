/**
 * @kind graph
 * @id javascript/propagation-graph
 */

import javascript
import tsm.PropagationGraphsAlt
// In this version we use older verisions of standard libraries as Worse versions
import semmle.javascript.security.dataflow.SqlInjectionCustomizations as SqlInjectionCustomizationsWorse
// For backward compatiblity
module SqlInjectionWorse = SqlInjectionCustomizationsWorse::SqlInjection;

predicate targetLibraries = npmLibraries/0;

private string npmLibraries() { 
  result in ["sql", "sql.js", "sqlstring", "mssql", "mysql", 
            "sequelize", "sqlite3", "better-sqlite3", 
            "knex", "postgres", "oracledb",
            "tedious", "pretty-data", "db-migrate"] 
  
}

private string allLibraries() {
  exists(API::Node imp | 
      imp = API::moduleImport(result)
  )
}

private string targetLibraryWorse() {
  result in ["mysql",
            "pg", 
            "sqlite3", 
            "express", 
            "azure-storage", 
            "mssql", 
            "process",
            "multiparty",
            "async/eachLimit",
            "body-parser"]
}

class AllPackagesAreInteresting extends InterestingPackageForSources, InterestingPackageForSinks {
  AllPackagesAreInteresting() { exists(API::moduleImport(this)) }
} 
// class SqlIsInteresting extends InterestingPackageForSinks {
//   SqlIsInteresting() { this = targetLibraryWorse()}
// }

class SqlSourceCandidate extends AdditionalSourceCandidate {
  SqlSourceCandidate() { none() }
}

// No adding sinks to the propagation graph
class SqlSinkCandidate extends AdditionalSinkCandidate {
  SqlSinkCandidate() { none() }
}

class FilterWorse extends PropagationGraph::NodeFilter {
  FilterWorse() { this = "SrcWorse" } 
  // We consider triples starting from known sources only
  override predicate filterSource(DataFlow::Node src) { src instanceof SqlInjectionWorse::Source }
  override predicate filterSink(DataFlow::Node snk) { any() }
  override predicate filterSanitizer(DataFlow::Node san) { any() }
}

query predicate pairSanSnk=PropagationGraph::pairSanSnk/2;
query predicate pairSrcSan=PropagationGraph::pairSrcSan/2;

query predicate eventToConcatRep(DataFlow::Node n, string repr){
  repr = PropagationGraph::getconcatrep(n, _)
}

predicate tripleString(string ssrc, string ssan, string ssnk) {
  exists(DataFlow::Node src, DataFlow::Node san, DataFlow::Node snk
    |
    PropagationGraph::tripleSrcSanSnk(src, san, snk) and
    ssrc = PropagationGraph::getconcatrep(src, false) and
    ssan = PropagationGraph::getconcatrep(san, false) and 
    ssnk = PropagationGraph::getconcatrep(snk, true)    

  )
}