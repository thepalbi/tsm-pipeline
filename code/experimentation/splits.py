from sklearn.model_selection import train_test_split
from typing import List
from os import path

def dump_set(data: List[str], path: str) -> None:
    with open(path, 'w') as f:
        for d in data:
            f.write('%s\n' % (d))

if __name__ == "__main__":
    # todo: Make this more generic
    entries_file = "/tesis/repos/tsm-pipeline/experiments/tesis/tainted_path_top_100.txt"
    name = 'tainted_path_100_split'
    output_path = "/tesis/repos/tsm-pipeline/experiments/tesis/tainted_path"

    entries = []
    with open(entries_file, 'r') as f:
        for line in f.readlines():
            line = line.rstrip('\n')
            entries.append(line)

    # Picking 80% of the set for training, and 20 for validation
    train, test = train_test_split(entries, train_size=.8, random_state=0)
    print(len(train))
    dump_set(train, path.join(output_path, '%s_train.txt' % (name)))
    print(len(test))
    dump_set(test, path.join(output_path, '%s_test.txt' % (name)))