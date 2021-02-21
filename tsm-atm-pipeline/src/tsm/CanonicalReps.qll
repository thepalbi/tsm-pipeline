// An alternative implementation of `PropagationGraph.ql` using inter-procedural
// data flow instead of points-to.
import javascript
import NodeRepresentation


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
int plusForCanonicalRep(string rep, DataFlow::Node nd, int depth) {
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
  )
}

/**
 * This should be the maxdepth() from NodeRepresentations, but is currently private
 */
int pgmaxdepth() { result = 5 }

// Prefers a small number of member and parameters for canonical representation
// To-Do: Maybe is easier to define whole canonicalRep with a regular expresion:
int plusForPreferedStructForRep(int cm, int cmw, int cr, int cp, int cpr, int croot) {
  cm in [0 .. pgmaxdepth()] and
  cmw in [0 .. pgmaxdepth()] and
  cr in [0 .. pgmaxdepth()] and
  cp in [0 .. pgmaxdepth()] and
  cpr in [0 .. pgmaxdepth()] and
  croot in [0 .. pgmaxdepth()] and
  (
    cm in [1 .. 2] and
    cp in [0 .. 2] and
    cr in [0 .. 2] and
    cmw in [0 .. 3] and
    cpr = 0 and
    croot in [0 .. 1] and
    cm + cp + cr in [2 .. 4] and
    result = 20 - 2 * (cp - 1) - 2 * ((cm - cmw) - 1) - cr - 10 * croot
    or
    result = 0
  )
}

/**
 *  For sinks prioritizes paterns like `parameter x (return member fun )
 *  by penalizing more occurences of (pamerameter|member)
 */
predicate isRepWithScore(string rep, DataFlow::Node sink, int depth, boolean asRhs, int score) {
  rep = rep(sink, depth, asRhs) and
  exists(int cm, int cmw, int cr, int cp, int cpr, int croot |
    cm = count(rep.indexOf("member")) and
    cmw = count(rep.indexOf("member *")) and
    cr = count(rep.indexOf("return")) and
    cp = count(rep.indexOf("parameter")) and
    cpr = count(rep.indexOf("parameter -1")) and
    croot = count(rep.indexOf("(root ")) and
    (
      asRhs = true and
      // Penalizes the receivers againts members and roots
      score =
        plusForCanonicalRep(rep, sink, depth) +
            plusForPreferedStructForRep(cm, cmw, cr, cp, cpr, croot) - (2 * cpr + 2 * cmw)
      or
      asRhs = false and
      // Penalizes the receivers againts members and roots
      score = cm * 4 + cr * 3 + cp * 5 - (cpr * 2 + cmw * 2)
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
      rep order by score, depth, rep
      /*desc, depth desc, rep*/
    )
}
