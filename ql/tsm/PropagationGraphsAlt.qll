// An alternative implementation of `PropagationGraph.ql` using inter-procedural
// data flow instead of points-to.
import javascript
import PropagationGraphs

predicate repGenerator = candidateRep/3;
int maxReprPerSink() { result = 5 }

module PropagationGraph {
  import CanonicalReps

  string candidateRep(DataFlow::Node nd,  boolean asRhs) {
    result = candidateRep(nd, _, asRhs) 
  }
  
  predicate isSourceWorse(DataFlow::Node source) 
  {
    exists(string repr |
      repr = any(KnownRepr k).getRepr("sources") and
      repr = candidateRep(source, false) 
    )
  }

  predicate isSinkWorse(DataFlow::Node sink) 
  {
    exists(string repr |
      repr = any(KnownRepr k).getRepr("sinks") and
      repr = candidateRep(sink, true) 
    )
  }

  predicate isSanitizerWorse(DataFlow::Node sanitizer) {
    // sanitizer instanceof TaintedPathWorse::Sanitizer
    // or sanitizer instanceof TaintedPathWorse::BarrierGuardNode
    exists(string repr |
      repr = any(KnownRepr k).getRepr("sanitizers") and
      repr = candidateRep(sanitizer, false) 
    )
  }
  class KnownRepr extends string {
    bindingset[this]
    KnownRepr() { any()}
    abstract string getRepr(string t);
  }
  abstract class NodeFilter extends string {
    bindingset[this]
    NodeFilter() { any() }

    predicate filterSource(DataFlow::Node src) { any() }

    predicate filterSanitizer(DataFlow::Node san) { any() }

    predicate filterSink(DataFlow::Node snk) { any() }
  }

  predicate tripleSrcSanSnk(DataFlow::Node src, DataFlow::Node san, DataFlow::Node snk) {
    triple(src, san, snk) and
    applyFilter(src, san, snk)
  }

  predicate applyFilter(DataFlow::Node src, DataFlow::Node san, DataFlow::Node snk) {
    any(NodeFilter fsrc).filterSource(src) and
    any(NodeFilter fsan).filterSanitizer(san) and
    any(NodeFilter fs).filterSink(snk)
  }

  predicate pairSanSnk(string ssan, string ssnk) {
    exists(DataFlow::Node src, DataFlow::Node san, DataFlow::Node snk |
      san = reachableFromSourceCandidate(src, DataFlow::TypeTracker::end()) and
      src.getEnclosingExpr() != san.getEnclosingExpr() and
      snk = reachableFromSanitizerCandidate(san, DataFlow::TypeTracker::end()) and
      isSinkCandidate(snk) and
      exists(getconcatrep(src, false)) and
      ssan = getconcatrep(san, false) and
      ssnk = getconcatrep(snk, true) and
      applyFilter(src, san, snk)
    )
  }

  predicate pairSrcSan(string ssrc, string ssan) {
    exists(DataFlow::Node src, DataFlow::Node san, DataFlow::Node snk |
      san = reachableFromSourceCandidate(src, DataFlow::TypeTracker::end()) and
      src.getEnclosingExpr() != san.getEnclosingExpr() and
      snk = reachableFromSanitizerCandidate(san, DataFlow::TypeTracker::end()) and
      isSinkCandidate(snk) and
      exists(getconcatrep(snk, true)) and
      ssan = getconcatrep(san, false) and
      ssrc = getconcatrep(src, false) and
      applyFilter(src, san, snk)
    )
  }

  string getconcatrep(DataFlow::Node n, boolean asRhs) {
    result =
      strictconcat(string r |
        r = chooseBestRep(n, asRhs) and
        count(DataFlow::Node nd2 | r = repGenerator(nd2, _, asRhs)) >= minOccurrences()
      |
        r, "::"
      )
  }
}
