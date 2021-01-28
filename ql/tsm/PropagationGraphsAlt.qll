// An alternative implementation of `PropagationGraph.ql` using inter-procedural
// data flow instead of points-to.
import javascript
import PropagationGraphs

// predicate repGenerator = oldCandidateRep/3;
predicate repGenerator = candidateRep/3;
int maxReprPerSink() { result = 5 }

string test(DataFlow::Node sink, int score, int i) {
  i in [1 .. 3] and
  result = chooseBestReps(sink, true, i) and
  PropagationGraph::isRepWithScore(result, sink, _, true, score) and
  sink.getFile().getBaseName() = "admin.js" and
  sink.getStartLine() = 214
}

module PropagationGraph {

  predicate isSourceWorse(DataFlow::Node source) 
  {
    exists(string repr |
      repr = any(KnownRepr k).getRepr("sources") and
      repr = candidateRep(source, false) 
    )
  }

  predicate isSinkWorse(DataFlow::Node sink) 
  {
    exists(string repr |
      repr = any(KnownRepr k).getRepr("sinks") and
      repr = candidateRep(sink, true) 
    )
  }

  predicate isSanitizerWorse(DataFlow::Node sanitizer) {
    // sanitizer instanceof TaintedPathWorse::Sanitizer
    // or sanitizer instanceof TaintedPathWorse::BarrierGuardNode
    exists(string repr |
      repr = any(KnownRepr k).getRepr("sanitizers") and
      repr = candidateRep(sanitizer, false) 
    )
  }
  class KnownRepr extends string {
    bindingset[this]
    KnownRepr() { any()}
    abstract string getRepr(string t);
  }
  abstract class NodeFilter extends string {
    bindingset[this]
    NodeFilter() { any() }

    predicate filterSource(DataFlow::Node src) { any() }

    predicate filterSanitizer(DataFlow::Node san) { any() }

    predicate filterSink(DataFlow::Node snk) { any() }
  }

  predicate tripleSrcSanSnk(DataFlow::Node src, DataFlow::Node san, DataFlow::Node snk) {
    triple(src, san, snk) and
    applyFilter(src, san, snk)
  }

  predicate applyFilter(DataFlow::Node src, DataFlow::Node san, DataFlow::Node snk) {
    any(NodeFilter fsrc).filterSource(src) and
    any(NodeFilter fsan).filterSanitizer(san) and
    any(NodeFilter fs).filterSink(snk)
  }

  predicate pairSanSnk(string ssan, string ssnk) {
    exists(DataFlow::Node src, DataFlow::Node san, DataFlow::Node snk |
      san = reachableFromSourceCandidate(src, DataFlow::TypeTracker::end()) and
      src.getEnclosingExpr() != san.getEnclosingExpr() and
      snk = reachableFromSanitizerCandidate(san, DataFlow::TypeTracker::end()) and
      isSinkCandidate(snk) and
      exists(getconcatrep(src, false)) and
      ssan = getconcatrep(san, false) and
      ssnk = getconcatrep(snk, true) and
      applyFilter(src, san, snk)
    )
  }

  predicate pairSrcSan(string ssrc, string ssan) {
    exists(DataFlow::Node src, DataFlow::Node san, DataFlow::Node snk |
      san = reachableFromSourceCandidate(src, DataFlow::TypeTracker::end()) and
      src.getEnclosingExpr() != san.getEnclosingExpr() and
      snk = reachableFromSanitizerCandidate(san, DataFlow::TypeTracker::end()) and
      isSinkCandidate(snk) and
      exists(getconcatrep(snk, true)) and
      ssan = getconcatrep(san, false) and
      ssrc = getconcatrep(src, false) and
      applyFilter(src, san, snk)
    )
  }

  string getconcatrep(DataFlow::Node n, boolean asRhs) {
    result =
      strictconcat(string r |
        r = chooseBestRep(n, asRhs) and
        // r = chooseBestReps(n, asRhs) and
        count(DataFlow::Node nd2 | r = repGenerator(nd2, _, asRhs)) >= minOcurrences()
      |
        // and
        // exists(DataFlow::Node n2 | candidateRep2(n2, asRhs) = r)
        r, "::"
      )
  }

  /**
   * Gets a candidate representation for `nd`, filtering out very general representations.
   */
  string candidateRepFiltered(DataFlow::Node nd, int depth, boolean asRhs) {
    result = repGenerator(nd, depth, asRhs) and
    // exclude some overly general representations like `(member data *)` or
    // `(parameter 0 (member exports *))`
    not result.regexpMatch("\\((parameter|member) \\w+ (\\*|.*\\(member exports \\*\\))\\)") and
    not result.regexpMatch("\\(root .*\\)") and
    not result.regexpMatch("\\(member \\w+ \\*\\)")
  }

