/**
 * @kind graph
 */

import javascript
import tsm.PropagationGraphsAlt
// In this version we use older verisions of standard libraries as Worse versions 
import semmle.javascript.security.dataflow.NosqlInjectionCustomizations as NosqlInjectionCustomizationsWorse

module NosqlInjectionWorse = NosqlInjectionCustomizationsWorse::NosqlInjection;

// Note from Diego: This predicate didn't exist in the old Sanitizers.ql
// I created this predidate following the template of other sanitizers
query predicate sanitizerNoSqlClasses(DataFlow::Node nd, string q, string repr) {
  (nd instanceof NosqlInjectionWorse::Sanitizer and q = "NosqlInjectionWorse") and
  repr = PropagationGraph::getconcatrep(nd, false)
}

query predicate sourceNoSqlClasses(DataFlow::Node nd, string q, string repr) {
  (nd instanceof NosqlInjectionWorse::Source and q = "NosqlInjectionWorse") and
  repr = PropagationGraph::getconcatrep(nd, false)
}

query predicate sinkNoSqlClasses(DataFlow::Node nd, string q, string repr) {
  (nd instanceof NosqlInjectionWorse::Sink and q = "NosqlInjectionWorse") and
  repr = PropagationGraph::getconcatrep(nd, true)
}
