// Rename NosqlInjection as NosqlInjectionWorse, assuming NosqlInjection comes from a worse
// version of the CodeQL libraries
private import semmle.javascript.security.dataflow.NosqlInjectionCustomizations::NosqlInjection as NosqlInjectionWorse
private import tsm.TaintSpecificationMining

module NosqlInjectionWorseTSM {
  import tsm.nosql.NosqlInjectionWorseTSMRepresentations

  class KnownSource extends TSM::KnownSource {
    KnownSource() { this instanceof NosqlInjectionWorse::Source }
  }

  class KnownSink extends TSM::KnownSink {
    KnownSink() { this instanceof NosqlInjectionWorse::Sink }
  }

  class KnownSanitizer extends TSM::KnownSanitizer {
    KnownSanitizer() { this instanceof NosqlInjectionWorse::Sanitizer }
  }

  class NosqlInjectionWorseRepresentations extends TSM::Representations {
    NosqlInjectionWorseRepresentations() { this = "NosqlInjectionWorseRepresentations" }


    predicate excludedSinkRepr(string repr){
      none()
    }

    override float getReprScore(string repr, string t){
         result = getRawScore(repr, t) 
         and
         ( t = "snk" and not excludedSinkRepr(repr) or 
         t != "snk")
    }

    /**
     * The list of TSM representations for NoSQL injection along with their scores.
     * These representations were generated from a TSM model trained using training data from the
     * worse NoSQL injection query, to enable
     * [recovery-style evaluation](https://github.com/github/ml-ql-adaptive-threat-modeling/tree/main/docs/evaluation).
     */
    float getRawScore(string repr, string t) {
      result = TsmRepr::getReprScore(repr, t)
    }

  }
}
