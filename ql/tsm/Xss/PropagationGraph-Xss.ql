/**
 * @kind graph
 * @id javascript/propagation-graph
 */

import javascript
import tsm.PropagationGraphsAlt

class XssSourceCandidate extends AdditionalSourceCandidate {
  XssSourceCandidate() { isKnownSource(this) }
}
class XssSinkCandidate extends AdditionalSinkCandidate {
  XssSinkCandidate() { none() }
}


predicate targetLibraries = packageListFromFrecuency/0;

private string npmLibraries() {
  result = "jquery"
  or result = "angular"
  or result = "XRegExp"
  or result = "fs"
}

private string packageListFromFrecuency() {
  result in [
    "fs","path","process","jquery","express", "angular",
    "http","gulp","crypto","socket.io","child_process",
    "react-dom","body-parser","util","react","moment",
    "lodash","laravel-mix","gulp-rename",
    "axios","shelljs","url","https","glob","webpack"
  ]
}


private string allLibraries() {
  exists(API::Node imp |
      imp = API::moduleImport(result)
  )
}

class AllPackagesAreInteresting extends InterestingPackageForSources {
  AllPackagesAreInteresting() { exists(API::moduleImport(this)) }
}

class XssIsInteresting extends InterestingPackageForSinks {
  XssIsInteresting() { this = targetLibraries() }
}

predicate isKnownSource = PropagationGraph::isKnownSource/1;

predicate isKnownSink = PropagationGraph::isKnownSink/1;

predicate isKnownSanitizer = PropagationGraph::isKnownSanitizer/1;

class FilterWorse extends PropagationGraph::NodeFilter {
  FilterWorse() { this = "SrcWorse" }
  override predicate filterSource(DataFlow::Node src) { any() }
  override predicate filterSink(DataFlow::Node snk) { any() }
  override predicate filterSanitizer(DataFlow::Node san) { any() }
}

query predicate pairSanSnk=PropagationGraph::pairSanSnk/2;
query predicate pairSrcSan=PropagationGraph::pairSrcSan/2;

query predicate eventToConcatRep(DataFlow::Node n, string repr){
  repr = PropagationGraph::getconcatrep(n, _)
}
