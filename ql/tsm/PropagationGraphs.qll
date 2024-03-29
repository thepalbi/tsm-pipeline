/**
 * An implementation of propagation graphs for JavaScript, inspired by
 * [Seldon](https://dl.acm.org/doi/10.1145/3314221.3314648).
 *
 * The nodes of the propagation graph (also called "events") are simply normal data-flow nodes
 * (`DataFlow::Node`). In addition to normal data flow edges, we add steps from properties to their
 * containing object and from function-call arguments to returns. Additionally, certain control
 * dependencies are turned into data dependencies by representing checks on variables by
 * propagation-graph edges. For details, see predicate `step` below.
 *
 * We use a simple access-path language to represent events; see `NodeRepresentation.qll`.
 *
 * Unlike Seldon, we do not use a points-to analysis to model inter-procedural flow, but instead use
 * the type-tracking functionality from the CodeQL standard library; see predicate `triple`
 * in `Triples.qll`.
 */

import javascript
import NodeRepresentation

/**
 * The name of an npm package that should be considered when building the propagation graph.
 * The filter is applied to sink and source candidates.
 *
 * To customize, implement concrete subclasses of this class.
 *
 * For example, to only consider `mongodb` in for sink candidates you can use
 *
 * ```ql
 * class MongoDbIsInteresting extends InterestingPackageForSinks {
 *   MongoDbIsInteresting() { this = "mongodb" }
 * }
 * ```
 *
 * To do the same with sources:
 * ```ql
 * class MongoDbIsInteresting extends InterestingPackageForSources {
 *   MongoDbIsInteresting() { this = "mongodb" }
 * }
 * ```
 *
 *
 *
 * To consider all imports interesting, both for sorces and sinks use
 *
 * ```ql
 * class AllPackagesAreInteresting extends InterestingPackageForSinks, InterestingPackageForSources {
 *   AllPackagesAreInteresting() { exists(API::moduleImport(this)) }
 * }
 * ```
 */
abstract class InterestingPackageForSinks extends string {
  bindingset[this]
  InterestingPackageForSinks() { any() }
}

abstract class InterestingPackageForSources extends string {
  bindingset[this]
  InterestingPackageForSources() { any() }
}

/**
 * Allows to include additional source/sinks/sanitizers as candidates
 *
 * For example, to add additional sinks
 *
 * ```ql
 * class MoreSinks extends SinkCandidate {
 *    MoreSinks() { this = any(API::moduleImport(_)).getAnArgument() }
 * }
 * ```
 */
abstract class AdditionalSourceCandidate extends DataFlow::Node { }

abstract class AdditionalSinkCandidate extends DataFlow::Node { }

abstract class AdditionalSanitizerCandidate extends DataFlow::Node { }

/** Holds if data read from a use of `f` may originate from package `pkg`. */
predicate mayComeFromLibrary(API::Node f, string pkg) {
  // base case: import
  f = API::moduleImport(pkg)
  or
  // covariant recursive cases: members, instances, results, and promise contents
  // of something that comes from a library may themselves come from that library
  exists(API::Node base | mayComeFromLibrary(base, pkg) |
    f = base.getAMember() or
    f = base.getInstance() or
    f = base.getReturn() or
    f = base.getPromised()
  )
  or
  // contravariant recursive case: parameters of something that escapes to a library
  // may come from that library
  exists(API::Node base | mayEscapeToLibrary(base, pkg) | f = base.getAParameter())
}

/**
 * Holds if data written to a definition of `f` may flow to package `pkg`.
 */
predicate mayEscapeToLibrary(API::Node f, string pkg) {
  // covariant recursive case: members, instances, results, and promise contents of something that
  // escapes to a library may themselves escape to that library
  exists(API::Node base | mayEscapeToLibrary(base, pkg) |
    f = base.getAMember() or
    f = base.getInstance() or
    f = base.getReturn() or
    f = base.getPromised()
  )
  or
  // contravariant recursive case: arguments passed to a function
  // that comes from a library may escape to that library
  exists(API::Node base | mayComeFromLibrary(base, pkg) | f = base.getAParameter())
}

/**
 * Holds if `pred` is a call of the form `f(..., x, ...)` and `succ` is a subsequent
 * use of `x` where the result of the call is either known to be true or known to be
 * false.
 */
private predicate guard(DataFlow::CallNode pred, DataFlow::Node succ) {
  exists(ConditionGuardNode g, SsaVariable v |
    g.getTest() = pred.asExpr() and
    pred.getAnArgument().asExpr() = v.getAUse() and
    succ.asExpr() = v.getAUse() and
    g.dominates(succ.getBasicBlock())
  )
}

/**
 * Holds if `pred` -> `succ` is a known flow step for which we have a model.
 */
predicate knownStep(DataFlow::Node pred, DataFlow::Node succ) {
  // exclude known flow/taint step, except for the step from `x` to `x.p` (since otherwise
  // property reads will never be considered sources)
  TaintTracking::sharedTaintStep(pred, succ) and
  not succ instanceof DataFlow::PropRead
  or
  DataFlow::SharedFlowStep::step(pred, succ)
  or
  DataFlow::SharedFlowStep::step(pred, succ, _, _)
  or
  DataFlow::SharedFlowStep::loadStep(pred, succ, _)
  or
  DataFlow::SharedFlowStep::storeStep(pred, succ, _)
  or
  DataFlow::SharedFlowStep::loadStoreStep(pred, succ, _)
}

/**
 * Holds if `u` is a candidate for a taint source.
 */
