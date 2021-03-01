import tsm.CanonicalReps
import test.NamedEvents

from NamedEvent e, boolean asRhs
select e.getName(), asRhs, chooseBestRep(e, asRhs)
