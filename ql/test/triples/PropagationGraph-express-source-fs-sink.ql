/**
 * A query for computing triples in propagation graphs.
 */

import tsm.PropagationGraphs

class ExpressIsInteresting extends InterestingPackageForSources {
  ExpressIsInteresting() { this in ["express"] }
}

class PathIsInteresting extends InterestingPackageForSinks {
  PathIsInteresting() { this in ["fs"] }
}

from DataFlow::Node src, DataFlow::Node san, DataFlow::Node snk
where triple(src, san, snk)
select rep(src, false), rep(san, false), rep(snk, true)
