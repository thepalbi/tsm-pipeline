/**
 * @kind graph
 * @id javascript/propagation-graph
 */

import javascript
import tsm.PropagationGraphsAlt

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
  or result = "express"
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

class AllPackagesAreInteresting extends InterestingPackageForSources { // , InterestingPackageForSinks {
  AllPackagesAreInteresting() { exists(API::moduleImport(this)) }
} 

class PathIsInteresting extends InterestingPackageForSinks {
  PathIsInteresting() { this = targetLibraries() }
}

// Known sources should be included in the triples
class PathSourceCandidate extends AdditionalSourceCandidate {
  PathSourceCandidate() { isSourceWorse(this) }
}

// Known sanitizers should be included in the triples
class PathSanitizerCandidate extends AdditionalSanitizerCandidate {
  PathSanitizerCandidate() { isSanitizerWorse(this) }
}

// No adding sinks to the propagation graph
class PathSinkCandidate extends AdditionalSinkCandidate {
  PathSinkCandidate() { none() }
}

predicate isSourceWorse = PropagationGraph::isSourceWorse/1;

predicate isSinkWorse = PropagationGraph::isSinkWorse/1;

predicate isSanitizerWorse = PropagationGraph::isSanitizerWorse/1;


class FilterWorse extends PropagationGraph::NodeFilter {
  FilterWorse() { this = "SrcWorse" } 
  // We consider triples starting from known sources only
  override predicate filterSource(DataFlow::Node src) { isSourceWorse(src)}
  override predicate filterSink(DataFlow::Node snk) { any() }
  override predicate filterSanitizer(DataFlow::Node san) { any() }
}

query predicate pairSanSnk=PropagationGraph::pairSanSnk/2;
query predicate pairSrcSan=PropagationGraph::pairSrcSan/2;


query predicate eventToConcatRep(DataFlow::Node n, string repr){
  repr = PropagationGraph::getconcatrep(n, _)
}

predicate test(DataFlow::Node n, string ssrc, string ssan, string ssnk)
{
  exists(
    DataFlow::Node src, DataFlow::Node san, 
    DataFlow::Node snk
    |
    PropagationGraph::tripleSrcSanSnk(src, san, snk) and 
    ssrc = PropagationGraph::getconcatrep(src, false) and
    ssan = PropagationGraph::getconcatrep(san, false) and 
    ssnk = PropagationGraph::getconcatrep(snk, true) and 
    // repr = PropagationGraph::getconcatrep(snk, true) and
    ssnk.indexOf("parameter 0 (member sendFile")>0
    and n = snk
  )
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
