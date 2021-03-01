const fs = require('fs');

function foo(x) {
  x/*event: d*/.bar/*event: e*/(0/*event: a*/);
  x.y = 1/*event: b*/;
  x.baz({
    y: 2/*event: c*/
  });
  fs/*event: f*/.writeFileSync/*event: g*/(3/*event: h*/);
}
