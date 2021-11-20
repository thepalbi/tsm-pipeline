
import argparse
import json
import os
import traceback as tb
import requests
from requests.models import requote_uri
from slugify import slugify
import shutil
from misc.tokens import tokens
import logging
import sys
os.environ["LIBRARIES_API_KEY"] = tokens["LIBRARIES_API_KEY"]


def get_configured_logger(name: str) -> logging.Logger:
    log = logging.getLogger(name)
    log.setLevel(logging.INFO)
    stdout_handler = logging.StreamHandler(sys.stdout)
    stdout_handler.setFormatter(logging.Formatter(
        "%(asctime)s - %(name)s - %(levelname)s - %(message)s"))
    log.addHandler(stdout_handler)
    return log


class LGTMClient:
    def __init__(self, token: str):
        self._session = requests.Session()
        self._session.headers.update({"Authorization": "Bearer %s" % token})
        self._log = get_configured_logger("LGTMClient")

    # Slug should be of the form GithubUser_Repo_CommitHash
    def _get_id_by_slug(self, slug: str) -> str:
        splitted_slug = slug.split("_")
        if len(splitted_slug) != 3:
            raise Exception("Invalid project slug shape")

        res = self._session.get(
            "https://lgtm.com/api/v1.0/projects/g/%s/%s" % (splitted_slug[0], splitted_slug[1]))
        if res.status_code != 200:
            raise Exception("Invalid status code: %d" % res.status_code)

        json_res = res.json()
        return json_res["id"]

    def download_project_to_file(self, slug: str, path: str) -> None:
        if os.path.exists(path):
            raise Exception("File exists in path")

        id = self._get_id_by_slug(slug)
        res = self._session.get(
            "https://lgtm.com/api/v1.0/snapshots/%s/javascript" % id, stream=True)
        if res.status_code != 200:
            raise Exception("Invalid status code: %d" % res.status_code)

        # Downloading file to path
        self._log.info("Downloading project with slug %s", slug)
        with open(path, "wb") as f:
            res.raw.decode_content = True
            shutil.copyfileobj(res.raw, f)
        self._log.info("Downloaded")


def clean_slug(raw_slug: str) -> str:
    return raw_slug.replace("\n", "").strip()


if __name__ == "__main__":
    log = get_configured_logger("main")
    client = LGTMClient(tokens["lgtm"])

    arg_parser = argparse.ArgumentParser()

    # Pick how to download slugs
    group = arg_parser.add_mutually_exclusive_group(required=True)
    group.add_argument("--slug-file", dest="slug_file", required=False,
                       type=str, help="New-line separated file of slugs")
    group.add_argument("--slug", dest="slug", required=False,
                       type=str, help="Slug of the project to download")

    arg_parser.add_argument("--dest", dest="dest",
                            required=True, type=str, help="Destination folder")
    args = arg_parser.parse_args()

    if args.slug_file != None:
        log.info("Using slug file")
        with open(args.slug_file, "r") as sf:
            for slug in sf.readlines():
                destination_path = os.path.join(
                    args.dest, "%s.zip" % clean_slug(slug))
                try:
                    client.download_project_to_file(slug, destination_path)
                except Exception as e:
                    log.error("Failed to download %s. Error: %s", slug, e)

    else:
        destination_path = os.path.join(
            args.dest, "%s.zip" % clean_slug(args.slug))
        client.download_project_to_file(args.slug, destination_path)
