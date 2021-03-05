/**
 * @kind graph
 * @id javascript/propagation-graph
 */

import javascript
import tsm.Triples

class XssSourceCandidate extends AdditionalSourceCandidate {
  XssSourceCandidate() { PropagationGraph::isKnownSource(this) }
}

predicate targetLibraries = packageListFromFrequency/0;

private string npmLibraries() {
  result = "jquery" or
  result = "angular" or
  result = "XRegExp" or
  result = "fs"
}

private string packageListFromFrequency() {
  result in [
      "fs", "path", "process", "jquery", "express", "angular", "http", "gulp", "crypto",
      "socket.io", "child_process", "react-dom", "body-parser", "util", "react", "moment", "lodash",
      "laravel-mix", "gulp-rename", "axios", "shelljs", "url", "https", "glob", "webpack"
    ]
}

private string allLibraries() { exists(API::Node imp | imp = API::moduleImport(result)) }

class AllPackagesAreInteresting extends InterestingPackageForSources {
  AllPackagesAreInteresting() { exists(API::moduleImport(this)) }
}

class XssIsInteresting extends InterestingPackageForSinks {
  XssIsInteresting() { this = targetLibraries() }
}

class XssNodeFilter extends PropagationGraph::NodeFilter {
  XssNodeFilter() { this = "XssNodeFilter" }
}

query predicate pairSanSnk = PropagationGraph::pairSanSnk/2;

query predicate pairSrcSan = PropagationGraph::pairSrcSan/2;

query predicate eventToConcatRep(DataFlow::Node n, string repr) {
  repr = PropagationGraph::getconcatrep(n, _)
}
