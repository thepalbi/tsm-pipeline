# taking inspiration by the configuration model apache airflow uses, in which
# all configs have a higher order of precedence to easily override others

import configparser

class TSMConfigParser(configparser.ConfigParser):
    """Custom TSM ConfigParser. In the future will allow users to
    override default variables much like Airflow allows, with envvars
    for example.
    """


    # for now use the default ConfigParser implementation
    def __init__(self):
        # use extended interpolation
        super().__init__(self, interpolation=configparser.ExtendedInterpolation())