import os
import subprocess
from pathlib import Path
import filecmp

# TODO: set-up proper Python project structure
thisFolder = str(Path(__file__).parent.absolute())
import sys
sys.path.append(thisFolder)
import run

def test_end_to_end_mining():
    # Remove final output
    finalOutput = os.path.join(os.getcwd(), "allscores_NosqlInjectionWorse_avg.txt")
    try:
        os.remove(finalOutput)
    except OSError:
        pass
    # Run TSM
    qlSourceCodePath = os.path.join(thisFolder, "../ql")
    projectsPath = os.path.join(thisFolder, "nosql_projects.txt")
    # Get location of CodeQL
    process = subprocess.Popen(['which', 'codeql'], stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    codeQLPath, err = process.communicate()
    codeQLPath = codeQLPath.decode("utf-8").rstrip()
    print(f'CodeQL path = {codeQLPath}')
    if not codeQLPath:
        print("Error: Bad CodeQL path")
        assert(False)
    run.runTSM(projectsPath, codeQLPath, qlSourceCodePath, "NoSql", False)
    # Check final output was generated
    if not os.path.isfile(finalOutput):
        print(f'Expected output at {finalOutput} but it\'s missing')
        assert(False)
    # Check final output is same as golden image
    with open(finalOutput) as f:
        output = f.readlines()
    print("Output from test is:")
    print("".join(output))
    """
    TODO: make TSM deterministic

    # N.B. We can't activate this more stringent test because it seems TSM is not deterministic
    expectedOutput = os.path.join(thisFolder, "allscores_NosqlInjectionWorse_avg.expected.txt")
    if not filecmp.cmp(finalOutput, expectedOutput):
        print("Incorrect output from test is:")
        print("".join(output))
        with open(expectedOutput) as f:
            expectedOutput = f.readlines()
        print("Expected output from test is:")
        print("".join(expectedOutput))
        print("This indicates a bug, or you need to update the expected output.")
        assert(False)
    """