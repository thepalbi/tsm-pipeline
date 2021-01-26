import javascript
// import tsm.xss.DomBasedXssTSMConfig
// For the predicate we use for post-mostern analysis
private import semmle.javascript.security.dataflow.DomBasedXss
private import evaluation.DomBasedXssWorse
private import tsm.NodeRepresentation

predicate sameLocationInfo(DataFlow::PathNode n1, DataFlow::PathNode n2) {
  exists(string filepath, int startline, int startcolumn, int endline, int endcolumn |
    n1.hasLocationInfo(filepath, startline, startcolumn, endline, endcolumn) and
    n2.hasLocationInfo(filepath, startline, startcolumn, endline, endcolumn)
  )
}

query predicate compareV0vsWorseSinks(
  DataFlow::PathNode sinkNew, string rep, string library,
  string filepath, int startline, int startcolumn, int endline, int endcolumn 
) {
  exists(DomBasedXss::Configuration cfgV0, 
          DataFlow::PathNode source, DataFlow::PathNode sink |
    cfgV0.hasFlowPath(source, sink) and
    not exists(DomBasedXssWorse::Configuration cfgVW, 
      DataFlow::PathNode source2, DataFlow::PathNode sink2 |
    cfgVW.hasFlowPath(source2, sink2) and
    sameLocationInfo(source, source2) and
    sameLocationInfo(sink, sink2)
    )
    and
    sinkNew = sink and
    sinkNew.hasLocationInfo(filepath, startline, startcolumn, endline, endcolumn) and
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

