/**
 * An implementation of access paths for representing events in propogation graphs.
 */

import javascript

/**
 * Holds if `nd` is relevant to program semantics.
 */
predicate isRelevant(DataFlow::Node nd) {
  // exclude externs files (i.e., our manually-written API models) and ambient files (such as
  // TypeScript `.d.ts` files); there is no real data flow going on in those
  not nd.getTopLevel().isExterns() and
  not nd.getTopLevel().isAmbient() and
  nd.getBasicBlock() instanceof ReachableBasicBlock
}

/**
 * Gets the maximum depth of a candidate representation.
 *
 * Increasing this bound will generate more candidate representations, but
 * will generally negatively affect performance. Note that rare candidates are
 * are filtered out above, so increasing the bound beyond a certain threshold may
 * not actually yield new candidates.
 */
int maxdepth() { result = 4 }

/** Gets a node that the main module of `pkgName` exports under the name `prop`. */
private DataFlow::Node getAnExport(string pkgName, string prop) {
  exists(NPMPackage pkg, Module m |
    pkg.getPackageName() = pkgName and
    m = pkg.getMainModule()
  |
    result = m.getAnExportedValue(prop)
    or
    exists(DataFlow::PropWrite pw |
      pw.writes(m.(NodeModule).getModuleVariable().getAnAccess().flow(), "exports", result) and
      prop = "default"
    )
  )
}

/**
 * Gets a candidate representation of `nd` as a (suffix of an) access path.
 */
string candidateRep(DataFlow::Node nd, int depth, boolean asRhs) {
  // the global object
  isRelevant(nd) and
  nd = DataFlow::globalObjectRef() and
  result = "(global)" and
  depth = 1 and
  asRhs = false
  or
  // package imports/exports
  isRelevant(nd) and
  exists(string pkg |
    nd = DataFlow::moduleImport(pkg) and
    // avoid picking up local imports
    pkg.regexpMatch("[^./].*") and
    asRhs = false
    or
    nd = getAnExport(pkg, "default") and
    asRhs = true
  |
    result = "(root https://www.npmjs.com/package/" + pkg + ")" and
    depth = 1
  )
  or
  // compound representations
  exists(DataFlow::SourceNode base, string step, string baserep |
    (
      (
        baserep = candidateRep(base, depth - 1, false)
        or
        baserep = baseCandidateRep(base, depth - 1, true)
      ) and
      // bound maximum depth of candidate representation
      depth <= maxdepth()
      or
      baserep = "*" and
      depth = 1 and
      // avoid creating trivial representations like `(return *)`
      step.regexpMatch("(member|parameter) [^\\d*].*") and
      isRelevant(nd)
    ) and
    result = "(" + step + " " + baserep + ")"
  |
    // members
    exists(DataFlow::PropRef prop |
      prop = base.getAPropertyRead() and
      nd = prop and
      asRhs = false
      or
      prop = base.getAPropertyWrite() and
      nd = prop.(DataFlow::PropWrite).getRhs() and
      asRhs = true
    |
      step = "member " + prop.getPropertyName()
      or
      step = "member *"
    )
    or
    // instances
    (
      nd = base.getAnInstantiation() and
      asRhs = false
      or
      nd = base.(DataFlow::ClassNode).getAnInstanceReference() and
      asRhs = false
    ) and
    step = "instance"
    or
    // parameters
    exists(string p |
      exists(int i |
        nd = base.(DataFlow::FunctionNode).getParameter(i) and
        not exists(nd.(DataFlow::ParameterNode).getName()) and
        asRhs = false
        or
        nd = base.getAnInvocation().getArgument(i) and
        asRhs = true
      |
        p = i.toString()
      )
      or
      nd = base.(DataFlow::FunctionNode).getAParameter() and
      p = nd.(DataFlow::ParameterNode).getName() and
      asRhs = false
    |
      step = "parameter " + p
    )
    or
    // return values
    (
      nd = base.(DataFlow::FunctionNode).getAReturn() and
      asRhs = true
      or
      nd = base.getACall() and
      asRhs = false
    ) and
    step = "return"
  )
  or
  // named exports, which are treated as members of packages
  isRelevant(nd) and
  exists(string pkg, string m, string baserep |
    nd = getAnExport(pkg, m) and
    baserep = "(root https://www.npmjs.com/package/" + pkg + ")" and
    result = "(member " + m + " " + [baserep, "*"] + ")" and
    depth = 2 and
    asRhs = true
  )
  or
  // global variables, which are treated as members of the global object
  isRelevant(nd) and
  exists(string g |
    nd = DataFlow::globalVarRef(g) and
    asRhs = false
    or
    exists(AssignExpr assgn |
      assgn.getLhs() = DataFlow::globalVarRef(g).asExpr() and
      nd = assgn.getRhs().flow()
    ) and
    asRhs = true
  |
    result = "(member " + g + " (global))" and
    depth = 2
  )
  or
  // we ignore `await`
  exists(DataFlow::SourceNode base |
    base.flowsToExpr(nd.asExpr().(AwaitExpr).getOperand()) and
    result = candidateRep(base, depth, asRhs)
  )
}

pragma[noinline]
string baseCandidateRep(DataFlow::SourceNode base, int depth, boolean asRhs) {
  exists(DataFlow::Node nd |
    result = candidateRep(nd, depth, asRhs) and
    base = nd.getALocalSource()
  )
}

/**
 * Gets the minimum number of occurrences of a candidate representation.
 *
 * Reducing this bound will generate more candidate representations, but
 * will generally negatively affect performance.
 */
int minOccurrences() { result = 1 }

/**
 * Gets a candidate representation for `nd`, filtering out very general representations.
 */
string candidateRepFiltered(DataFlow::Node nd, int depth, boolean asRhs) {
  result = candidateRep(nd, depth, asRhs) and
  // exclude some overly general representations like `(parameter 0 (member exports *))`
  not result.regexpMatch("\\(parameter \\d+ (\\*|\\(member exports \\*\\))\\)") and
  not result.regexpMatch("\\(root .*\\)")
}

/**
 * Gets a representation for `nd` that is not extremely rare, that is, it occurs at least `minOccurrences()`
 * times.
 */
string rep(DataFlow::Node nd, int depth, boolean asRhs) {
  result = candidateRepFiltered(nd, depth, asRhs) and
  count(DataFlow::Node nd2 | result = candidateRepFiltered(nd2, _, asRhs)) >= minOccurrences()
}

string rep(DataFlow::Node nd, boolean asRhs) { result = rep(nd, _, asRhs) }
