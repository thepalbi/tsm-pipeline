// Rename SqlInjection as SqlInjectionWorse, assuming SqlInjection comes from a worse version of
// the CodeQL libraries
private import semmle.javascript.security.dataflow.SqlInjection::SqlInjection as SqlInjectionWorse
private import tsm.TaintSpecificationMining

module SqlInjectionWorseTSM {
  import tsm.sql.SqlInjectionWorseRepresentations

  class KnownSource extends TSM::KnownSource {
    KnownSource() { this instanceof SqlInjectionWorse::Source }
  }

  class KnownSink extends TSM::KnownSink {
    KnownSink() { this instanceof SqlInjectionWorse::Sink }
  }

  class KnownSanitizer extends TSM::KnownSanitizer {
    KnownSanitizer() { this instanceof SqlInjectionWorse::Sanitizer }
  }

  class SqlInjectionWorseRepresentations extends TSM::Representations {
    SqlInjectionWorseRepresentations() { this = "SqlInjectionWorseRepresentations" }


    predicate excludedSinkRepr(string repr){
      none()
    }

    override float getReprScore(string repr, string t){
         result = getRawScore(repr, t) 
         and
         (t = "snk" and not excludedSinkRepr(repr) or 
         t != "snk")
    }

    /**
     * The list of TSM representations for SQL injection along with their scores.
     * These representations were generated from a TSM model trained using training data from SQL
     * injection using and older version of the codeql library (`d8388d3f75941635d089b9ecda9953a41e6f9b09`),
     *  to enable [recovery-style evaluation](https://github.com/github/ml-ql-adaptive-threat-modeling/tree/main/docs/evaluation).
     */
    float getRawScore(string repr, string t) {
      result = TsmRepr::getReprScore(repr, t)
    }
  }
}
