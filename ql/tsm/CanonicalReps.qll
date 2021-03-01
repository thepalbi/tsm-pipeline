/**
 * An implementation of canonical representations for sinks that represent a more likely
 * representation and allows for using fewer representations for each candidate sink.
 */

import javascript
import NodeRepresentation

/** Canonical representation prioritized for sinks: method parameters. */
private string regExp1() { result = "\\(parameter \\w+ \\(member (\\w+|\\*) .*\\)\\)" }

/** Representation not considered canonical: parameters of deeply nested members. */
private string regExp2() {
  result =
    ".*\\(parameter \\w+ \\(member (\\*|\\w+) \\((member|parameter|return|instance) .*\\)\\)\\)"
}

/**
 *  Prioritizes patterns like `[member _] parameter x (member fun)`
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
 * Prefers a small number of member and parameters for canonical representation.
 *
 * To-Do: Maybe is easier to define whole canonicalRep with a regular expression.
 */
int plusForPreferredStructForRep(int cm, int cmw, int cr, int cp, int cpr, int croot) {
  cm in [0 .. maxdepth()] and
  cmw in [0 .. maxdepth()] and
  cr in [0 .. maxdepth()] and
  cp in [0 .. maxdepth()] and
  cpr in [0 .. maxdepth()] and
  croot in [0 .. maxdepth()] and
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
 *  For sinks prioritizes patterns like `(parameter x (member fun) ...)`.
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
      // Penalizes the receivers against members and roots
      score =
        max(plusForCanonicalRep(rep, sink, depth)) +
          max(plusForPreferredStructForRep(cm, cmw, cr, cp, cpr, croot) - (2 * cpr + 2 * cmw))
      or
      asRhs = false and
      // Penalizes the receivers against members and roots
      score = cm * 4 + cr * 3 + cp * 5 - (cpr * 2 + cmw * 2)
    )
  )
}

/**
 * Returns one canonical representation for a node.
 * For sinks it prioritizes patterns like `(parameter x (member fun))`
 * and the use of external functions, penalizes the receiver as parameter.
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
