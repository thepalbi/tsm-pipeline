/**
 * Provides a taint tracking configuration for reasoning about Seldon's paper example
 */

import javascript
import semmle.javascript.security.TaintedObject
import tsm.TaintSpecificationMining
private import tsm.xss.Config

module TSMConfig {
  private import semmle.javascript.security.dataflow.DomBasedXss::DomBasedXss as DomBasedXssWorse

  /**
   * A taint-tracking configuration for reasoning about tainted-path vulnerabilities.
   */
  class Configuration extends EsbenaDomBasedXSSConfiguration {
    Configuration() { this = "DomBasedXssBoostedConfiguration" }

    override predicate isSource(DataFlow::Node source) { source instanceof TSM::CandidateSource }

    override predicate isSource(DataFlow::Node source, DataFlow::FlowLabel lbl) {
      source instanceof TSM::CandidateSource
    }

    override predicate isSink(DataFlow::Node sink) { sink instanceof TSM::CandidateSink }

    override predicate isSink(DataFlow::Node sink, DataFlow::FlowLabel lbl) {
      sink instanceof TSM::CandidateSink
    }

    override predicate isSanitizer(DataFlow::Node sanitizer) {
      super.isSanitizer(sanitizer)
      or
      sanitizer instanceof TSM::CandidateSanitizer
    }

    override predicate isSanitizerGuard(TaintTracking::SanitizerGuardNode guard) {
      guard instanceof DomBasedXssWorse::SanitizerGuard
    }
  }
}
