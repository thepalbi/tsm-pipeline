/**
 * @kind graph
 */

import javascript
import tsm.CanonicalReps
// In this version we use older verisions of standard libraries as Worse versions
import semmle.javascript.security.dataflow.TaintedPathCustomizations as TaintedPathCustomizationsWorse

module TaintedPathWorse = TaintedPathCustomizationsWorse::TaintedPath;

query predicate sourcePathClasses(DataFlow::Node nd, string q, string repr) {
  (nd instanceof TaintedPathWorse::Source and q = "TaintedPathWorse") and
  repr = getconcatrep(nd, false)
}

query predicate sinkPathClasses(DataFlow::Node nd, string q, string repr) {
  (nd instanceof TaintedPathWorse::Sink and q = "TaintedPathWorse") and
  repr = getconcatrep(nd, true)
}

predicate sanitizerPathGuard(DataFlow::Node nd, string q, string repr) {
  (nd instanceof TaintedPathWorse::BarrierGuardNode and q = "TaintedPathWorse") and
  repr = getconcatrep(nd, false)
}

query predicate sanitizerPathClasses(DataFlow::Node nd, string q, string repr) {
  (
    nd instanceof TaintedPathWorse::Sanitizer and q = "TaintedPathWorse"
    or
    sanitizerPathGuard(nd, q, repr)
  ) and
  repr = getconcatrep(nd, false)
}
