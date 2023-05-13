# taking inspiration by the configuration model apache airflow uses, in which
# all configs have a higher order of precedence to easily override others

import configparser
import dataclasses
from typing import List, Optional


@dataclasses.dataclass
class PerformanceConfiguration:
    parallelism: int = 4
    codeql_memory: int = 4000
    codeql_threads: int = 2


class TSMConfigParser(configparser.ConfigParser):
    """Custom TSM ConfigParser. In the future will allow users to
    override default variables much like Airflow allows, with envvars
    for example.
    """
    QUERY_TYPE_SECION_PREFIX = "query_type_"
    PERFORMANCE_PREFIX = "performance_"

    # for now use the default ConfigParser implementation

    def __init__(self):
        # use extended interpolation
        super().__init__(self, interpolation=configparser.ExtendedInterpolation())

    def configured_querytypes(self) -> List[str]:
        return [
            section.replace(self.QUERY_TYPE_SECION_PREFIX, '', 1)
            for section in self.sections()
            if section.startswith(self.QUERY_TYPE_SECION_PREFIX)
        ]

    def get_for_querytype(self, type: str, key: str):
        return self.get(self.QUERY_TYPE_SECION_PREFIX + type, key)

    def get_performance(self, stage: Optional[str] = None) -> PerformanceConfiguration:
        selected_section = "performance"
        if stage is not None:
            for sect in self.sections():
                if sect == self.PERFORMANCE_PREFIX + stage:
                    selected_section = sect

        def get_or_fallback(s, k):
            return self.getint(s, k, fallback=self.getint("performance", k))
        perf = PerformanceConfiguration(
            parallelism=get_or_fallback(selected_section, "parallelism"),
            codeql_memory=get_or_fallback(selected_section, "codeql_memory"),
            codeql_threads=get_or_fallback(selected_section, "codeql_threads"),
        )
        return perf

    def check(self) -> bool:
        for sect in self.sections():
            for key in self[sect]:
                if self.get(sect, key) == "":
                    return False
        return True
