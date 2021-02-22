const lib = require('lib');
lib.callback((parm /* event: ba */) => {
    var tainted = parm.f /* event: ba' */;
    var sanitized = lib.sanitize(tainted) /* event: bb */;
    lib.sink(sanitized /* event: bc */);
})

// make sure we have enough occurrences of the representations we care about
lib.callback((parm) => parm.f);
lib.callback((parm) => parm.f);
lib.callback((parm) => parm.f);
lib.callback((parm) => parm.f);
