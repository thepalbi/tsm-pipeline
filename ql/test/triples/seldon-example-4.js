/**
 * Toy example based on Fib 2.a of Seldon paper, using regexp-based sanitization.
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
app.post('/unsanitized', (req /* event: s */, res) => {
    console.log(req.body);
    // line 12 Fig 2.a req.body.path is pretending `request.files['f'].filename` on paper
    var resolvedPath = path.join(appDir, req.body.path) /* event: t */;
    // line 14 Fig 2.a req.body.contents is pretending request.files['f'] 
    fs.writeFile(resolvedPath /* event: u */, req.body.contents /* event: u' */, (err) => {
        if (err) {
            res.sendStatus(500);
        } else {
            res.sendStatus(200);
        }
    });
});

// Should not report warning 
app.post('/sanitized', (req /* event: v */, res) => {
    console.log(req.body);
    // line 12 Fig 2.a req.body.path is pretending `request.files['f'].filename` on paper
    var resolvedPath = path.join(appDir, req.body.path) /* event: w */;
    // line 13 Fig 2.a secure filename(filename)
    resolvedPath = sanitizePath(resolvedPath);
    // line 14 Fig 2.a req.body.contents is pretending request.files['f']
    if (resolvedPath)
        fs.writeFile(resolvedPath /* event: x */, req.body.contents /* event: x' */, (err) => {
            if (err) {
                res.sendStatus(500);
            } else {
                res.sendStatus(200);
            }
        });
});

function sanitizePath(path) {
    if (new RegExp(`${path.sep}..${path.sep}`).test(path) /* event: w' */)
        return null;
    return path;
}

app.listen(port, () => {
    console.log(`Application listening on port ${port}...`);
});

// make sure we have enough occurrences of the representations we care about
(function () {
    new RegExp("").test("");
    new RegExp("").test("");
    new RegExp("").test("");
    new RegExp("").test("");
    new RegExp("").test("");
});