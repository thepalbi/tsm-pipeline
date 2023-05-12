# taking inspiration by the configuration model apache airflow uses, in which
# all configs have a higher order of precedence to easily override others

import configparser
from typing import List


class TSMConfigParser(configparser.ConfigParser):
    """Custom TSM ConfigParser. In the future will allow users to
    override default variables much like Airflow allows, with envvars
    for example.
    """
    QUERY_TYPE_SECION_PREFIX = "query_type_"

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

    def check(self) -> bool:
        for sect in self.sections():
            for key in self[sect]:
                if self.get(sect, key) == "":
                    return False
        return True