  /**
   * Gets a representation for `nd` that is not extremely rare, that is, it occurs at least five
   * times.
   */
  string rep(DataFlow::Node nd, int depth, boolean asRhs) {
    result = candidateRepFiltered(nd, depth, asRhs) and
    count(DataFlow::Node nd2 | result = candidateRepFiltered(nd2, depth, asRhs)) >= minOcurrences()
  }

  // Canonical representation prioritized for sinks
  private string regExp1() { result = "\\(parameter \\w+ \\(member (\\w+|\\*) .*\\)\\)" }

  // Representation not considered canonical
  private string regExp2() {
    result =
      ".*\\(parameter \\w+ \\(member (\\*|\\w+) \\((member|parameter|return|instance) .*\\)\\)\\)"
  }

  /**
   *  Prioritizes paterns like `[member _] parameter x ( member fun )
   *  by giving an additional score
   */
  int scoreForCanonicalRep(string repr, DataFlow::Node nd, int depth) {
    exists(string rep | 
      rep = rep(nd, depth, true) and
      (
        (
          // Preferred repr
          rep.regexpMatch(regExp1()) and result = 100
          or
          // member X (preferred rep) 
          rep.regexpMatch("\\(member \\w+ " + regExp1() + "\\)") and
          result = 75
          or
          // member * (preferred rep)
          rep.regexpMatch("\\(member \\* " + regExp1() + "\\)") and
          result = 50
        ) and
        not rep.regexpMatch(regExp2())
        or
        result = 0
      ) and repr = rep
    )
  }

  // Prefers an small number of member and parameters for canonical representation
  // To-Do: Maybe is easier to define whole canonicalRep with a regular expresion:
  predicate isPreferedStructForRep(int cm, int cr, int cp, int cpr, int croot) {
    cm in [1 .. 2] and
    cp in [0 .. 2] and
    cr in [0 .. 2] and
    cpr = 0 and
    croot in [0 .. 1] and
    cm + cp + cr in [2..4]
  }

  /**
   *  For sinks prioritizes paterns like `parameter x (return member fun )
   *  by penalizing more occurences of (pamerameter|member)
   */
  predicate isRepWithScore(string rep, DataFlow::Node sink, int depth, boolean asRhs, int score) {
    rep = rep(sink, depth, asRhs) and
    exists(int cm, int cmw, int cr, int cp, int cpr, int croot, int plus1, int plus2 |
      cm = count(rep.indexOf("member")) and
      cmw = count(rep.indexOf("member *")) and
      cr = count(rep.indexOf("return")) and
      cp = count(rep.indexOf("parameter")) and
      cpr = count(rep.indexOf("parameter -1")) and
      croot = count(rep.indexOf("(root ")) and
      (
        asRhs = true and
        plus1 = scoreForCanonicalRep(rep, sink, depth) and
        (
          isPreferedStructForRep(cm, cr, cp, cpr, croot) and
          // Once it has the preferred structure we penalize having 
          // more parameters, members, including a root, etc
          plus2 = 20 - 2 * (cp-1) - 2* ((cm-cmw)-1) - cr - 10 * croot
          or
          not isPreferedStructForRep(cm, cr, cp, cpr, croot) and
          plus2 = 0
        )
        // Penalizes the receivers againts members and roots
        and score = plus1 + plus2  - (2*cpr + 2* cmw)
        or
        asRhs = false and plus1 = 0 and plus2 = 0 and 
        // Penalizes the receivers againts members and roots
        score = cm* 4 + cr * 3 + cp * 5 - (cpr * 2 + cmw*2)
      ) 
    )
  }

  /**
   * Returns one `canonical` representation for a node
   * For sinks it prioritizes paterns like `parameter x (member fun )
   * and the use of external functions, penalizes the receiver as parameter
   */
  string chooseBestRep(DataFlow::Node sink, boolean asRhs) {
    result =
      max(string rep, int depth, int score |
        isRepWithScore(rep, sink, depth, asRhs, score)
      |
        rep order by score, depth, rep /*desc, depth desc, rep*/
      )
  }

  string chooseBestReps(DataFlow::Node node, boolean asRhs) {
    asRhs = true and
    exists(int i | i in [1 .. maxReprPerSink()] | result = chooseBestReps(node, asRhs, i))
    or
    asRhs = false and result = chooseBestRep(node, false)
  }
}