predicate isSourceCandidate(DataFlow::Node u) {
  exists(API::Node nd |
    mayComeFromLibrary(nd, any(InterestingPackageForSources pkg)) and
    not nd = API::moduleImport(_) and
    u = nd.getAnImmediateUse() and
    exists(rep(u, false)) and
    (
      u instanceof DataFlow::CallNode and
      not u = any(Import i).getImportedModuleNode()
      or
      u instanceof DataFlow::ParameterNode
      or
      u instanceof DataFlow::PropRead
    )
  )
  or
  u instanceof AdditionalSourceCandidate
}

/**
 * Holds if `u` is a candidate for a sanitiser.
 */
predicate isSanitizerCandidate(DataFlow::CallNode u) {
  exists(rep(u, false)) and
  not u = any(Import i).getImportedModuleNode()
  or
  u instanceof AdditionalSanitizerCandidate
}

/**
 * Holds if `d` is a candidate for a taint sink.
 */
predicate isSinkCandidate(DataFlow::Node d) {
  exists(API::Node nd |
    mayEscapeToLibrary(nd, any(InterestingPackageForSinks pkg)) and
    d = nd.getARhs() and
    not knownStep(d, _) and
    exists(rep(d, true)) and
    (
      d = any(ReturnStmt ret).getExpr().flow()
      or
      exists(DataFlow::InvokeNode invk |
        d = invk.(DataFlow::MethodCallNode).getReceiver() or
        d = invk.getAnArgument()
      )
      or
      d = any(DataFlow::PropWrite pw).getRhs()
    )
  )
  or
  d instanceof AdditionalSinkCandidate
}

/**
 * Holds if step `pred` -> `succ` should be considered for the propagation graph.
 */
predicate step(DataFlow::Node pred, DataFlow::Node succ) {
  TaintTracking::localTaintStep(pred, succ)
  or
  succ.(DataFlow::SourceNode).hasPropertyWrite(_, pred)
  or
  succ.(DataFlow::CallNode).getAnArgument() = pred
  or
  guard(pred, succ)
}

/**
 * Gets the string value of a constant argument of `mcn`.
 */
private string constantArg(DataFlow::MethodCallNode mcn) {
  mcn.getAnArgument().mayHaveStringValue(result)
}

/**
 * For a method call `mcn` where the method is named something like `get<suffix>` or `set<suffix>`,
 * guess a likely property name for the property that is being get or set.
 *
 * If the suffix is not empty, we just use that as our property name. If it is empty and there is a
 * constant argument, then that's our guess.
 */
bindingset[suffix]
private string guessPropertyName(DataFlow::MethodCallNode mcn, string suffix) {
  if suffix = "" then result = constantArg(mcn) else result = suffix
}

/**
 * Holds if `mcn` looks like it might be a call to a setter updating property `prop` on `base`
 * to `rhs`.
 *
 * The property name is determined heuristically, being either the entire method name or `Foo`
 * if the method name is `storeFoo`, `putFoo`, `setFoo`, or `writeFoo`.
 */
private predicate candidateSetterCall(
  DataFlow::MethodCallNode mcn, DataFlow::Node rhs, DataFlow::Node base, string prop
) {
  // allow up to two extra arguments (e.g., a key and a callback)
  mcn.getNumArgument() <= 3 and
  rhs = mcn.getAnArgument() and
  base = mcn.getReceiver() and
  exists(string suffix | mcn.getMethodName() = ["store", "put", "set", "write"] + suffix |
    prop = guessPropertyName(mcn, suffix)
  )
}

/**
 * Holds if `mcn` looks like it might be a call to a getter retrieving property `prop` on `base`
 * and making it available in `output`.
 *
 * The property name is determined heuristically, being either the entire method name or `Foo`
 * if the method name is `getFoo`, `loadFoo`, or `readFoo`.
 */
private predicate candidateGetterCall(
  DataFlow::MethodCallNode mcn, DataFlow::Node base, DataFlow::Node output, string prop
) {
  // allow up to two extra arguments (e.g., a default value and a callback)
  mcn.getNumArgument() <= 3 and
  base = mcn.getReceiver() and
  output = mcn and
  exists(string suffix | mcn.getMethodName() = ["get", "load", "read"] + suffix |
    prop = guessPropertyName(mcn, suffix)
  )
}

/**
 * A property being read or stored by a (candidate) getter and a setter.
 *
 * We require both since we ultimately want to track through a setter-getter pair.
 */
private class GetterSetterPseudoProperty extends string {
  string prop;

  GetterSetterPseudoProperty() {
    this = "$GetterSetter$" + prop and
    candidateSetterCall(_, _, _, prop) and
    candidateGetterCall(_, _, _, prop)
  }

  string getPropertyName() { result = prop }
}

class GetterSetterStep extends DataFlow::SharedTypeTrackingStep {
  /** Gets a method call that does not call the only export of a module. */
  private DataFlow::MethodCallNode call() {
    exists(DataFlow::SourceNode src |
      not src = DataFlow::moduleImport(_) and
      result = src.getAMethodCall()
    )
  }

  override predicate storeStep(DataFlow::Node pred, DataFlow::SourceNode succ, string prop) {
    exists(DataFlow::Node recv |
      candidateSetterCall(call(), pred, recv, prop.(GetterSetterPseudoProperty).getPropertyName())
    |
      succ = recv.getALocalSource()
    ) and
    not pred.asExpr() instanceof Literal
  }

  override predicate loadStep(DataFlow::Node pred, DataFlow::Node succ, string prop) {
    candidateGetterCall(call(), pred, succ, prop.(GetterSetterPseudoProperty).getPropertyName()) and
    not pred.asExpr() instanceof Literal
  }
}
