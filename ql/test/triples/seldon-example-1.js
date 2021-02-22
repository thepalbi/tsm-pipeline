/**
 * Toy example based on Fib 2.a of Seldon paper.
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
app.post('/unsanitized', (req /* event: a */, res) => {
    console.log(req.body);
    // line 12 Fig 2.a req.body.path is pretending `request.files['f'].filename` on paper
    var resolvedPath = path.join(appDir, req.body.path) /* event: b */;
    // line 14 Fig 2.a req.body.contents is pretending request.files['f'] 
    fs.writeFile(resolvedPath /* event: c */, req.body.contents /* event: c' */, (err) => {
        if (err) {
            res.sendStatus(500);
        } else {
            res.sendStatus(200);
        }
    });
});

// Should not report warning 
app.post('/sanitized', (req /* event: d */, res) => {
    console.log(req.body);
    // line 12 Fig 2.a req.body.path is pretending `request.files['f'].filename` on paper
    var resolvedPath = path.join(appDir, req.body.path) /* event: e */;
    // line 13 Fig 2.a secure filename(filename)
    resolvedPath = sanitizePath(resolvedPath) /* event: e' */;
    // line 14 Fig 2.a req.body.contents is pretending request.files['f']
    if (resolvedPath)
        fs.writeFile(resolvedPath /* event: f */, req.body.contents /* event: f' */, (err) => {
            if (err) {
                res.sendStatus(500);
            } else {
                res.sendStatus(200);
            }
        });
});

function sanitizePath(path) {
    return path;
}

app.listen(port, () => {
    console.log(`Application listening on port ${port}...`);
});
