/**
 * Provides a taint tracking configuration for reasoning about Seldon's paper example
 */

import javascript
import semmle.javascript.security.TaintedObject
import tsm.TaintSpecificationMining

module TSMConfig {
  // Renames TaintedPath as TaintedPathWorse, assuming TaintedPath comes from a configWorse
  private import semmle.javascript.security.dataflow.TaintedPath::TaintedPath as TaintedPathWorse

  /**
   * A taint-tracking configuration for reasoning about tainted-path vulnerabilities.
   */
  class Configuration extends DataFlow::Configuration {
    Configuration() { this = "TaintedPathTSMConfiguration" }

    override predicate isSource(DataFlow::Node source) { source instanceof TSM::CandidateSource }

    override predicate isSource(DataFlow::Node source, DataFlow::FlowLabel lbl) {
      source instanceof TSM::CandidateSource
    }

    override predicate isSink(DataFlow::Node sink) { sink instanceof TSM::CandidateSink }

    override predicate isSink(DataFlow::Node sink, DataFlow::FlowLabel lbl) {
      sink instanceof TSM::CandidateSink
    }

    override predicate isBarrier(DataFlow::Node node) { node instanceof TSM::CandidateSanitizer }

    override predicate isBarrierGuard(DataFlow::BarrierGuardNode guard) {
      guard instanceof TSM::CandidateSanitizer
    }

    override predicate isAdditionalFlowStep(
      DataFlow::Node src, DataFlow::Node dst, DataFlow::FlowLabel srclabel,
      DataFlow::FlowLabel dstlabel
    ) {
      TaintedPathWorse::isAdditionalTaintedPathFlowStep(src, dst, srclabel, dstlabel)
    }
  }
}
