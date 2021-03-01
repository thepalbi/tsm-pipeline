import sys
import os

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
    os.system(f'cbc {lpFilePath} -solve -printing all -solu sol.txt')
    with open('sol.txt','r') as file:
        solution = file.readlines()
    return solution

def solveLpProblemCBC(lpFilePath, lpResultsFilePath):
    solution = solveLpCommandLine(lpFilePath)
    writeResultsFile(solution, lpResultsFilePath)

if __name__ == "__main__":
    lpFilePath = sys.argv[1]
    solution = solveLpCommandLine(lpFilePath)
    writeResultsFile(solution, "results.txt")

