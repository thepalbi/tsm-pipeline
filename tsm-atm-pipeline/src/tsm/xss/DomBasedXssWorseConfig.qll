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
    Configuration() { this = "DomBasedXssWorseConfiguration" }

    override predicate isSource(DataFlow::Node source) { source instanceof TSM::KnownSource }

    override predicate isSource(DataFlow::Node source, DataFlow::FlowLabel lbl) {
      source instanceof TSM::KnownSource
    }

    override predicate isSink(DataFlow::Node sink) { sink instanceof TSM::KnownSink }

    override predicate isSink(DataFlow::Node sink, DataFlow::FlowLabel lbl) {
      sink instanceof TSM::KnownSink
    }

    override predicate isSanitizer(DataFlow::Node sanitizer) {
      super.isSanitizer(sanitizer)
      or
      sanitizer instanceof TSM::KnownSanitizer
    }

    override predicate isSanitizerGuard(TaintTracking::SanitizerGuardNode guard) {
      guard instanceof DomBasedXssWorse::SanitizerGuard
    }

    /**
     * Inspired by the isAdditionalFlowStep predicate from an old NoSqlInjection TSM/ATM query
     */
    override predicate isAdditionalFlowStep(
      DataFlow::Node src, DataFlow::Node trg, DataFlow::FlowLabel inlbl, DataFlow::FlowLabel outlbl
    ) {
      super.isAdditionalFlowStep(src, trg, inlbl, outlbl)
      or
      TaintedObject::step(src, trg, inlbl, outlbl)
    }

    /**
     * Copied from
     * https://raw.githubusercontent.com/esbena/codeql/esben/atm/js/benjamin-button-2020/javascript/ql/src/semmle/javascript/security/dataflow/DomBasedXss.qll
     */
    override predicate isAdditionalStoreStep(
      DataFlow::Node pred, DataFlow::SourceNode succ, string prop
    ) {
      exists(DataFlow::PropRead read |
        pred = read.getBase() and
        succ = read and
        read.getPropertyName() = "hash" and
        prop = urlSuffixPseudoProperty()
      )
    }

    override predicate isAdditionalLoadStoreStep(
      DataFlow::Node pred, DataFlow::Node succ, string predProp, string succProp
    ) {
      exists(DataFlow::PropRead read |
        pred = read.getBase() and
        succ = read and
        read.getPropertyName() = "hash" and
        predProp = "hash" and
        succProp = urlSuffixPseudoProperty()
      )
    }

    override predicate isAdditionalLoadStep(DataFlow::Node pred, DataFlow::Node succ, string prop) {
      exists(DataFlow::MethodCallNode call |
        call.getMethodName() = ["substr", "substring", "slice"] and
        not call.getArgument(0).getIntValue() = 0 and
        pred = call.getReceiver() and
        succ = call and
        prop = urlSuffixPseudoProperty()
      )
      or
      exists(DataFlow::MethodCallNode call |
        call.getMethodName() = "exec" and pred = call.getArgument(0)
        or
        call.getMethodName() = "match" and pred = call.getReceiver()
      |
        succ = call and
        prop = urlSuffixPseudoProperty()
      )
      or
      exists(StringSplitCall split |
        split.getSeparator() = ["#", "?"] and
        pred = split.getBaseString() and
        succ = split.getASubstringRead(1) and
        prop = urlSuffixPseudoProperty()
      )
    }

    override predicate isSanitizerEdge(DataFlow::Node pred, DataFlow::Node succ) {
      DomBasedXssWorse::isOptionallySanitizedEdge(pred, succ)
    }

    private string urlSuffixPseudoProperty() { none() }
  }
}
