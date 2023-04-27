from dataclasses import dataclass
from typing import Optional, Tuple
import os


@dataclass
class Parsedkey:
    gh_user: str
    gh_repo: str
    gh_commit_hash: str

    def get_path(self, cache_root_dir: str) -> str:
        return os.path.join(self.get_parent_path(cache_root_dir), self.gh_commit_hash)

    def get_parent_path(self, cache_root_dir: str) -> str:
        return os.path.join(cache_root_dir, self.gh_user, self.gh_repo)


def parse_key(key: str) -> Parsedkey:
    # Expect key to have the following format
    # {{ gh_user }}/{{ gh_repo }}/{{ commit_hash }}
    splitted_key = key.split(DatabasesCache.KEY_SEPARATOR)
    if not len(splitted_key) == 3:
        raise Exception("database key has incorrect format: %s" % (key))

    (gh_user, gh_repo, gh_commit_hash) = splitted_key
    return Parsedkey(gh_user, gh_repo, gh_commit_hash)

class NotCachedError(Exception):
    pass

# TODO: Remove whatsoever from the cache exposing the ParsedKey oustside this package. Cache should just return project
# database directories.
class DatabasesCache:
    KEY_SEPARATOR = "/"

    def __init__(self, root_dir: str, cli_version: str):
        self._advertised_root_dir = root_dir
        self.root_dir = os.path.join(root_dir, cli_version)


    def get(self, key: str) -> Tuple[Parsedkey, Optional[str]]:
        parsed_key = parse_key(key)
        resolved_path = parsed_key.get_path(self.root_dir)
        if not os.path.exists(resolved_path):
            # cache miss
            raise NotCachedError(f"{key} not cached at '{resolved_path}'. Try caching it with CLI: python -m database.cli  --key {key} --cache-root {self._advertised_root_dir}")

        return parsed_key, resolved_path
