from sklearn.model_selection import train_test_split
from typing import List
from os import path, pardir
import argparse


def dump_set(data: List[str], path: str) -> None:
    with open(path, 'w') as f:
        for d in data:
            f.write('%s\n' % (d))


def make_splits(
    entries_file: str,
    name: str,
    train_size: float
):
    entries_file_par_dir = path.abspath(path.join(entries_file, pardir))
    entries = []
    with open(entries_file, 'r') as f:
        for line in f.readlines():
            line = line.rstrip('\n')
            entries.append(line)

    # Picking 80% of the set for training, and 20 for validation
    train, test = train_test_split(
        entries, train_size=train_size, random_state=0)
    train_entries_file = path.join(entries_file_par_dir, '%s_train.txt' % (name))
    print("train: %s - size: %d" % (train_entries_file, len(train)))
    dump_set(train, train_entries_file)

    test_entries_file = path.join(entries_file_par_dir, '%s_test.txt' % (name))
    print("test: %s - size: %d" % (test_entries_file, len(test)))
    dump_set(test, test_entries_file)


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument(
        "--name", help="name", required=True, type=str
    )
    parser.add_argument(
        "--entries-file", dest="entries_file", help="File where the entries to split are located", required=True, type=str
    )
    parser.add_argument(
        "--train-size", dest="train_size", help="Percentage of entries to dedicate to the train set", required=True, type=float
    )
    args = parser.parse_args()
    make_splits(args.entries_file, args.name, args.train_size)
