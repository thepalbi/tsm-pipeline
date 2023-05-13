private import javascript
import semmle.javascript.security.TaintedObject
private import tsm.TaintSpecificationMining
private import tsm.nosql.NosqlInjectionFlowSteps

module TSMConfig {

class Configuration extends TaintTracking::Configuration {
    Configuration() { this = "NosqlInjectionWorseConfiguration" }

  override predicate isSource(DataFlow::Node source) { source instanceof TSM::KnownSource }

  override predicate isSource(DataFlow::Node source, DataFlow::FlowLabel lbl) {
    source instanceof TSM::KnownSource and
    TaintedObject::isSource(source, lbl)
  }

  override predicate isSink(DataFlow::Node sink) { sink instanceof TSM::KnownSink }

  override predicate isSink(DataFlow::Node sink, DataFlow::FlowLabel lbl) {
    sink instanceof TSM::KnownSink
  }

  override predicate isSanitizer(DataFlow::Node sanitizer) {
    sanitizer instanceof TSM::KnownSanitizer
  }

  override predicate isSanitizerGuard(TaintTracking::SanitizerGuardNode guard) {
    guard instanceof TaintedObject::SanitizerGuard or
    guard instanceof TSM::KnownSanitizer
  }

  override predicate isAdditionalFlowStep(
    DataFlow::Node src, DataFlow::Node trg, DataFlow::FlowLabel inlbl, DataFlow::FlowLabel outlbl
  ) {
    // additional flow steps from the base (non-boosted) security query
    NosqlInjectionFlowSteps::isBaseAdditionalFlowStep(src, trg, inlbl, outlbl)
    or
    // relaxed version of base security query flow step to track taint through unmodeled NoSQL
    // query objects: works by using `Expr` instead of `NoSQL::Query`
    trg instanceof TSM::KnownSink and
    inlbl = TaintedObject::label() and
    outlbl = TaintedObject::label() and
    exists(Expr query, DataFlow::SourceNode queryObj |
      queryObj.flowsToExpr(query) and
      queryObj.flowsTo(trg) and
      src = queryObj.getAPropertyWrite().getRhs()
    )
  }
}
}
