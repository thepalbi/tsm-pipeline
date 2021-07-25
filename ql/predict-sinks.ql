import javascript
import tsm.NodeRepresentation

module TsmRepr {
  external float getReprScore(string repr, string t);
}

import semmle.javascript.security.dataflow.BrokenCryptoAlgorithmCustomizations
import semmle.javascript.security.dataflow.BuildArtifactLeakCustomizations
import semmle.javascript.security.dataflow.CleartextLoggingCustomizations
import semmle.javascript.security.dataflow.CleartextStorageCustomizations
import semmle.javascript.security.dataflow.ClientSideUrlRedirectCustomizations
import semmle.javascript.security.dataflow.CodeInjectionCustomizations
import semmle.javascript.security.dataflow.CommandInjectionCustomizations
import semmle.javascript.security.dataflow.ConditionalBypassCustomizations
import semmle.javascript.security.dataflow.CorsMisconfigurationForCredentialsCustomizations
import semmle.javascript.security.dataflow.DeepObjectResourceExhaustionCustomizations
import semmle.javascript.security.dataflow.DifferentKindsComparisonBypassCustomizations
import semmle.javascript.security.dataflow.ExternalAPIUsedWithUntrustedDataCustomizations
import semmle.javascript.security.dataflow.FileAccessToHttpCustomizations
import semmle.javascript.security.dataflow.HardcodedCredentialsCustomizations
import semmle.javascript.security.dataflow.HardcodedDataInterpretedAsCodeCustomizations
import semmle.javascript.security.dataflow.HttpToFileAccessCustomizations
import semmle.javascript.security.dataflow.ImproperCodeSanitizationCustomizations
import semmle.javascript.security.dataflow.IncompleteHtmlAttributeSanitizationCustomizations
import semmle.javascript.security.dataflow.IndirectCommandInjectionCustomizations
import semmle.javascript.security.dataflow.InsecureDownloadCustomizations
import semmle.javascript.security.dataflow.InsecureRandomnessCustomizations
import semmle.javascript.security.dataflow.InsufficientPasswordHashCustomizations
import semmle.javascript.security.dataflow.LogInjection
import semmle.javascript.security.dataflow.LoopBoundInjectionCustomizations
import semmle.javascript.security.dataflow.NosqlInjectionCustomizations
import semmle.javascript.security.dataflow.PostMessageStarCustomizations
import semmle.javascript.security.dataflow.PrototypePollutingAssignmentCustomizations
import semmle.javascript.security.dataflow.PrototypePollutionCustomizations
import semmle.javascript.security.dataflow.RegExpInjectionCustomizations
import semmle.javascript.security.dataflow.RemotePropertyInjectionCustomizations
import semmle.javascript.security.dataflow.RequestForgeryCustomizations
import semmle.javascript.security.dataflow.ServerSideUrlRedirectCustomizations
import semmle.javascript.security.dataflow.ShellCommandInjectionFromEnvironmentCustomizations
import semmle.javascript.security.dataflow.SqlInjectionCustomizations
import semmle.javascript.security.dataflow.StackTraceExposureCustomizations
import semmle.javascript.security.dataflow.TaintedFormatStringCustomizations
import semmle.javascript.security.dataflow.TaintedPathCustomizations
import semmle.javascript.security.dataflow.TemplateObjectInjectionCustomizations
import semmle.javascript.security.dataflow.TypeConfusionThroughParameterTamperingCustomizations
import semmle.javascript.security.dataflow.UnsafeDeserializationCustomizations
import semmle.javascript.security.dataflow.UnsafeDynamicMethodAccessCustomizations
import semmle.javascript.security.dataflow.UnsafeJQueryPluginCustomizations
import semmle.javascript.security.dataflow.UnsafeShellCommandConstructionCustomizations
import semmle.javascript.security.dataflow.UnvalidatedDynamicMethodCallCustomizations
import semmle.javascript.security.dataflow.XmlBombCustomizations
import semmle.javascript.security.dataflow.XpathInjectionCustomizations
import semmle.javascript.security.dataflow.Xss
import semmle.javascript.security.dataflow.XxeCustomizations
import semmle.javascript.security.dataflow.ZipSlipCustomizations

