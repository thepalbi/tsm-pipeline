/**
 * Provides a taint tracking configuration for reasoning about Seldon's paper example
 */

import javascript
import semmle.javascript.security.TaintedObject
import tsm.TaintSpecificationMining

module TSMConfig {
  /**
   * A taint-tracking configuration for reasoning about tainted-path vulnerabilities.
   */
  class Configuration extends TaintTracking::Configuration {
    Configuration() { this = "SqlInjectionTSMConfiguration" }

    override predicate isSource(DataFlow::Node source) { source instanceof TSM::CandidateSource }

    override predicate isSource(DataFlow::Node source, DataFlow::FlowLabel lbl) {
      source instanceof TSM::CandidateSource
    }

    override predicate isSink(DataFlow::Node sink) { sink instanceof TSM::CandidateSink }

    override predicate isSink(DataFlow::Node sink, DataFlow::FlowLabel lbl) {
      sink instanceof TSM::CandidateSink
    }

    override predicate isSanitizer(DataFlow::Node sanitizer) {
      sanitizer instanceof TSM::CandidateSanitizer
    }

    override predicate isAdditionalFlowStep(
      DataFlow::Node src, DataFlow::Node trg, DataFlow::FlowLabel inlbl, DataFlow::FlowLabel outlbl
    ) {
      super.isAdditionalFlowStep(src, trg, inlbl, outlbl)
    }
  }
}
