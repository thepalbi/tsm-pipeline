/**
 * A query for computing triples in propagation graphs.
 */

import tsm.Triples
import test.NamedEvents
import PropagationGraph

class AdditionalSink extends AdditionalSinkCandidate, NamedEvent {
  AdditionalSink() { name = "ac" }
}

class AdditionalSource extends AdditionalSourceCandidate, NamedEvent {
  AdditionalSource() { name = "aa" }
}

from NamedEvent src, NamedEvent san, NamedEvent snk
where triple(src, san, snk)
select src.getName(), san.getName(), snk.getName()
