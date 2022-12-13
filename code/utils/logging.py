import logging
import sys

stdout_stream_handler = logging.StreamHandler(sys.stdout)
stdout_stream_handler.setFormatter(logging.Formatter('%(asctime)s - %(levelname)s - %(message)s'))

def get_stdout_logger(name: str, level = logging.INFO) -> logging.Logger:
    log = logging.getLogger(name)
    log.addHandler(stdout_stream_handler)
    log.setLevel(level)
    return log