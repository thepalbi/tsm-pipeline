import tsm.Triples
import test.NamedEvents

class AllPackagesAreInteresting extends InterestingPackageForSinks, InterestingPackageForSources {
  AllPackagesAreInteresting() { exists(API::moduleImport(this)) }
}

/** A node filter that only allows the triple `(j, k, l)`. */
class Filter1 extends PropagationGraph::NodeFilter {
  Filter1() { this = "Filter1" }

  override predicate filterSource(DataFlow::Node src) { src.(NamedEvent).getName() = "j" }

  override predicate filterSanitizer(DataFlow::Node san) { san.(NamedEvent).getName() = "k" }

  override predicate filterSink(DataFlow::Node snk) { snk.(NamedEvent).getName() = "l" }
}

/** A node filter that only allows the triple `(j, k', l')`. */
class Filter2 extends PropagationGraph::NodeFilter {
  Filter2() { this = "Filter2" }

  override predicate filterSource(DataFlow::Node src) { src.(NamedEvent).getName() = "j" }

  override predicate filterSanitizer(DataFlow::Node san) { san.(NamedEvent).getName() = "k'" }

  override predicate filterSink(DataFlow::Node snk) { snk.(NamedEvent).getName() = "l'" }
}

from string src, string san, string snk
where PropagationGraph::pairSrcSan(src, san) and PropagationGraph::pairSanSnk(san, snk)
select src, san, snk
