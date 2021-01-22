/**
 * @name General TSM query
 * @description Checking unsanitized flows
 * @kind path-problem
 * @problem.severity error
 * @precision high
 * @id js/tsm-query
*/

import tsm_config
import DataFlow::PathGraph
import tsm.NodeRepresentation
import tsm_repr_pred


from DataFlow::Configuration cfg, 
    DataFlow::PathNode source, DataFlow::PathNode sink, 
    float score, string rep
where
  (
    cfg instanceof TSMConfig::Configuration
  ) and
  cfg.hasFlowPath(source, sink)
  and rep = candidateRep(sink.getNode(),_, true)
  and score = TsmRepr::getReprScore(rep, "snk")

select sink.getNode(), source, sink, "This query depends on $@.", source.getNode(),
  "a user-provided value", rep, score
