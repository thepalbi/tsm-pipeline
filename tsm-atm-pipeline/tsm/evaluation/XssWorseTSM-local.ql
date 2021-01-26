import javascript
import tsm.evaluation.XssWorseTSMCustomizations
import tsm.xss.DomBasedXssTSMConfig
import tsm.TaintSpecificationMining
// For the predicate we use for post-mostern analysis
private import semmle.javascript.security.dataflow.DomBasedXss
private import evaluation.DomBasedXssWorse
private import tsm.xss.DomBasedXssWorseRepresentations
private import tsm.NodeRepresentation

predicate sameLocationInfo(DataFlow::PathNode n1, DataFlow::PathNode n2) {
  exists(string filepath, int startline, int startcolumn, int endline, int endcolumn |
    n1.hasLocationInfo(filepath, startline, startcolumn, endline, endcolumn) and
    n2.hasLocationInfo(filepath, startline, startcolumn, endline, endcolumn)
  )
}



query predicate compareV0vsWorseBoosted(int new, int missing, int same) {
  new =
    count(DataFlow::PathNode source, DataFlow::PathNode sink |
      exists(TSMConfig::Configuration cfg |
        cfg.hasFlowPath(source, sink) and
        not exists(
          DomBasedXss::Configuration cfgV0, DataFlow::PathNode source2, DataFlow::PathNode sink2
        |
          cfgV0.hasFlowPath(source2, sink2) and
          sameLocationInfo(source, source2) and
          sameLocationInfo(sink, sink2)
        )
      )
    ) and
  missing =
    count(DataFlow::PathNode source, DataFlow::PathNode sink |
      exists(DomBasedXss::Configuration cfgV0 |
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
          DomBasedXss::Configuration cfgV0, DataFlow::PathNode source2, DataFlow::PathNode sink2
        |
          cfgV0.hasFlowPath(source2, sink2) and
          sameLocationInfo(source, source2) and
          sameLocationInfo(sink, sink2)
        )
      )
    )
}

query predicate compareNewV0vsWorseBoostedSinks(
  DataFlow::PathNode sinkNew, string rep, float score, string library
) {
  exists(DataFlow::PathNode source, DataFlow::PathNode sink |
    exists(TSMConfig::Configuration cfg |
      cfg.hasFlowPath(source, sink) and
      not exists(
        DomBasedXss::Configuration cfgV0, DataFlow::PathNode source2, DataFlow::PathNode sink2
      |
        cfgV0.hasFlowPath(source2, sink2) and
        sameLocationInfo(source, source2) and
        sameLocationInfo(sink, sink2)
      ) and
      sink = sinkNew and
      rep = chooseBestRep(sinkNew.getNode(), true) and
      score = TsmRepr::getReprScore(rep, "snk") and
      // (
      //   exists(API::Node imp |
      //     imp = API::moduleImport(library) and
      //     isCandidateSink(sinkNew.getNode(), library)
      //   )
      //   or
      //   not exists(API::Node imp, string lib |
      //     imp = API::moduleImport(lib) and
      //     isCandidateSink(sinkNew.getNode(), lib)
      //   ) and
      //   library = "none"
      // )
      library = ""
    )
  )
}

query predicate compareMissedVWvsWorseBoostedSinks(
  DataFlow::PathNode sinkNew, string rep, string library
) {
  exists(DomBasedXss::Configuration cfgV0, DataFlow::PathNode source2, DataFlow::PathNode sink2 |
    cfgV0.hasFlowPath(source2, sink2) and
    not exists(DataFlow::PathNode source, DataFlow::PathNode sink, TSMConfig::Configuration cfg |
      cfg.hasFlowPath(source, sink) and
      sameLocationInfo(source, source2) and
      sameLocationInfo(sink, sink2)
    ) and
    sinkNew = sink2 and
    rep = chooseBestRep(sinkNew.getNode(), true) and
    // (
    //   exists(API::Node imp |
    //     imp = API::moduleImport(library) and
    //     isCandidateSink(sinkNew.getNode(), library)
    //   )
    //   or
    //   not exists(API::Node imp, string lib |
    //     imp = API::moduleImport(lib) and
    //     isCandidateSink(sinkNew.getNode(), lib)
    //   ) and
    //   library = "none"
    // )
    library = ""
  )
}

