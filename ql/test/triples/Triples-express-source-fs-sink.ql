/**
 * A query for computing triples in propagation graphs.
 */

import tsm.Triples
import test.NamedEvents
import PropagationGraph

class ExpressIsInteresting extends InterestingPackageForSources {
  ExpressIsInteresting() { this in ["express"] }
}

class PathIsInteresting extends InterestingPackageForSinks {
  PathIsInteresting() { this in ["fs"] }
}

from NamedEvent src, NamedEvent san, NamedEvent snk
where triple(src, san, snk)
select src.getName(), san.getName(), snk.getName()