private import javascript
private import NodeRepresentation

private float minScore_snk() { result = 0.1 }

private float minScore_src() { result = 100 }

// Score>1 to ignore sanitizers
private float minScore_san() { result = 100 }

module TSM {
  abstract class Representations extends string {
    bindingset[this]
    Representations() { any() }

    /** The offline TSM representations for a security query, along with their scores. */
    abstract float getReprScore(string repr, string reprType);
  }

  /**
   * Returns a possible representation for a node.
   * For a `canonical` representation replace for `chooseBestRep`
   */
  string getRepr(DataFlow::Node node, boolean asRhs) { result = candidateRep(node, _, asRhs) }

  /**
   * Returns a possible representation for a node in order of detail.
   * For a `canonical` representation replace for `chooseBestRep`
   */
  string getRepr(DataFlow::Node node, boolean asRhs, int i) {
    result = chooseBestReps(node, asRhs, i)
  }

  /**
   * Gets a possible score for node `nd`, considered as a source, sanitizer, or sink, depending
   * on `reprType`.
   */
  float getAReprScore(DataFlow::Node nd, string reprType) {
    result = max(int i, float score | score = getAReprScore(nd, reprType, i, _) | score)
  }

  /**
   * Gets a possible score for node `nd`, considered as a source, sanitizer, or sink, depending
   * on `reprType`.
   */
  float getAReprScore(DataFlow::Node nd, string reprType, int i, string rep) {
    exists(Representations repr, boolean asRhs |
      reprType in ["src", "san"] and asRhs = false
      or
      reprType = "snk" and asRhs = true
    |
      exists(float score |
        rep = getRepr(nd, asRhs, i) and
        score = repr.getReprScore(rep, reprType) and
        result = score * 0.5.pow(i - 1)
      )
    )
  }

  /**
   * Gets the maximum score for node `nd`, considered as a source, sanitizer, or sink, depending
   * on `reprType`.
   */
  float getScore(DataFlow::Node nd, string reprType) { result = max(getAReprScore(nd, reprType)) }

  /** A known source, i.e. one from the non-boosted security query. */
  abstract class KnownSource extends DataFlow::Node { }

  /** A known sink, i.e. one from the non-boosted security query. */
  abstract class KnownSink extends DataFlow::Node { }

  /** A known sanitizer, i.e. one from the non-boosted security query. */
  abstract class KnownSanitizer extends DataFlow::Node { }

  /** A candidate source, i.e. a known source or a predicted source. */
  class CandidateSource extends DataFlow::Node {
    float score;

    CandidateSource() {
      this instanceof KnownSource and
      score = 1.0
      or
      score = getScore(this, "src") and
      score >= minScore_src()
    }

    float getScore() { result = score }
  }

  /** A candidate sink, i.e. a known sink or a predicted sink. */
  class CandidateSink extends DataFlow::Node {
    float score;

    CandidateSink() {
      this instanceof KnownSink and
      score = 1.0
      or
      score = getScore(this, "snk") and
      score >= minScore_snk()
    }

    float getScore() { result = score }
  }

  /** A candidate sink, i.e. a known sink or a predicted sink. */
  class CandidateSanitizer extends DataFlow::Node {
    float score;

    CandidateSanitizer() {
      this instanceof KnownSanitizer and
      score = 1.0
      or
      score = getScore(this, "san") and
      score >= minScore_san()
    }

    float getScore() { result = score }
  }

  pragma[inline]
  float getScoreForFlow(CandidateSource source, CandidateSink sink) {
    result = source.getScore() * sink.getScore()
  }

  /**
   * Indicates whether the flow from source to sink is likely to be reported by the base security
   * query.
   *
   * Currently this is a heuristic: it ignores potential differences in the definitions of
   * additional flow steps.
   */
  pragma[inline]
  predicate isFlowLikelyInBaseQuery(CandidateSource source, CandidateSink sink) {
    source instanceof KnownSource and sink instanceof KnownSink
  }
}
