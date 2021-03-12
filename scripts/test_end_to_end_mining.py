import os
import subprocess
from pathlib import Path
import filecmp

def test_regress_cbc():
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
    expectedOutput = os.path.join(thisFolder, "allscores_NosqlInjectionWorse_avg.expected.txt")
    filecmp.cmp(finalOutput, expectedOutput)