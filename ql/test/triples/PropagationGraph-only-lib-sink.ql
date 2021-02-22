/**
 * A query for computing triples in propagation graphs.
 */

import tsm.PropagationGraphs

class AllPackagesAreInteresting extends InterestingPackageForSources {
  AllPackagesAreInteresting() { exists(API::moduleImport(this)) }
}

class LibIsInteresting extends InterestingPackageForSinks {
  LibIsInteresting() { this in ["lib"] }
}

from DataFlow::Node src, DataFlow::Node san, DataFlow::Node snk
where triple(src, san, snk)
select rep(src, false), rep(san, false), rep(snk, true)
