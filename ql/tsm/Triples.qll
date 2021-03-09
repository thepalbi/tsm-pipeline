/**
 * An implementation of triples in propagation graphs with additional filtering.
 */

import javascript
import PropagationGraphs
private import semmle.javascript.dataflow.internal.StepSummary

predicate repGenerator = candidateRep/3;

int maxReprPerSink() { result = 5 }

module PropagationGraph {
  import CanonicalReps

  string candidateRep(DataFlow::Node nd, boolean asRhs) { result = candidateRep(nd, _, asRhs) }

  external predicate knownSource(string nd, string url, string q, string rep);

  external predicate knownSink(string nd, string url, string q, string rep);

  external predicate knownSanitizer(string nd, string url, string q, string rep);

  string buildURL(DataFlow::Node nd) {
    result =
      "file://" + nd.getFile().getAbsolutePath() + ":" + nd.getStartLine() + ":" +
        nd.getStartColumn() + ":" + nd.getEndLine() + ":" + nd.getEndColumn()
  }

  /**
   * Holds if `source` is one node with the same url as the precomputed known sources
   */
  predicate isKnownSource(DataFlow::Node source) {
    exists(string url |
      knownSource(_, url, _, _) and
      url = buildURL(source)
    )
  }

  /**
   * Holds if `sink` is one node with the same url as the precomputed known sinks
   */
  predicate isKnownSink(DataFlow::Node sink) {
    exists(string url |
      knownSink(_, url, _, _) and
      url = buildURL(sink)
    )
  }

  /**
   * Holds if `sanitizer` is one node with the same url as the precomputed known sanitizers
   */
  predicate isKnownSanitizer(DataFlow::Node sanitizer) {
    exists(string url |
      knownSanitizer(_, url, _, _) and
      url = buildURL(sanitizer)
    )
  }

  /**
   * A query-specific filter that a triple of candidate sources, sinks, and sanitizers must satisfy.
   *
   * Subclasses of this class are defined in `ql/tsm/<query>/PropagationGraph-<query>.ql`.
   */
  abstract class NodeFilter extends string {
    bindingset[this]
    NodeFilter() { any() }

    /** Holds if this filters accepts `src` as a candidate source. */
    predicate filterSource(DataFlow::Node src) { any() }

    /** Holds if this filter accepts `san` as a candidate sanitizer. */
    predicate filterSanitizer(DataFlow::Node san) { any() }

    /** Holds if this filter accepts `snk` as a candidate sink. */
    predicate filterSink(DataFlow::Node snk) { any() }
  }

  /** Holds if `(src, san, snk)` would be an acceptable triple according to some `NodeFilter`. */
  pragma[inline]
  predicate applyFilter(DataFlow::Node src, DataFlow::Node san, DataFlow::Node snk) {
    exists(NodeFilter f |
      f.filterSource(src) and
      f.filterSanitizer(san) and
      f.filterSink(snk)
    )
  }

  /**
   * Gets a node that is reachable from a source candidate in the propagation graph.
   */
  DataFlow::Node reachableFromSourceCandidate(DataFlow::Node src, DataFlow::TypeTracker t) {
    isSourceCandidate(result) and
    src = result and
    t.start()
    or
    step(reachableFromSourceCandidate(src, t), result)
    or
    exists(DataFlow::TypeTracker t2 |
      t = t2.smallstep(reachableFromSourceCandidate(src, t2), result)
    )
  }

  /**
   * Gets a node that is reachable from a source candidate through a sanitiser candidate
   * in the propagation graph.
   */
  DataFlow::Node reachableFromSanitizerCandidate(DataFlow::Node san, DataFlow::TypeTracker t) {
    isSanitizerCandidate(san) and
    exists(DataFlow::Node src |
      san = reachableFromSourceCandidate(src, DataFlow::TypeTracker::end()) and
      src != san
    ) and
    result = san and
    t.start()
    or
    step(reachableFromSanitizerCandidate(san, t), result)
    or
    exists(StepSummary summary | t = aux(san, result, summary).append(summary))
  }

  pragma[noinline]
  private DataFlow::TypeTracker aux(DataFlow::Node san, DataFlow::Node res, StepSummary summary) {
    StepSummary::smallstep(reachableFromSanitizerCandidate(san, result), res, summary)
  }

  /**
   * Holds if there is a path from `src` through `san` to `snk` in the propagation graph,
   * which are source, sanitiser, and sink candidate, respectively.
   */
  predicate triple(DataFlow::Node src, DataFlow::Node san, DataFlow::Node snk) {
    san = reachableFromSourceCandidate(src, DataFlow::TypeTracker::end()) and
    src != san and
    snk = reachableFromSanitizerCandidate(san, DataFlow::TypeTracker::end()) and
    isSinkCandidate(snk)
  }

  /**
   * Holds if there is a triple `(ssrc, ssan, ssnk)` that is acceptable according to some
   * `NodeFilter`.
   */
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

  /**
   * Holds if there is a triple `(ssrc, ssan, ssnk)` that is acceptable according to some.
   * `NodeFilter`.
   */
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

  /**
   * Gets all the best representations for `n` that occur more than `minOccurrences()`,
   * concatenated with `::`.
   */
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
