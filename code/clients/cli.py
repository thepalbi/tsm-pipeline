from typing import Optional, List, Union, Dict
from utils.clis import resolve_codeqlcli_path
from utils.process import run_process, RunProcessError


class CLIError(Exception):
    def __init__(self, message):
        super().__init__(message)


class CLIClient:
    def __init__(self,
                 exec_path: Optional[str] = None,
                 version: Optional[str] = None,
                 query_run_args: Dict[str, str] = {}):
        if exec_path == None and version == None:
            raise Exception(
                "You have to either configure `exec_path` or `version`")
        if exec_path != None:
            self._cli_path = exec_path
            # Quick fix to fech version if path provided
            self.version = run_process(
                [self._cli_path, 'version -q']).stdout.rstrip('\n')
        else:
            self._cli_path = resolve_codeqlcli_path(version)
            self.version = version
        self._query_run_args = query_run_args

    def query_run(self,
                  db: str,
                  search_path: Union[List[str], str],
                  output: str,
                  query: str,
                  external_predicates: Dict[str, str] = {}):
        if isinstance(search_path, str):
            search_path = [search_path]
        extra_args: List[str] = []
        for k, v in self._query_run_args.items():
            extra_args.append('%s=%s' % (k, v))
        for predicate, file in external_predicates.items():
            extra_args.append('--external=%s=%s' % (predicate, file))
        query_cmd = [
            '%s query run' % (self._cli_path),
            ' '.join(extra_args),
            '-d %s' % (db),
            '--search-path=%s' % (":".join(search_path)),
            '--output=%s' % (output),
            query
        ]

        try:
            run_process(query_cmd)
        except RunProcessError as err:
            raise CLIError("Failed to run query: %s" % (err.stderr))

    def bqrs_decode(self,
                    bqrs: str,
                    result_set: Optional[str],
                    output: str,
                    format: str = "csv"):
        query_cmd = [
            '%s bqrs decode' % (self._cli_path),
            '--result-set=%s' % (result_set) if result_set != None else '',
            '--format %s' % (format),
            '--output=%s' % (output),
            bqrs
        ]

        try:
            run_process(query_cmd)
        except RunProcessError as err:
            raise CLIError("Failed to decode bqrs: %s" % (err.stderr))
