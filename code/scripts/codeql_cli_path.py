from utils.clis import resolve_codeqlcli_path
import sys

if __name__ == "__main__":
    print(resolve_codeqlcli_path(sys.argv[1]))