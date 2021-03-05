/**
 * @kind graph
 * @id javascript/propagation-graph
 */

import javascript
import tsm.Triples

predicate targetLibraries = packageListFromFrequency/0;

private string npmLibraries() {
  result = "fs" or
  result = "fs-extra" or
  result = "fstream" or
  result = "file-system" or
  result = "file-system-cache" or
  result = "shell-js" or
  result = "http" or
  result = "https" or
  result = "glob" or
  result = "util" or
  result = "fs-jetpack" or
  result = "mv" or
  result = "path" or
  result = "path-exists" or
  result = "vinyl-fs" or
  result = "sane" or
  result = "express"
}

private string packageListFromFrequency() {
  result in ["fs", "path", "http", "process", "express", "url", "child_process", "util", "assert",
        "socket.io", "crypto", "gulp", "request", "jquery", "async", "moment", "supertest",
        "lodash", "mongoose", "chalk", "nunjucks", "fs-extra", "events"]
}

class AllPackagesAreInteresting extends InterestingPackageForSources {
  AllPackagesAreInteresting() { exists(API::moduleImport(this)) }
}

class PathIsInteresting extends InterestingPackageForSinks {
  PathIsInteresting() { this = targetLibraries() }
}

// Known sources should be included in the triples
class PathSourceCandidate extends AdditionalSourceCandidate {
  PathSourceCandidate() { PropagationGraph::isKnownSource(this) }
}

// Known sanitizers should be included in the triples
class PathSanitizerCandidate extends AdditionalSanitizerCandidate {
  PathSanitizerCandidate() { PropagationGraph::isKnownSanitizer(this) }
}

class TaintedPathNodeFilter extends PropagationGraph::NodeFilter {
  TaintedPathNodeFilter() { this = "TaintedPathNodeFilter" }

  // We consider triples starting from known sources only
  override predicate filterSource(DataFlow::Node src) { PropagationGraph::isKnownSource(src) }
}

query predicate pairSanSnk = PropagationGraph::pairSanSnk/2;

query predicate pairSrcSan = PropagationGraph::pairSrcSan/2;

query predicate eventToConcatRep(DataFlow::Node n, string repr) {
  repr = PropagationGraph::getconcatrep(n, _)
}
