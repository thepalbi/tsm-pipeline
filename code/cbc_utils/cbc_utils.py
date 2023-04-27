import sys
import os
from utils.process import run_process, RunProcessError
from utils.logging import get_stdout_logger
import logging

log = get_stdout_logger('cbc', level=logging.DEBUG)

class EmptyModelError(Exception):
    """Raised when a model could not be solved because it was empty.
    """
    def __init__(self, *args: object, **kwargs) -> None:
        self.model_path = kwargs.pop("model_path", None)
        super().__init__(*args, **kwargs)


def writeResultsFile(solution, lpResultsFilePath):
    # First line of solution file should be ignored (contains objective value)
    # Get variable values and write (name:value) pairs (as expected by solve_gb.py)
    with open(lpResultsFilePath, "w") as resultfile:
        for r in solution[1:]:
            parts = r.split()
            varName = parts[1]
            varValue = parts[2]
            resultfile.write(f'{varName}:{varValue}\n') 


def solveLpCommandLine(lpFilePath):
    try:
        out = run_process(f'cbc {lpFilePath} -solve -printing all -solu sol.txt')
        # these are some ad-hoc conditions in which the optimization might have failed
        if 'Empty problem' in out.stdout:
            raise EmptyModelError(model_path=lpFilePath)

        log.debug("CBC completed run. STDOUT: %s\nSTDERR: %s", out.stdout, out.stderr)
        with open('sol.txt','r') as file:
            solution = file.readlines()
        return solution
    except RunProcessError as e:
        raise Exception('Failed to run CBC solver', e)
    except Exception as e:
        raise e

def solveLpProblemCBC(lpFilePath, lpResultsFilePath):
    solution = solveLpCommandLine(lpFilePath)
    writeResultsFile(solution, lpResultsFilePath)

if __name__ == "__main__":
    lpFilePath = sys.argv[1]
    solution = solveLpCommandLine(lpFilePath)
    writeResultsFile(solution, "results.txt")

