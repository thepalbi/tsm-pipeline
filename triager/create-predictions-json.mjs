#! /usr/bin/env ts-node

import { Octokit } from "@octokit/core";
import fs from "fs";

const octokit = new Octokit({ auth: process.env.GITHUB_TOKEN });

const contentCache = new Map();

async function getContent(owner, repo, path) {
  const key = `${owner}/${repo}/${path}`;
  if (contentCache.has(key))
    return contentCache.get(key);
  let content;
  try {
    let res = await octokit.request('GET /repos/{owner}/{repo}/contents/{path}',
      { owner, repo, path });
    content = res.data.content;
  } catch (e) {
    console.error(`/repos/${owner}/${repo}/contents/${path} due to error: ${e}`);
    content = null;
  }
  contentCache.set(key, content);
  return content;
}

(async () => {
  let predictions = [];

  for (let input of process.argv.slice(2)) {
    let data = JSON.parse(fs.readFileSync(input));
    let projectName = data.project.name;
    console.warn("Processing " + projectName);
    let [owner, repo] = projectName.split('/');
    for (let [{ file }, , { value: startLine }, { value: startColumn }, { value: endLine }, { value: endColumn }, { value: repr }, { value: score }] of data.data) {
      startLine = +startLine;
      startColumn = +startColumn;
      endLine = +endLine;
      endColumn = +endColumn;
      score = +score;
      let snippet = {
        beforeLines: [],
        before: "",
        highlight: "Unable to fetch source code.",
        after: "",
        afterLines: []
      };

      let path = file.slice(1);
      let content = await getContent(owner, repo, path);
      if (content == null)
        continue;

      let lines = atob(content.replace(/\n/g, '')).split('\n');
      if (startLine > lines.length || endLine > lines.length)
        continue;

      snippet.beforeLines = lines.slice(Math.max(startLine - 4, 0), startLine - 1);

      if (startLine == endLine) {
        let line = lines[startLine - 1];
        snippet.before = line.slice(0, startColumn - 1);
        snippet.highlight = line.slice(startColumn - 1, endColumn);
        snippet.after = line.slice(endColumn);
      } else {
        let fst = lines[startLine - 1], last = lines[endLine - 1];
        snippet.before = fst.slice(0, startColumn - 1);
        snippet.highlight = fst.slice(startColumn - 1) + '\n...\n' + last.slice(0, endColumn);
        snippet.after = last.slice(endColumn);
      }

      snippet.afterLines = lines.slice(endLine, Math.min(lines.length, endLine + 2));


      predictions.push({
        location: {
          projectName,
          path,
          startLine,
          startColumn,
          endLine,
          endColumn
        },
        repr,
        score,
        snippet
      });
    }
  }

  console.log(JSON.stringify(predictions, null, 2));
})();
