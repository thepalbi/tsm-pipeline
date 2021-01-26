// Renames DomBasedXss as DomBasedXssWorse, assuming DomBasedXss comes from a configWorse
// private import evaluation.DomBasedXssCustomizationsWorse::DomBasedXssWorse as DomBasedXssWorse
private import semmle.javascript.security.dataflow.DomBasedXss::DomBasedXss as DomBasedXssWorse
private import tsm.TaintSpecificationMining

module DomBasedXssWorseTSM {
  import tsm.xss.DomBasedXssWorseRepresentations

  class KnownSource extends TSM::KnownSource {
    KnownSource() { this instanceof DomBasedXssWorse::Source }
  }

  class KnownSink extends TSM::KnownSink {
    KnownSink() { this instanceof DomBasedXssWorse::Sink }
  }

  class KnownSanitizer extends TSM::KnownSanitizer {
    KnownSanitizer() {
      this instanceof DomBasedXssWorse::Sanitizer
      or
      this instanceof DomBasedXssWorse::SanitizerGuard
    }
  }

  class DomBasedXssWorseRepresentations extends TSM::Representations {
    DomBasedXssWorseRepresentations() { this = "DomBasedXssWorseRepresentations" }

    predicate excludedSinkRepr(string repr) {
      // Top 4-6 with combined scores
      repr in [
          "(parameter 0 (return (member test *)))", "(parameter 0 (return (member parse *)))",
          "(parameter 1 (return (member attr *)))", "(parameter 0 (return (member indexOf *)))"
          // This reprs has many less ocurrences than the previous ones
          //"(member innerHTML (return (member id (parameter 1 (return extend)))))",
          //"(parameter 0 (return (member jQuery (global))))"
        ]
    }

    override float getReprScore(string repr, string t) {
      result = getRawScore(repr, t) and
      (
        t = "snk" and not excludedSinkRepr(repr)
        or
        t != "snk"
      )
    }

    /**
     * The list of TSM representations for DomBasedXss along with their scores.
     * These representations were generated from a TSM model trained using training data from DomBasedXss
     * injection using and older version of the codeql library (`d8388d3f75941635d089b9ecda9953a41e6f9b09`),
     *  to enable [recovery-style evaluation](https://github.com/github/ml-ql-adaptive-threat-modeling/tree/main/docs/evaluation).
     */
    float getRawScore(string repr, string t) { result = TsmRepr::getReprScore(repr, t) }
  }
}
