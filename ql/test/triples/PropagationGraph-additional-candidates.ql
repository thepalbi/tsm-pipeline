/**
 * A query for computing triples in propagation graphs.
 */

import tsm.PropagationGraphs

class AdditionalSink extends AdditionalSinkCandidate {
  AdditionalSink() {
    this.getFile().getBaseName() = "test.js" and
    this.getStartLine() = 4 and
    this.getStartColumn() = 10
  }
}

class AdditionalSource extends AdditionalSourceCandidate {
  AdditionalSource() {
    this.getFile().getBaseName() = "test.js" and
    this.getStartLine() = 2 and
    this.getStartColumn() = 15
  }
}

from DataFlow::Node src, DataFlow::Node san, DataFlow::Node snk
where triple(src, san, snk)
select src, san, snk
