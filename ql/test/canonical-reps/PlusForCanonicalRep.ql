import tsm.CanonicalReps
import test.NamedEvents

from NamedEvent e, string rep
select e.getName(), rep, plusForCanonicalRep(rep, e, _)