predicate isKnownSink(DataFlow::Node nd) {
  nd instanceof BrokenCryptoAlgorithm::Sink
  or
  nd instanceof BuildArtifactLeak::Sink
  or
  nd instanceof CleartextLogging::Sink
  or
  nd instanceof CleartextStorage::Sink
  or
  nd instanceof ClientSideUrlRedirect::Sink
  or
  nd instanceof CodeInjection::Sink
  or
  nd instanceof CommandInjection::Sink
  or
  nd instanceof ConditionalBypass::Sink
  or
  nd instanceof CorsMisconfigurationForCredentials::Sink
  or
  nd instanceof DeepObjectResourceExhaustion::Sink
  or
  nd instanceof DifferentKindsComparisonBypass::Sink
  or
  nd instanceof FileAccessToHttp::Sink
  or
  nd instanceof HardcodedCredentials::Sink
  or
  nd instanceof HardcodedDataInterpretedAsCode::Sink
  or
  nd instanceof HttpToFileAccess::Sink
  or
  nd instanceof ImproperCodeSanitization::Sink
  or
  nd instanceof IncompleteHtmlAttributeSanitization::Sink
  or
  nd instanceof IndirectCommandInjection::Sink
  or
  nd instanceof InsecureDownload::Sink
  or
  nd instanceof InsecureRandomness::Sink
  or
  nd instanceof InsufficientPasswordHash::Sink
  or
  nd instanceof LogInjection::Sink
  or
  nd instanceof LoopBoundInjection::Sink
  or
  nd instanceof NosqlInjection::Sink
  or
  nd instanceof PostMessageStar::Sink
  or
  nd instanceof PrototypePollutingAssignment::Sink
  or
  nd instanceof PrototypePollution::Sink
  or
  nd instanceof RegExpInjection::Sink
  or
  nd instanceof RemotePropertyInjection::Sink
  or
  nd instanceof RequestForgery::Sink
  or
  nd instanceof ServerSideUrlRedirect::Sink
  or
  nd instanceof ShellCommandInjectionFromEnvironment::Sink
  or
  nd instanceof SqlInjection::Sink
  or
  nd instanceof StackTraceExposure::Sink
  or
  nd instanceof TaintedFormatString::Sink
  or
  nd instanceof TaintedPath::Sink
  or
  nd instanceof TemplateObjectInjection::Sink
  or
  nd instanceof TypeConfusionThroughParameterTampering::Sink
  or
  nd instanceof UnsafeDeserialization::Sink
  or
  nd instanceof UnsafeDynamicMethodAccess::Sink
  or
  nd instanceof UnsafeJQueryPlugin::Sink
  or
  nd instanceof UnsafeShellCommandConstruction::Sink
  or
  nd instanceof UnvalidatedDynamicMethodCall::Sink
  or
  nd instanceof XmlBomb::Sink
  or
  nd instanceof XpathInjection::Sink
  or
  nd instanceof Xxe::Sink
  or
  nd instanceof ZipSlip::Sink
  or
  exists(DataFlow::PropWrite pw | isKnownSink(pw.getBase()) | nd = pw.getRhs())
}

predicate isEndpoint(DataFlow::Node nd) {
  not exists(nd.getASuccessor()) and
  not exists(DataFlow::InvokeNode invk |
    nd = invk.getAnArgument() and
    exists(invk.getACallee())
  ) and
  not nd.asExpr() instanceof BooleanLiteral and
  not nd.asExpr() instanceof NumberLiteral and
  not nd.getALocalSource() instanceof DataFlow::FunctionNode
}

import semmle.javascript.security.TaintedObject

module TSMConfig {
  /**
   * A taint-tracking configuration for reasoning about tainted-path vulnerabilities.
   */
  class Configuration extends TaintTracking::Configuration {
    Configuration() { this = "SqlInjectionTSMConfiguration" }

    override predicate isSource(DataFlow::Node source) { source instanceof RemoteFlowSource }

    override predicate isSource(DataFlow::Node source, DataFlow::FlowLabel lbl) {
      source instanceof RemoteFlowSource
    }

    override predicate isSink(DataFlow::Node sink) { 
      isKnownSink(sink) 
       or 
      exists(float score | score = TsmRepr::getReprScore(rep(sink, true), "snk") and score>0)
    }

    override predicate isSink(DataFlow::Node sink, DataFlow::FlowLabel lbl) {
      isKnownSink(sink) 
      or 
      exists(float score | score = TsmRepr::getReprScore(rep(sink, true), "snk") and score>0)
    }

    override predicate isAdditionalFlowStep(
      DataFlow::Node src, DataFlow::Node trg, DataFlow::FlowLabel inlbl, DataFlow::FlowLabel outlbl
    ) {
      super.isAdditionalFlowStep(src, trg, inlbl, outlbl)
    }
  }
}

boolean isReachable(DataFlow::Node sink)  {
  exists(TSMConfig::Configuration cfg, DataFlow::Node source | 
            cfg.hasFlow(source, sink))  and result = true
  or not exists(TSMConfig::Configuration cfg, DataFlow::Node source | 
            cfg.hasFlow(source, sink)) and result = false
}
      
from DataFlow::Node nd, File f, int startLine, int endLine, int startColumn, int endColumn, string rep, float score,
      int stmtStartLine, int stmtEndLine, int stmtStartColumn, int stmtEndColumn, 
      int funcStartLine, int funcStartColumn,  boolean reach
where
  rep = rep(nd, true) and
  TsmRepr::getReprScore(rep, "snk") = score and
  not isKnownSink(nd) and
  reach = isReachable(nd) and
  isEndpoint(nd) and
  nd.hasLocationInfo(f.getAbsolutePath(), startLine, startColumn, endLine, endColumn) and
  nd.getEnclosingExpr().getEnclosingStmt().getLocation().hasLocationInfo(f.getAbsolutePath(), stmtStartLine, stmtStartColumn, stmtEndLine, stmtEndColumn) and
  nd.getContainer().getLocation().hasLocationInfo(f.getAbsolutePath(), funcStartLine, funcStartColumn, _, _)
select f.getAbsolutePath(), f.getRelativePath(), startLine, startColumn, endLine, endColumn, 
        rep, score, reach, 
        stmtStartLine, stmtStartColumn, stmtEndLine, stmtEndColumn,
        funcStartLine, funcStartColumn