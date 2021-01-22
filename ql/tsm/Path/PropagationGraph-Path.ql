/**
 * @kind graph
 * @id javascript/propagation-graph
 */

import javascript
import tsm.PropagationGraphsAlt
// In this version we use older verisions of standard libraries as Worse versions 
import semmle.javascript.security.dataflow.TaintedPathCustomizations as TaintedPathCustomizationsWorse

module TaintedPathWorse=TaintedPathCustomizationsWorse::TaintedPath;

predicate targetLibraries = npmLibraries/0;

private string npmLibraries() { 
  result = "fs" 
  or result = "fs-extra"
  or result = "fstream"
  or result = "file-system"
  or result = "file-system-cache"
  or result = "shell-js"
  or result = "http"
  or result = "https"
  or result = "glob"
  or result = "util"
  or result = "fs-jetpack"
  or result = "mv"
  or result = "path"
  or result = "path-exists"
  or result = "vinyl-fs"
  or result = "sane"
  // exists(API::Node imp | 
  //     imp = API::moduleImport(result)
  // )
}

private string packageListFromFrecuency() {
  result in [
    "fs","path","http","process","express","url","child_process","util","assert",
    "socket.io","crypto","gulp","request","jquery","async","moment","supertest",
    "lodash","mongoose","chalk","nunjucks","fs-extra","events"
  ]
} 

class AllPackagesAreInteresting extends InterestingPackageForSources,InterestingPackageForSinks {
  AllPackagesAreInteresting() { exists(API::moduleImport(this)) }
} 

// class PathIsInteresting extends InterestingPackageForSinks {
//   PathIsInteresting() { this = packageListFromFrecuency() }
// }

class PathSourceCandidate extends AdditionalSourceCandidate {
  PathSourceCandidate() { none() }
}

// No adding sinks to the propagation graph
class PathSinkCandidate extends AdditionalSinkCandidate {
  PathSinkCandidate() { none() }
}

predicate isSanitizerWorse(DataFlow::Node sanitizer) {
  sanitizer instanceof TaintedPathWorse::Sanitizer
  or sanitizer instanceof TaintedPathWorse::BarrierGuardNode
}

class FilterWorse extends PropagationGraph::NodeFilter {
  FilterWorse() { this = "SrcWorse" } 
  // We consider triples starting from known sources only
  override predicate filterSource(DataFlow::Node src) { src instanceof TaintedPathWorse::Source }
  override predicate filterSink(DataFlow::Node snk) { any() }
  override predicate filterSanitizer(DataFlow::Node san) { isSanitizerWorse(san) }
}

query predicate pairSanSnk=PropagationGraph::pairSanSnk/2;
query predicate pairSrcSan=PropagationGraph::pairSrcSan/2;


query predicate eventToConcatRep(DataFlow::Node n, string repr){
  repr = PropagationGraph::getconcatrep(n, _)
}
