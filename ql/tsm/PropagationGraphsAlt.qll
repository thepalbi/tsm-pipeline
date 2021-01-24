// An alternative implementation of `PropagationGraph.ql` using inter-procedural
// data flow instead of points-to.
import javascript
import PropagationGraphs

// predicate repGenerator = oldCandidateRep/3;
predicate repGenerator = candidateRep/3;

string test(DataFlow::Node sink, int score, int i) {
  i in [1 .. 3] and
  result = PropagationGraph::chooseBestReps(sink, true, i) and
  PropagationGraph::isRepWithScore(result, sink, _, true, score) and
  sink.getFile().getBaseName() = "admin.js" and
  sink.getStartLine() = 214
}

module PropagationGraph {
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
      // We keep only sinks that are candidates
      // (parameters of library functions)
      // isCandidateSink(snk, targetLibrary()) and
      isSinkCandidate(snk) and
      exists(getconcatrep(src, false)) and
      ssan = getconcatrep(san, false) and
      ssnk = getconcatrep(snk, true) and
      applyFilter(src, san, snk)
    )
  }

  predicate pairSrcSan(string ssrc, string ssan) {
    exists(DataFlow::Node src, DataFlow::Node san, DataFlow::Node snk |
      // isSourceWorse(src) and
      san = reachableFromSourceCandidate(src, DataFlow::TypeTracker::end()) and
      src.getEnclosingExpr() != san.getEnclosingExpr() and
      snk = reachableFromSanitizerCandidate(san, DataFlow::TypeTracker::end()) and
      // We keep only sinks that are candidates
      // (parameters of library functions)
      // isCandidateSink(snk, targetLibrary())  and
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

  private string regExp1() { result = "\\(parameter \\w+ \\(member (\\w+|\\*) .*\\)\\)" }

  private string regExp2() {
    result =
      ".*\\(parameter \\w+ \\(member (\\*|\\w+) \\((member|parameter|return|instance) .*\\)\\)\\)"
  }

  /**
   *  Prioritizes paterns like `[member _] parameter x (return member fun )
   *  by giving an additional score
   */
  int scoreForCanonicalRep(string rep, DataFlow::Node nd, int depth) {
    // rep in ["(parameter 0 (member find (return (member * (member db *)))))",
    // "(parameter 0 (member find *))",
    // "(member * (parameter 0 (member find *)))",
    // "(member x1 (parameter 0 (member find *)))",
    // "(parameter 0 (member find (return (member model *))))",
    // "(member * (parameter 1 (member findOneAndUpdate (return (member model *)))))",
    // "(parameter 0 (member find (return (member * (member db *)))))"
    // ]
    // and
    rep = rep(nd, depth, true) and
    (
      (
        rep.regexpMatch(regExp1()) and result = 100
        or
        // not rep.regexpMatch(regExp1()) and
        rep.regexpMatch("\\(member \\w+ " + regExp1() + "\\)") and
        result = 80
        or
        // not rep.regexpMatch(regExp1()) and not rep.regexpMatch("\\(member \\w+ " + regExp1() + "\\)") and
        rep.regexpMatch("\\(member \\* " + regExp1() + "\\)") and
        result = 50
      ) and
      not rep.regexpMatch(regExp2())
      or
      result = 0
    )
  }

  predicate isPreferedStructForRep(int cm, int cr, int cp, int cpr, int croot) {
    cm in [1 .. 2] and
    cp in [1 .. 2] and
    cr in [0 .. 2] and
    cpr = 0 and
    croot in [0 .. 1]
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
      plus1 = 0 and
      (
        asRhs = true and
        // plus1 = 1 and
        //plus1 = scoreForCanonicalRep(rep, sink, depth) and
        (
          isPreferedStructForRep(cm, cr, cp, cpr, croot) and
          plus2 = 80 - 7 * (cp-1) - 7 * (cm-1) - cmw - 40 * croot- 3*cr
          or
          not isPreferedStructForRep(cm, cr, cp, cpr, croot) and
          plus2 = 0
        )
        or
        asRhs = false and plus1 = 0 and plus2 = 0
      ) and
      // Penalizes the receivers againts members and roots
      score = plus1 + plus2 + cm* 4 + cr * 3 + cp * 5 - cpr * 8 - cmw*7
    )
  }

  /**
   * Returns several `canonical` representation for a node
   * For sinks it prioritizes paterns like `[member _] parameter x (return member fun )
   * and the use of external functions, penalizes the receiver as parameter
   */
  string chooseBestReps(DataFlow::Node sink, boolean asRhs) {
    exists(int i | i in [1 .. 2] | result = chooseBestReps(sink, asRhs, i))
  }

  string chooseBestReps(DataFlow::Node sink, boolean asRhs, int i) {
    result =
      rank[i](string rep, int depth, int score |
        isRepWithScore(rep, sink, depth, asRhs, score)
      |
        rep order by score desc, depth desc, rep
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

  string chooseBestRepOld(DataFlow::Node sink, boolean asRhs) {
    exists(int i | i in [1 .. 3] |
      result =
        rank[i](string rep, int depth, int score |
          // ( result = max(string rep, int depth, int score |
          rep = candidateRepFiltered(sink, depth, asRhs) and
          exists(int cm, int cr, int cp, int cpr, int croot, int plus |
            cm = count(rep.indexOf("member")) and
            cr = count(rep.indexOf("return")) and
            cp = count(rep.indexOf("parameter")) and
            cpr = count(rep.indexOf("parameter -1")) and
            croot = count(rep.indexOf("(root ")) and
            (
              asRhs = true and
              cm >= 1 and
              // cr = 1 and
              cp = 1 and
              croot = 1 and
              cpr = 0 and
              plus = 50
              or
              asRhs = true and
              cm >= 1 and
              // cr = 1 and
              cp = 1 and
              croot = 0 and
              cpr = 0 and
              plus = 150
              or
              plus = 0
            ) and
            // Penalizes the receivers againts members
            score = cm * 4 + cr * 3 + cp * 5 - cpr * 8 + plus
          )
        |
          rep order by score desc, depth desc, rep
        )
    )
  }
}
