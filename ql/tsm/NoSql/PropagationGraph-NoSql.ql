/**
 * @kind graph
 * @id javascript/propagation-graph
 */

import javascript
import tsm.PropagationGraphsAlt

predicate targetLibraries = packageListFromFrecuency/0;

private string npmLibraries() {
  result in ["mongodb", "mongoose", "lokijs", "nosql", "nano", "rethinkdb", "loopback",
  "memcached", "cassandra-driver", "couchbase", "mongoskin", "dynamoose", "arangojs", 
  "mockgoose", "dynamodb", "aerospike", "rxdb"]
}

private string packageListFromFrecuency() {
  result in ["mongoose","express","path","fs","jquery","lodash","util","process","chai",
  "crypto","react-dom","http","mongodb","react","html-webpack-plugin","validator",
  "events","moment"]
}

private string allLibraries() {
  exists(API::Node imp | 
      imp = API::moduleImport(result)
  )
}

private string targetLibraryWorse() {
  result in ["mongodb", "mongoose"]
}
class AllPackagesAreInteresting extends InterestingPackageForSources {
   AllPackagesAreInteresting() { exists(API::moduleImport(this)) }
} 
class NoSqlIsInteresting extends InterestingPackageForSinks {
  NoSqlIsInteresting() { this = targetLibraries() }
}

// No adding extra sources to the propagation graph
class NoSqlSourceCandidate extends AdditionalSourceCandidate {
  NoSqlSourceCandidate() { none() }
}

// No adding sinks to the propagation graph
class NoSqlSinkCandidate extends AdditionalSinkCandidate {
  NoSqlSinkCandidate() { none() }
}

predicate isKnownSource = PropagationGraph::isKnownSource/1;

predicate isKnownSink = PropagationGraph::isKnownSink/1;

predicate isKnownSanitizer = PropagationGraph::isKnownSanitizer/1;

class FilterWorse extends PropagationGraph::NodeFilter {
  FilterWorse() { this = "SrcWorse" } 
  // We consider triples starting from known sources only
  override predicate filterSource(DataFlow::Node src) { isKnownSource(src) }
  // Important: NoSql V0 and VWorse consider as sinks the object used as argument to NoSql functions
  // and not the properties within the object. Considering that as sink lead to find actual issues
  // but they are considered as false positive because VWorse/V0 do not contain them.
  override predicate filterSink(DataFlow::Node snk) { 
    exists (DataFlow::InvokeNode invk |
      (snk = invk.getAnArgument() or snk = invk.(DataFlow::MethodCallNode).getReceiver())
    )
  }
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