query predicate compareNewVWorsevsWorseBoostedSinks(
  DataFlow::PathNode sinkNew, string rep, float score, string library
) {
  exists(DataFlow::PathNode source, DataFlow::PathNode sink |
    exists(TSMConfig::Configuration cfg |
      cfg.hasFlowPath(source, sink) and
      not exists(
        DomBasedXssWorse::Configuration cfgVW, DataFlow::PathNode source2, DataFlow::PathNode sink2
      |
        cfgVW.hasFlowPath(source2, sink2) and
        sameLocationInfo(source, source2) and
        sameLocationInfo(sink, sink2)
      ) and
      sink = sinkNew and
      rep = chooseBestRep(sinkNew.getNode(), true) and
      score = TsmRepr::getReprScore(rep, "snk") and
      // (
      //   exists(API::Node imp |
      //     imp = API::moduleImport(library) and
      //     isCandidateSink(sinkNew.getNode(), library)
      //   )
      //   or
      //   not exists(API::Node imp, string lib |
      //     imp = API::moduleImport(lib) and
      //     isCandidateSink(sinkNew.getNode(), lib)
      //   ) and
      //   library = "none"
      // )
      library = ""
    )
  )
}


query predicate compareSameV0vsWorseBoostedSinks(
  DataFlow::PathNode sinkNew, string rep, string library
) {
  exists(DomBasedXss::Configuration cfgV0, 
          DataFlow::PathNode source2, DataFlow::PathNode sink2 |
    cfgV0.hasFlowPath(source2, sink2) and
    exists(DataFlow::PathNode source, DataFlow::PathNode sink, TSMConfig::Configuration cfg |
      cfg.hasFlowPath(source, sink) and
      sameLocationInfo(source, source2) and
      sameLocationInfo(sink, sink2)
    ) 
    // We ignore sinks already in Worse version
    and  not exists(DomBasedXssWorse::Configuration cfgVW, 
      DataFlow::PathNode source3, DataFlow::PathNode sink3 |
    cfgVW.hasFlowPath(source3, sink3) and
    sameLocationInfo(source3, source2) and
    sameLocationInfo(sink3, sink2)
    )
    and
    sinkNew = sink2 and
    rep = chooseBestRep(sinkNew.getNode(), true) and
    (
      exists(API::Node imp |
        imp = API::moduleImport(library) and
        isCandidateSink(sinkNew.getNode(), library)
      )
      or
      not exists(API::Node imp, string lib |
        imp = API::moduleImport(lib) and
        isCandidateSink(sinkNew.getNode(), lib)
      ) and
      library = "none"
    )
  )
}

from
  DataFlow::Configuration cfg, DataFlow::Node source, DataFlow::Node sink, string filePathSink,
  int startLineSink, int endLineSink, int startColumnSink, int endColumnSink, string filePathSource,
  int startLineSource, int endLineSource, int startColumnSource, int endColumnSource, float score
where
  cfg.hasFlow(source, sink) and
  not TSM::isFlowLikelyInBaseQuery(source, sink) and
  sink.hasLocationInfo(filePathSink, startLineSink, startColumnSink, endLineSink, endColumnSink) and
  source
      .hasLocationInfo(filePathSource, startLineSource, startColumnSource, endLineSource,
        endColumnSource) and
  TSM::getScoreForFlow(source, sink) = score
select source, startLineSource, startColumnSource, endLineSource, endColumnSource, filePathSource,
  sink, startLineSink, startColumnSink, endLineSink, endColumnSink, filePathSink, score order by
    score desc, startLineSource, startColumnSource, endLineSource, endColumnSource, filePathSource,
    startLineSink, startColumnSink, endLineSink, endColumnSink, filePathSink
