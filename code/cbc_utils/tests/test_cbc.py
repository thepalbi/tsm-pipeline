import pytest
import os
import sys
import filecmp
parentFolder = os.path.join(os.getcwd(), "code/cbc_utils")
sys.path.append(parentFolder)
import cbc_utils

def test_regress_cbc():
    # Uncompress the test linear-programming problem
    thisFolder = os.path.join(parentFolder, "tests")
    compressedFile = os.path.join(thisFolder, "problem.lp.xz")
    os.system(f'unxz {compressedFile}')
    # Solve with CBC
    uncompressedFile = os.path.join(thisFolder, "problem.lp")
    resultFile = os.path.join(thisFolder, "test-result.txt")
    cbc_utils.solveLpProblemCBC(uncompressedFile, resultFile)
    # Re-compress the test linear-programming problem (so test is idempotent)
    os.system(f'xz {uncompressedFile}')
    # Check solution matches the golden image
    os.system(f'xz {resultFile}')
    compressedResultFile = os.path.join(thisFolder, "test-result.txt.xz")
    goldenImageFile = os.path.join(thisFolder, "problem-result-image.txt.xz")
    assert(filecmp.cmp(compressedResultFile, goldenImageFile))
