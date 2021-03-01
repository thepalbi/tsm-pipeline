import tsm.CanonicalReps
import test.NamedEvents

from NamedEvent e, boolean asRhs, string rep, int score
where isRepWithScore(rep, e, _, asRhs, score)
select e.getName(), asRhs, rep, score
