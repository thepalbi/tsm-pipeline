#! /usr/bin/env node

const cp = require('child_process');
const path = require('path');
const readline = require('readline');
const enc = { encoding: 'utf8' };
const StreamZip = require('node-stream-zip');

const dbRoot = process.argv[2];
const projectNames = process.argv.slice(3);

function abbrev(s) {
  if (s.length > 100)
    return s.substr(0, 100) + '...';
  return s;
}

async function getSnippet(db, filePath, startLine, startColumn, endLine, endColumn) {
  let beforeLines = [],
    before = "", highlight = "Could not get source code.", after = "",
    afterLines = [];
  const srczip = path.resolve(db, 'src.zip');
  const zip = new StreamZip.async({ file: srczip });
  const srcStream = await zip.stream(filePath.slice(1));
  const srcLines = readline.createInterface({
    input: srcStream,
    crlfDelay: Infinity
  });

  const beforeStart = Math.max(0, startLine - 4), afterEnd = endLine + 3;
  let lineNumber = 0;
  for await (const line of srcLines) {
    if (lineNumber >= beforeStart && lineNumber < startLine - 1)
      beforeLines.push(abbrev(line));

    if (lineNumber === startLine - 1) {
      before = abbrev(line.slice(0, startColumn - 1));
      if (startLine === endLine) {
        highlight = abbrev(line.slice(startColumn - 1, endColumn));
      } else {
        highlight = abbrev(line.slice(startColumn - 1)) + '\n...\n';
      }
    }

    if (lineNumber === endLine - 1) {
      if (startLine !== endLine) {
        highlight += '...\n' + abbrev(line.slice(0, endColumn));
      }
      after = abbrev(line.slice(endColumn));
    }

    if (lineNumber >= endLine && lineNumber < afterEnd)
      afterLines.push(abbrev(line));

    lineNumber++;
  }
  return { beforeLines, before, highlight, afterLines, after };
}

(async () => {
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
        snippet: await getSnippet(db, tuple[0], tuple[2], tuple[3], tuple[4], tuple[5])
      };
      predictions.push(prediction);
    }
  }
  console.log(JSON.stringify(predictions, null, 2));
})();
