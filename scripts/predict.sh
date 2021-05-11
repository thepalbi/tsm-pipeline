#! /bin/bash

MYDIR=`dirname $0`

if [ $# -ne 3 ]; then
  echo "Usage: $0 scores_file test_projects threshold"
  exit 1
fi

set -e

scores_file=$1
test_projects=$2
threshold=$3

tsm_ql="$MYDIR/../ql"
if ! [ -d "$tsm_ql" ]; then
  echo "Could not find query library ($tsm_ql is not a directory)."
  exit 1
fi

if [ -z "$LGTM_TOKEN" ]; then
  echo "LGTM_TOKEN not set."
  exit 1
fi

# generate query
query=$(mktemp -t queryXXX.ql)
cat >$query <<EOF
/** @kind problem */

$(cat "$tsm_ql/tsm/NodeRepresentation.qll")

$(cat $scores_file)

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
  nd instanceof BrokenCryptoAlgorithm::Sink or
  nd instanceof BuildArtifactLeak::Sink or
  nd instanceof CleartextLogging::Sink or
  nd instanceof CleartextStorage::Sink or
  nd instanceof ClientSideUrlRedirect::Sink or
  nd instanceof CodeInjection::Sink or
  nd instanceof CommandInjection::Sink or
  nd instanceof ConditionalBypass::Sink or
  nd instanceof CorsMisconfigurationForCredentials::Sink or
  nd instanceof DeepObjectResourceExhaustion::Sink or
  nd instanceof DifferentKindsComparisonBypass::Sink or
  nd instanceof ExternalAPIUsedWithUntrustedData::Sink or
  nd instanceof FileAccessToHttp::Sink or
  nd instanceof HardcodedCredentials::Sink or
  nd instanceof HardcodedDataInterpretedAsCode::Sink or
  nd instanceof HttpToFileAccess::Sink or
  nd instanceof ImproperCodeSanitization::Sink or
  nd instanceof IncompleteHtmlAttributeSanitization::Sink or
  nd instanceof IndirectCommandInjection::Sink or
  nd instanceof InsecureDownload::Sink or
  nd instanceof InsecureRandomness::Sink or
  nd instanceof InsufficientPasswordHash::Sink or
  nd instanceof LogInjection::Sink or
  nd instanceof LoopBoundInjection::Sink or
  nd instanceof NosqlInjection::Sink or
  nd instanceof PostMessageStar::Sink or
  nd instanceof PrototypePollutingAssignment::Sink or
  nd instanceof PrototypePollution::Sink or
  nd instanceof RegExpInjection::Sink or
  nd instanceof RemotePropertyInjection::Sink or
  nd instanceof RequestForgery::Sink or
  nd instanceof ServerSideUrlRedirect::Sink or
  nd instanceof ShellCommandInjectionFromEnvironment::Sink or
  nd instanceof SqlInjection::Sink or
  nd instanceof StackTraceExposure::Sink or
  nd instanceof TaintedFormatString::Sink or
  nd instanceof TaintedPath::Sink or
  nd instanceof TemplateObjectInjection::Sink or
  nd instanceof TypeConfusionThroughParameterTampering::Sink or
  nd instanceof UnsafeDeserialization::Sink or
  nd instanceof UnsafeDynamicMethodAccess::Sink or
  nd instanceof UnsafeJQueryPlugin::Sink or
  nd instanceof UnsafeShellCommandConstruction::Sink or
  nd instanceof UnvalidatedDynamicMethodCall::Sink or
  nd instanceof XmlBomb::Sink or
  nd instanceof XpathInjection::Sink or
  nd instanceof Xxe::Sink or
  nd instanceof ZipSlip::Sink or
  exists(DataFlow::PropWrite pw | isKnownSink(pw.getBase()) | nd = pw.getRhs())
}

from DataFlow::Node nd, float score
where
  TsmRepr::getReprScore(rep(nd, true), "snk") = score and
  score >= ${threshold} and
  not isKnownSink(nd)
select nd, "Predicted new sink (score " + score + ")."
EOF

for test_proj in $test_projects; do
  lgtm_url="https://lgtm.com/api/v1.0/projects/${test_proj}"
  proj_id=$(curl -s $lgtm_url | jq .id)

  lgtm_url="https://lgtm.com/api/v1.0/queryjobs?language=javascript&project-id=${proj_id}"
  resp=$(mktemp -t respXXX.json)
  curl -s -o "$resp" -X POST \
       -H "Content-Type: text/plain" \
       -H "Authorization: Bearer $LGTM_TOKEN" \
       -H "Accept: application/json" \
       --data-binary @$query $lgtm_url
  if [ $(jq .code "$resp") = 429 ]; then
    echo "Rate limit exceeded; no further query jobs will be created."
    break
  fi
  query_console_url=$(jq '.["task-result"]["result-url"]' "$resp")
  if [ "$query_console_url" = "null" ]; then
    echo "Unable to determine query console URL."
    echo "Response from LGTM was:"
    cat "$resp"
    echo
  else
    echo "LGTM.com query-console URL: ${query_console_url}"
  fi
done
