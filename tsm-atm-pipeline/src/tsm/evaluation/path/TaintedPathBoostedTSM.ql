import javascript
// Import known source, sink and sanitizer definitions, in other words, the worse libraries
import tsm.evaluation.path.TaintedPathWorseTSMCustomizations
// import the DataFlow::Configuration customized for this evaluation
import tsm.path.TaintedPathBoostedConfig
import tsm.TaintSpecificationMining

from
  DataFlow::Configuration cfg, string origin, DataFlow::Node source, DataFlow::Node sink, string filePathSink,
  int startLineSink, int endLineSink, int startColumnSink, int endColumnSink, string filePathSource,
  int startLineSource, int endLineSource, int startColumnSource, int endColumnSource, float score
where
  cfg.hasFlow(source, sink) and origin = "boosted"
  and
  sink.hasLocationInfo(filePathSink, startLineSink, startColumnSink, endLineSink, endColumnSink) and
  source
      .hasLocationInfo(filePathSource, startLineSource, startColumnSource, endLineSource,
        endColumnSource) and
  TSM::getScoreForFlow(source, sink) = score
select source, startLineSource, startColumnSource, endLineSource, endColumnSource, filePathSource,
  sink, startLineSink, startColumnSink, endLineSink, endColumnSink, filePathSink, score, origin order by
    score desc, startLineSource, startColumnSource, endLineSource, endColumnSource, filePathSource,
    startLineSink, startColumnSink, endLineSink, endColumnSink, filePathSink
