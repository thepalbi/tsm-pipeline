/**
 * Toy example based on Fib 2.a of Seldon paper, using imaginary `sanitize-path` package wrapped in local function.
 *
 * Translated from Python to JavaScript, and adapted to use Express.
 */

const express = require('express');
const fs = require('fs');
const path = require('path');

const app = express();
const port = 3000;

app.use(express.json());

const appDir = process.env.APP_PATH;
console.log(`Using appDir=[${appDir}]`);

// Should report warning 
app.post('/unsanitized', (req /* event: m */, res) => {
    console.log(req.body);
    // line 12 Fig 2.a req.body.path is pretending `request.files['f'].filename` on paper
    var resolvedPath = path.join(appDir, req.body.path) /* event: n */;
    // line 14 Fig 2.a req.body.contents is pretending request.files['f'] 
    fs.writeFile(resolvedPath /* event: o */, req.body.contents /* event: o' */, (err) => {
        if (err) {
            res.sendStatus(500);
        } else {
            res.sendStatus(200);
        }
    });
});

// Should not report warning 
app.post('/sanitized', (req /* event: p */, res) => {
    console.log(req.body);
    // line 12 Fig 2.a req.body.path is pretending `request.files['f'].filename` on paper
    var resolvedPath = path.join(appDir, req.body.path) /* event: q */;
    // line 13 Fig 2.a secure filename(filename)
    resolvedPath = sanitizePath(resolvedPath);
    // line 14 Fig 2.a req.body.contents is pretending request.files['f']
    if (resolvedPath)
        fs.writeFile(resolvedPath /* event: r' */, req.body.contents /* event: r'' */, (err) => {
            if (err) {
                res.sendStatus(500);
            } else {
                res.sendStatus(200);
            }
        });
});

function sanitizePath(path) {
    return require('sanitize-path')(path /* event: r */) /* event: q' */;
}

app.listen(port, () => {
    console.log(`Application listening on port ${port}...`);
});