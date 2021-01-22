/**
 * @kind graph
 */

import javascript
import tsm.PropagationGraphsAlt
// In this version we use older verisions of standard libraries as Worse versions
import semmle.javascript.security.dataflow.DomBasedXssCustomizations as DomBasedXssCustomizationsWorse

module DomBasedXssWorse = DomBasedXssCustomizationsWorse::DomBasedXss;

predicate sanitizerXssGuard(DataFlow::Node nd, string q, string repr) {
  (nd instanceof DomBasedXssWorse::SanitizerGuard and q = "DomBasedXssWorse") and
  repr = PropagationGraph::getconcatrep(nd, false)
}

query predicate sanitizerXssClasses(DataFlow::Node nd, string q, string repr) {
  (nd instanceof DomBasedXssWorse::Sanitizer and q = "DomBasedXssWorse") and
  repr = PropagationGraph::getconcatrep(nd, false)
  or
  sanitizerXssGuard(nd, q, repr)
}

query predicate sourceXssClasses(DataFlow::Node nd, string q, string repr) {
  (nd instanceof DomBasedXssWorse::Source and q = "DomBasedXssWorse") and
  repr = PropagationGraph::getconcatrep(nd, false)
}

query predicate sinkXssClasses(DataFlow::Node nd, string q, string repr) {
  (nd instanceof DomBasedXssWorse::Sink and q = "DomBasedXssWorse") and
  repr = PropagationGraph::getconcatrep(nd, true)
}
