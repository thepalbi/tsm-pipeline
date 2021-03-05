/**
 * @kind graph
 */

import javascript
// In this version we use older verisions of standard libraries as Worse versions
import semmle.javascript.security.dataflow.SqlInjectionCustomizations as SqlInjectionCustomizationsWorse

// For backward compatiblity
module SqlInjectionWorse = SqlInjectionCustomizationsWorse::SqlInjection;

import tsm.Triples

// No sanitizer guards in Sql
predicate sanitizerSqlGuard(DataFlow::Node nd, string q, string repr) {
  none() and
  repr = PropagationGraph::getconcatrep(nd, false)
}

// Note from Diego: This predicate didn't exist in the old Sanitizers.ql
// I created this predidate following the template of other sanitizers
query predicate sanitizerSqlClasses(DataFlow::Node nd, string q, string repr) {
  (nd instanceof SqlInjectionWorse::Sanitizer and q = "SqlInjectionWorse") and
  repr = PropagationGraph::getconcatrep(nd, false)
  or
  sanitizerSqlGuard(nd, q, repr)
}

query predicate sourceSqlClasses(DataFlow::Node nd, string q, string repr) {
  (nd instanceof SqlInjectionWorse::Source and q = "SqlInjectionWorse") and
  repr = PropagationGraph::getconcatrep(nd, false)
}

query predicate sinkSqlClasses(DataFlow::Node nd, string q, string repr) {
  (nd instanceof SqlInjectionWorse::Sink and q = "SqlInjectionWorse") and
  repr = PropagationGraph::getconcatrep(nd, true)
}
