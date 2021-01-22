/**
 * Provides a taint tracking configuration for reasoning about Seldon's paper example 
 *
 */

import javascript
import semmle.javascript.security.dataflow.DomBasedXssCustomizations
import semmle.javascript.security.TaintedObject

private float minScore_snk() { result = 0.001}
private float minScore_src() { result = 1.1}
// Score>1 to ignore sanitizers
private float minScore_san() { result = 1.1}

module TSMConfig {
  import tsm.tsm

  /**
   * A taint-tracking configuration for reasoning about SQL injection vulnerabilities.
   */
  class Configuration extends TaintTracking::Configuration {
    Configuration() { this = "TSMConfig" }

    override predicate isSource(DataFlow::Node source, DataFlow::FlowLabel label) {
      exists (float score |  TSM::isSource(source, score) and score>=minScore_src()) 
      or super.isSource(source, label)
    }
  
    override predicate isSink(DataFlow::Node sink, DataFlow::FlowLabel label) {
      exists (float score | TSM::isSink(sink, score) and score>=minScore_snk())
      or 
      super.isSink(sink, label)
    }


    override predicate isSanitizer(DataFlow::Node node) {
      exists (float score | TSM::isSanitizer(node, score) and score>=minScore_san()) 
      or
      node instanceof DomBasedXss::Sanitizer
      or
      exists(PropAccess pacc | pacc = node.asExpr() |
        isSafeLocationProperty(pacc)
        or
        // `$(location.hash)` is a fairly common and safe idiom
        // (because `location.hash` always starts with `#`),
        // so we mark `hash` as safe for the purposes of this query
        pacc.getPropertyName() = "hash"
      )
    }
    
    // override predicate isSanitizer(DataFlow::Node node) {
    //   exists (float score | TSM::isSanitizer(node, score) and score>=minScore_san()) 
    //   or
    //   node instanceof DomBasedXss::Sanitizer
    // }

    override predicate isSanitizerGuard(TaintTracking::SanitizerGuardNode guard) {
      guard instanceof TaintedObject::SanitizerGuard
    }
  
    override predicate isAdditionalFlowStep(
      DataFlow::Node src, DataFlow::Node trg, DataFlow::FlowLabel inlbl, DataFlow::FlowLabel outlbl
    ) {
      TaintedObject::step(src, trg, inlbl, outlbl)
      or
      // additional flow step to track taint through NoSQL query objects
      inlbl = TaintedObject::label() and
      outlbl = TaintedObject::label() and
      exists(NoSQL::Query query, DataFlow::SourceNode queryObj |
        queryObj.flowsToExpr(query) and
        queryObj.flowsTo(trg) and
        src = queryObj.getAPropertyWrite().getRhs()
      )
    }

  }
}