/**
 * A query for computing triples in propagation graphs.
 */

import PropagationGraphs

class AllPackagesAreInteresting extends InterestingPackageForSinks, InterestingPackageForSources {
  AllPackagesAreInteresting() { exists(API::moduleImport(this)) }
}

from DataFlow::Node src, DataFlow::Node san, DataFlow::Node snk
where triple(src, san, snk)
select rep(src, false), rep(san, false), rep(snk, true)
