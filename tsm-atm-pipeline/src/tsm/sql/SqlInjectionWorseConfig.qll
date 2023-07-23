/**
 * Provides a taint tracking configuration for reasoning about Seldon's paper example
 */

 import javascript
 import semmle.javascript.security.TaintedObject
 import tsm.TaintSpecificationMining
 
 module TSMConfig {
   // Renames SqlInjection as SqlInjectionWorse, assuming SqlInjection comes from a configWorse
   private import semmle.javascript.security.dataflow.SqlInjection::SqlInjection as SqlInjectionWorse
 
   /**
    * A taint-tracking configuration for reasoning about tainted-path vulnerabilities.
    */
   class Configuration extends DataFlow::Configuration {
     Configuration() { this = "SqlInjectionWorseConfiguration" }
 
     override predicate isSource(DataFlow::Node source) { source instanceof TSM::KnownSource }
 
     override predicate isSource(DataFlow::Node source, DataFlow::FlowLabel lbl) {
       source instanceof TSM::KnownSource
     }
 
     override predicate isSink(DataFlow::Node sink) { sink instanceof TSM::KnownSink }
 
     override predicate isSink(DataFlow::Node sink, DataFlow::FlowLabel lbl) {
       sink instanceof TSM::KnownSink
     }
 
     override predicate isBarrier(DataFlow::Node node) { node instanceof TSM::KnownSanitizer }
 
     override predicate isBarrierGuard(DataFlow::BarrierGuardNode guard) {
       guard instanceof TSM::KnownSanitizer
     }
   }
 }
 