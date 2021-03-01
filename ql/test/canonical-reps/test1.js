const fs = require('fs');

function foo(x/*event: x*/) {
  x.bar/*event: bar*/(0/*event: a*/);
  x.y = 1/*event: b*/;
  x.baz({
    y: 2/*event: c*/
  });
  fs.writeFileSync/*event: wfs*/(3/*event: d*/);
}
