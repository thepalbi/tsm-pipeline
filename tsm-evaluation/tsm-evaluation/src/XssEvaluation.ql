import javascript
import semmle.javascript.security.dataflow.DomBasedXssQuery

from
  DataFlow::Configuration cfg, string origin, DataFlow::Node source, DataFlow::Node sink, string filePathSink,
  int startLineSink, int endLineSink, int startColumnSink, int endColumnSink, string filePathSource,
  int startLineSource, int endLineSource, int startColumnSource, int endColumnSource, float score
where
  cfg.hasFlow(source, sink) and
  // not TSM::isFlowLikelyInBaseQuery(source, sink) and
  sink.hasLocationInfo(filePathSink, startLineSink, startColumnSink, endLineSink, endColumnSink) and
  source
      .hasLocationInfo(filePathSource, startLineSource, startColumnSource, endLineSource,
        endColumnSource) and
  // Adding random score here
  -1 = score and origin = "v0"
select source, startLineSource, startColumnSource, endLineSource, endColumnSource, filePathSource,
  sink, startLineSink, startColumnSink, endLineSink, endColumnSink, filePathSink, score, origin order by
    score desc, startLineSource, startColumnSource, endLineSource, endColumnSource, filePathSource,
    startLineSink, startColumnSink, endLineSink, endColumnSink, filePathSink
