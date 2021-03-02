/**
 * A query for computing triples in propagation graphs.
 */

import tsm.PropagationGraphs
import test.NamedEvents

class AllPackagesAreInteresting extends InterestingPackageForSources {
  AllPackagesAreInteresting() { exists(API::moduleImport(this)) }
}

class LibIsInteresting extends InterestingPackageForSinks {
  LibIsInteresting() { this in ["lib"] }
}

from NamedEvent src, NamedEvent san, NamedEvent snk
where triple(src, san, snk)
select src.getName(), san.getName(), snk.getName()
