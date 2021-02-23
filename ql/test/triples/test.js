const lib = require('lib');
var tainted = lib.source() /* event: aa */;
var sanitized = lib.sanitize(tainted) /* event: ab */;
lib.sink(sanitized /* event: ac */);
lib.sink2({ prop: sanitized /* event: ac' */} /* event: ac'' */);

// make sure we have enough occurrences of the representations we care about
lib.source();
lib.source();
lib.source();
lib.source();
lib.sanitize(tainted);
lib.sanitize(tainted);
lib.sanitize(tainted);
lib.sanitize(tainted);
lib.sink({});
lib.sink({});
lib.sink({});
lib.sink({});
lib.sink2({ prop: {} });
lib.sink2({ prop: {} });
lib.sink2({ prop: {} });
lib.sink2({ prop: {} });
