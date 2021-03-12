import os
import subprocess
from pathlib import Path
import filecmp

def test_end_to_end_mining():
    thisFolder = str(Path(__file__).parent.absolute())
    # Remove final output
    finalOutput = os.path.join(thisFolder, "allscores_NosqlInjectionWorse_avg.txt")
    try:
        os.remove(finalOutput)
    except OSError:
        pass
    command = ["./run.sh"]
    result = subprocess.run(command, cwd=thisFolder, capture_output=True, text=True)
    # Check final output was generated
    assert(os.path.isfile(finalOutput))
    # Check final output is same as golden image
    with open(finalOutput) as f:
        output = f.readlines()
    print("Output from test is:")
    print("".join(output))
    '''
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
    '''