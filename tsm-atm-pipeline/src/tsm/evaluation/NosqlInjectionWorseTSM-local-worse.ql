import javascript
import tsm.evaluation.NosqlInjectionWorseTSMCustomizations
import tsm.nosql.NosqlInjectionTSMConfig
import tsm.TaintSpecificationMining

// For the predicate we use for post-mostern analysis
private import semmle.javascript.security.dataflow.NosqlInjection 
private import tsm.nosql.NosqlInjectionWorseTSMRepresentations
private import tsm.NodeRepresentation

module NosqlInjectionWorse = NosqlInjection;

predicate sameLocationInfo(DataFlow::PathNode n1, DataFlow::PathNode n2) {
    exists(string filepath, int startline, int startcolumn, int endline, int endcolumn |
      n1.hasLocationInfo(filepath, startline, startcolumn, endline, endcolumn) and
      n2.hasLocationInfo(filepath, startline, startcolumn, endline, endcolumn)
    )
  }
  
  query predicate compareVWvsWorseBoosted(int new, int missing, int same) {
    new =
      count(DataFlow::PathNode source, DataFlow::PathNode sink |
        exists(TSMConfig::Configuration cfg |
          cfg.hasFlowPath(source, sink) and
          not exists(
            NosqlInjectionWorse::Configuration cfgV0, DataFlow::PathNode source2, DataFlow::PathNode sink2
          |
            cfgV0.hasFlowPath(source2, sink2) and
            sameLocationInfo(source, source2) and
            sameLocationInfo(sink, sink2)
          )
        )
      ) and
    missing =
      count(DataFlow::PathNode source, DataFlow::PathNode sink |
        exists(NosqlInjectionWorse::Configuration cfgV0 |
          cfgV0.hasFlowPath(source, sink) and
          not exists(
            TSMConfig::Configuration cfg, DataFlow::PathNode source2, DataFlow::PathNode sink2
          |
            cfg.hasFlowPath(source2, sink2) and
            sameLocationInfo(source, source2) and
            sameLocationInfo(sink, sink2)
          )
        )
      ) and
    same =
      count(DataFlow::PathNode source, DataFlow::PathNode sink |
        exists(TSMConfig::Configuration cfg |
          cfg.hasFlowPath(source, sink) and
          exists(
            NosqlInjectionWorse::Configuration cfgV0, DataFlow::PathNode source2, DataFlow::PathNode sink2
          |
            cfgV0.hasFlowPath(source2, sink2) and
            sameLocationInfo(source, source2) and
            sameLocationInfo(sink, sink2)
          )
        )
      )
  }
  
  
  query predicate compareMissedVWvsWorseBoostedSinks(
    DataFlow::PathNode sinkNew, string rep, string library
  ) {
    exists(NosqlInjectionWorse::Configuration cfgV0, DataFlow::PathNode source2, DataFlow::PathNode sink2 |
      cfgV0.hasFlowPath(source2, sink2) and
      not exists(DataFlow::PathNode source, DataFlow::PathNode sink, TSMConfig::Configuration cfg |
        cfg.hasFlowPath(source, sink) and
        sameLocationInfo(source, source2) and
        sameLocationInfo(sink, sink2)
      ) and
      sinkNew = sink2 and
      rep = candidateRep(sinkNew.getNode(),_, true) and
      library = ""
    )
  }
  
  query predicate compareNewVWvsWorseBoostedSinks(
    DataFlow::PathNode sinkNew, string rep, float score, string library
  ) {
    exists(DataFlow::PathNode source, DataFlow::PathNode sink |
      exists(TSMConfig::Configuration cfg |
        cfg.hasFlowPath(source, sink) and
        not exists(
          NosqlInjectionWorse::Configuration cfgVW, DataFlow::PathNode source2, DataFlow::PathNode sink2
        |
          cfgVW.hasFlowPath(source2, sink2) and
          sameLocationInfo(source, source2) and
          sameLocationInfo(sink, sink2)
        ) and
        sink = sinkNew and
        // not sink.getNode() instanceof SqlInjectionWorse::Sink and
        rep = candidateRep(sinkNew.getNode(), _, true) and
        not exists( NosqlInjectionWorse::Sink knownSink |
            rep = candidateRep(knownSink, _, true) 
            ) and
        score = TsmRepr::getReprScore(rep, "snk") and score <= 0.9 and
        library = ""
      )
    )
  }
