import tsm.PropagationGraphsAlt
import test.NamedEvents

class MyKnownReprs extends PropagationGraph::KnownRepr {
  MyKnownReprs() { this = "MyKnownReprs" }

  override string getRepr(string t) {
    t = "sources" and result = "(parameter req (parameter 1 (member post *)))"
    or
    t = "sanitizers" and result = "(return (root https://www.npmjs.com/package/sanitize-path))"
    or
    t = "sinks" and result = "(parameter 0 (member writeFile *))"
  }
}

from NamedEvent e, string t
where
  t = "source" and PropagationGraph::isKnownSource(e)
  or
  t = "sanitizer" and PropagationGraph::isKnownSanitizer(e)
  or
  t = "sink" and PropagationGraph::isKnownSink(e)
select t, e.getName()
