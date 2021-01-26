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

  /** A source or a sink. */
  abstract private class ScoredNode extends DataFlow::Node {
    string reprType;

    ScoredNode() { exists(any(Representations reprs).getReprScore(TSM::getRepr(this), reprType)) }

    abstract float getScore();

    float getScoreRHS() {
      result = max(any(Representations reprs).getReprScore(TSM::getRepr(this, true), reprType))
    }

    float getScoreLHS() {
      result = max(any(Representations reprs).getReprScore(TSM::getRepr(this, false), reprType))
    }
  }

  /** A predicted source. */
  class PredictedSource extends ScoredNode {
    PredictedSource() { reprType = "src" }

    override float getScore() { result = getScoreLHS() }
  }

  /** A predicted sanitizer. */
  class PredictedSanitizer extends ScoredNode {
    PredictedSanitizer() { reprType = "san" }

    override float getScore() { result = getScoreLHS() }
  }

  /** A predicted sink. */
  class PredictedSink extends ScoredNode {
    PredictedSink() { reprType = "snk" }

    override float getScore() { result = getScoreRHS() }
  }

  /** A known source, i.e. one from the non-boosted security query. */
  abstract class KnownSource extends DataFlow::Node { }

  /** A known sink, i.e. one from the non-boosted security query. */
  abstract class KnownSink extends DataFlow::Node { }

  /** A known sanitizer, i.e. one from the non-boosted security query. */
  abstract class KnownSanitizer extends DataFlow::Node { }

  /** A candidate source, i.e. a known source or a predicted source. */
  class CandidateSource extends DataFlow::Node {
    CandidateSource() {
      this instanceof KnownSource
      or
      this instanceof PredictedSource and
      this.(PredictedSource).getScore() >= minScore_src()
    }
  }

  /** A candidate sink, i.e. a known sink or a predicted sink. */
  class CandidateSink extends DataFlow::Node {
    CandidateSink() {
      this instanceof KnownSink
      or
      this instanceof PredictedSink and this.(PredictedSink).getScore() >= minScore_snk()
    }
  }

  /** A candidate sink, i.e. a known sink or a predicted sink. */
  class CandidateSanitizer extends DataFlow::Node {
    CandidateSanitizer() {
      this instanceof KnownSanitizer
      or
      this instanceof PredictedSanitizer and this.(PredictedSanitizer).getScore() >= minScore_san()
    }
  }

  /** Get the TSM representation for the node, if one exists. */
  string getRepr(DataFlow::Node node) { result = getRepr(node, _) }

  /**
   * Returns a possible representation for a node.
   * For a `canonical` representation replace for `chooseBestRep`
   */
  string getRepr(DataFlow::Node node, boolean asRhs) { result = candidateRep(node, _, asRhs) }

  private float getScoreForSource(CandidateSource source) {
    if source instanceof PredictedSource
    then result = source.(PredictedSource).getScore()
    else result = 1.0
  }

  private float getScoreForSink(CandidateSink sink) {
    if sink instanceof PredictedSink then result = sink.(PredictedSink).getScore() else result = 1.0
  }

  float getScoreForFlow(CandidateSource source, CandidateSink sink) {
    result = getScoreForSource(source) * getScoreForSink(sink)
  }

  /**
   * Pad a score returned from `getScoreForFlow` to a particular length by adding a decimal point
   * if one does not already exist, and "0"s after that decimal point.
   *
   * Note that this predicate must itself define an upper bound on `length`, so that it has a
   * finite number of results. Currently this is defined as 12.
   */
  private string paddedScore(float score, int length) {
    // In this definition, we must restrict the values that `length` and `score` can take on so that the
    // predicate has a finite number of results.
    score = getScoreForFlow(_, _) and
    length = result.length() and
    (
      // We need to make sure the padded score contains a "." so lexically sorting the padded scores is
      // equivalent to numerically sorting the scores.
      score.toString().charAt(_) = "." and
      result = score.toString()
      or
      not score.toString().charAt(_) = "." and
      result = score.toString() + "."
    )
    or
    result = paddedScore(score, length - 1) + "0" and
    length <= 12
  }

  string getScoreStringForFlow(DataFlow::Node source, DataFlow::Node sink) {
    exists(float score |
      score = getScoreForFlow(source, sink) and
      (
        // A length of 12 is equivalent to 10 decimal places.
        score.toString().length() >= 12 and
        result = score.toString().substring(0, 12)
        or
        score.toString().length() < 12 and
        result = paddedScore(score, 12)
      )
    )
  }

  /**
   * Indicates whether the flow from source to sink is likely to be reported by the base security
   * query.
   *
   * Currently this is a heuristic: it ignores potential differences in the definitions of
   * additional flow steps.
   */
  predicate isFlowLikelyInBaseQuery(CandidateSource source, CandidateSink sink) {
    source instanceof KnownSource and sink instanceof KnownSink
  }
}
