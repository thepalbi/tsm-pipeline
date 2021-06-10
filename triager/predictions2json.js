#! /usr/bin/env node

const cp = require('child_process');
const path = require('path');
const enc = { encoding: 'utf8' };
const AdmZip = require('adm-zip');

const dbRoot = process.argv[2];
const projectNames = process.argv.slice(3);

function abbrev(s) {
  if (s.length > 100)
    return s.substr(0, 100) + '...';
  return s;
}

function getSnippet(db, filePath, startLine, startColumn, endLine, endColumn) {
  let beforeLines = [],
    before = "", highlight = "Could not get source code.", after = "",
    afterLines = [];
  try {
    const srczip = path.resolve(db, 'src.zip');
    const zip = new AdmZip(srczip);
    const src = zip.readAsText(filePath.slice(1));
    const srcLines = src.split('\n');
    beforeLines = srcLines.slice(Math.max(0, startLine - 4), startLine - 1).map(abbrev);
    before = abbrev(srcLines[startLine - 1].slice(0, startColumn - 1));
    if (startLine === endLine) {
      highlight = abbrev(srcLines[startLine - 1].slice(startColumn - 1, endColumn));
    } else {
      highlight =
        abbrev(srcLines[startLine - 1].slice(startColumn - 1)) +
        '\n...\n' +
        abbrev(srcLines[endLine - 1].slice(0, endColumn));
    }
    after = abbrev(srcLines[endLine - 1].slice(endColumn));
    afterLines = srcLines.slice(endLine, endLine + 3).map(abbrev);
  } catch (e) {
    console.warn("Unable to get snippet: " + e);
  }
  return { beforeLines, before, highlight, afterLines, after };
}

let predictions = [];
for (const projectName of projectNames) {
  const db = path.resolve(dbRoot, projectName.replace(/\//g, '_'));
  const bqrs = path.resolve(db, 'results', 'sink-predictions.bqrs');
  let out = cp.execFileSync('codeql', ['bqrs', 'decode', '--format=json', bqrs], enc);
  let results = JSON.parse(out);
  for (const tuple of results['#select'].tuples) {
    const prediction = {
      location: {
        projectName,
        path: tuple[1],
        startLine: tuple[2],
        startColumn: tuple[3],
        endLine: tuple[4],
        endColumn: tuple[5]
      },
      repr: tuple[6],
      score: tuple[7],
      snippet: getSnippet(db, tuple[0], tuple[2], tuple[3], tuple[4], tuple[5])
    };
    predictions.push(prediction);
  }
}
console.log(JSON.stringify(predictions, null, 2));
