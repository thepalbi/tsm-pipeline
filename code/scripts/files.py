import uuid
from os.path import join as path_join

def db_list_to_file(db_list, tmp_dir):
    tmp_file = path_join(tmp_dir, "{}.txt".format(uuid.uuid4().hex))
    with open(tmp_file, "w") as f:
        for p in db_list:
            f.write(p)
            f.write("\n")
    return tmp_file