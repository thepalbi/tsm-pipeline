import tsm.PropagationGraphs
import NamedEvents

class AllPackagesAreInteresting extends InterestingPackageForSinks, InterestingPackageForSources {
  AllPackagesAreInteresting() { exists(API::moduleImport(this)) }
}

from NamedEvent src, NamedEvent san, NamedEvent snk
where triple(src, san, snk)
select src.getName(), san.getName(), snk.getName()
