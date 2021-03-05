/**
 * @kind graph
 * @id javascript/propagation-graph
 */

import javascript
import tsm.Triples

predicate targetLibraries = packageListFromFrequency/0;

private string npmLibraries() {
  result in ["mongodb", "mongoose", "lokijs", "nosql", "nano", "rethinkdb", "loopback", "memcached",
        "cassandra-driver", "couchbase", "mongoskin", "dynamoose", "arangojs", "mockgoose",
        "dynamodb", "aerospike", "rxdb"]
}

private string packageListFromFrequency() {
  result in ["mongoose", "express", "path", "fs", "jquery", "lodash", "util", "process", "chai",
        "crypto", "react-dom", "http", "mongodb", "react", "html-webpack-plugin", "validator",
        "events", "moment"]
}

private string allLibraries() { exists(API::Node imp | imp = API::moduleImport(result)) }

private string targetLibraryWorse() { result in ["mongodb", "mongoose"] }

class AllPackagesAreInteresting extends InterestingPackageForSources {
  AllPackagesAreInteresting() { exists(API::moduleImport(this)) }
}

class NoSqlIsInteresting extends InterestingPackageForSinks {
  NoSqlIsInteresting() { this = targetLibraries() }
}

class NoSqlNodeFilter extends PropagationGraph::NodeFilter {
  NoSqlNodeFilter() { this = "NoSqlNodeFilter" }

  // We consider triples starting from known sources only
  override predicate filterSource(DataFlow::Node src) { PropagationGraph::isKnownSource(src) }

  // Important: NoSql V0 and VWorse consider as sinks the object used as argument to NoSql functions
  // and not the properties within the object. Considering that as sink lead to find actual issues
  // but they are considered as false positive because VWorse/V0 do not contain them.
  override predicate filterSink(DataFlow::Node snk) {
    exists(DataFlow::InvokeNode invk |
      (snk = invk.getAnArgument() or snk = invk.(DataFlow::MethodCallNode).getReceiver())
    )
  }
}

query predicate pairSanSnk = PropagationGraph::pairSanSnk/2;

query predicate pairSrcSan = PropagationGraph::pairSrcSan/2;

query predicate eventToConcatRep(DataFlow::Node n, string repr) {
  repr = PropagationGraph::getconcatrep(n, _)
}
