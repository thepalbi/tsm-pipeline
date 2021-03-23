const lib = require('otherlib');

// flow through getter/setter pair
class Wrapper {
  setX(v) { this._x = v; }
  getX() { return this._x; }
}
let w = new Wrapper();
w.setX(lib.source() /* event: ca */);
let sanitized = lib.sanitize(w.getX()) /* event: cb */;
lib.sink(sanitized /* event: cc */);

// flow through getter/setter pair
class Wrapper2 {
  x(v) { this._x = v; }
  x() { return this._x; }
}
let w2 = new Wrapper2();
w2.x(lib.source() /* event: da */);
let sanitized2 = lib.sanitize(w2.x()) /* event: db */;
lib.sink(sanitized2 /* event: dc */);

// flow through map
let m = new Map();
m.set('tainted', lib.source() /* event: ea */);
let sanitized3 = lib.sanitize(m.get('tainted')) /* event: eb */;
lib.sink(sanitized3 /* event: ec */);

// spurious flow through unrelated getter/setter pair
class Wrapper3 {
  setX(v) { this._x = v; }
  getX() { return this._x; }
  setY(v) { this._y = v; }
  getY() { return this._y; }
}
let w3 = new Wrapper3();
w3.setX(lib.source() /* event: fa */);
let sanitized3 = lib.sanitize(w3.getY()) /* event: fb */;
lib.sink(sanitized3 /* event: fc */);

// not a getter/setter pair
async function test(fh) {
  fh.read(buf, lib.source() /* event: ga */, len, pos);
  let sanitized4 = lib.sanitize(await fh.readFile({})) /* event: gb */;
  lib.sink(sanitized4 /* event: gc */);
}

// setter but no getter
let w4 = new Wrapper();
w4.setX(lib.source() /* event: ha */);
let sanitized = lib.sanitize(w4) /* event: hb */;
lib.sink(sanitized /* event: hc */);

// no spurious flow through map
let m = new Map();
m.set('tainted1', lib.source() /* event: ia */);
let sanitized3 = lib.sanitize(m.get('tainted2')) /* event: ib */;
lib.sink(sanitized3 /* event: ic */);
