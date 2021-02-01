module TsmRepr {
    float getReprScore(string repr, string t){
     repr = "(parameter 0 (member readdirSync *))" and t = "snk" and result = 1.0000000000 or
     repr = "(parameter 0 (member existsSync *))" and t = "snk" and result = 1.0000000000 or
     repr = "(parameter 0 (member mkdirSync *))" and t = "snk" and result = 1.0000000000 or
     repr = "(parameter 0 (member exists *))" and t = "snk" and result = 1.0000000000 or
     repr = "(parameter 0 (member stat *))" and t = "snk" and result = 0.9799019608 or
     repr = "(parameter 0 (member unlink *))" and t = "snk" and result = 1.0000000000 or
     repr = "(parameter 0 (member readFile *))" and t = "snk" and result = 0.9927215190 or
     repr = "(parameter 0 (member createWriteStream *))" and t = "snk" and result = 1.0000000000 or
     repr = "(parameter 0 (member writeFileSync *))" and t = "snk" and result = 1.0000000000 or
     repr = "(parameter 0 (member readdir *))" and t = "snk" and result = 0.9911764706 or
     repr = "(member path *)" and t = "snk" and result = 0.5000000000 or
     repr = "(parameter 0 (member createReadStream *))" and t = "snk" and result = 1.0000000000 or
     repr = "(parameter 0 (member pipe *))" and t = "snk" and result = 0.3009259259 or
     repr = "(parameter 0 (member mkdir *))" and t = "snk" and result = 1.0000000000 or
     repr = "(parameter 0 (member readFileSync *))" and t = "snk" and result = 1.0000000000 or
     repr = "(parameter 0 (member render *))" and t = "snk" and result = 1.0000000000 or
     repr = "(parameter 0 (member writeFile *))" and t = "snk" and result = 1.0000000000 or
     repr = "(parameter 0 (member require (global)))" and t = "snk" and result = 1.0000000000 or
     repr = "(parameter 0 (member readlinkSync *))" and t = "snk" and result = 1.0000000000 or
     repr = "(parameter 0 (member renameSync *))" and t = "snk" and result = 1.0000000000 or
     repr = "(parameter 0 (member utimesSync *))" and t = "snk" and result = 1.0000000000 or
     repr = "(parameter 1 (member rename *))" and t = "snk" and result = 1.0000000000 or
     repr = "(parameter 0 (member unlinkSync *))" and t = "snk" and result = 1.0000000000 or
     repr = "(parameter 1 (member renameSync *))" and t = "snk" and result = 1.0000000000 or
     repr = "(parameter 0 (member truncateSync *))" and t = "snk" and result = 1.0000000000 or
     repr = "(parameter 1 (member define (global)))" and t = "snk" and result = 1.0000000000 or
     repr = "(parameter 1 (member symlinkSync *))" and t = "snk" and result = 1.0000000000 or
     repr = "(parameter 0 (member rename *))" and t = "snk" and result = 1.0000000000 or
     repr = "(parameter 0 (member lstatSync *))" and t = "snk" and result = 1.0000000000 or
     repr = "(parameter 0 (member rmdirSync *))" and t = "snk" and result = 1.0000000000 or
     repr = "(parameter 0 (member define (global)))" and t = "snk" and result = 1.0000000000 or
     repr = "(parameter 0 (member symlinkSync *))" and t = "snk" and result = 1.0000000000 or
     repr = "(parameter 0 (member chmodSync *))" and t = "snk" and result = 1.0000000000 or
     repr = "(parameter 0 (member openSync *))" and t = "snk" and result = 1.0000000000 or
     repr = "(parameter 0 (member json *))" and t = "snk" and result = 0.3659420290 or
     repr = "(parameter 0 (member appendFile *))" and t = "snk" and result = 1.0000000000 or
     repr = "(parameter 0 (member write *))" and t = "snk" and result = 0.3015873016 or
     repr = "(parameter 0 (member send *))" and t = "snk" and result = 0.3391203704 or
     repr = "(return (parameter 1 (member get *)))" and t = "snk" and result = 0.3333333333 or
     repr = "(parameter 0 (member statSync *))" and t = "snk" and result = 0.9941780822 or
     repr = "(parameter 1 (member writeFileSync *))" and t = "snk" and result = 0.3968253968 or
     repr = "(parameter 0 (member watch *))" and t = "snk" and result = 1.0000000000 or
     repr = "(parameter 1 (member setHeader *))" and t = "snk" and result = 0.2765873016 or
     repr = "(parameter 0 (member require *))" and t = "snk" and result = 1.0000000000 or
     repr = "(parameter 1 (member render *))" and t = "snk" and result = 0.3107638889 or
     repr = "(parameter 0 (member redirect *))" and t = "snk" and result = 0.2687500000 or
     repr = "(parameter 0 (member status *))" and t = "snk" and result = 0.2500000000 or
     repr = "(parameter 1 (member header *))" and t = "snk" and result = 0.2500000000 or
     repr = "(member templateUrl (return (parameter 1 (member directive *))))" and t = "snk" and result = 1.0000000000 or
     repr = "(parameter 0 (member end *))" and t = "snk" and result = 0.3303418803 or
     repr = "(return (parameter 1 (member replace *)))" and t = "snk" and result = 0.2500000000 or
     repr = "(parameter 0 (member appendFileSync *))" and t = "snk" and result = 1.0000000000 or
     repr = "(parameter 0 (member update *))" and t = "snk" and result = 0.2816666667 or
     repr = "(parameter 0 (member promisify *))" and t = "snk" and result = 0.2500000000 or
     repr = "(member token (parameter 0 (member json *)))" and t = "snk" and result = 0.3750000000 or
     repr = "(member password (parameter 0 (member create *)))" and t = "snk" and result = 0.5000000000 or
     repr = "(parameter 0 (member create *))" and t = "snk" and result = 0.5000000000 or
     repr = "(parameter 0 (member apply *))" and t = "snk" and result = 0.1666666667 or
     repr = "(member templateUrl *)" and t = "snk" and result = 1.0000000000 or
     repr = "(member * (parameter obj (member extend *)))" and t = "snk" and result = 0.1666666667 or
     repr = "(parameter 1 (member call *))" and t = "snk" and result = 0.1011904762 or
     repr = "(parameter 3 (member call *))" and t = "snk" and result = 0.1011904762 or
     repr = "(parameter 0 (member post *))" and t = "snk" and result = 0.2500000000 or
     repr = "(parameter 0 (root https://www.npmjs.com/package/request))" and t = "snk" and result = 0.2964743590 or
     repr = "(member body (parameter 0 (root https://www.npmjs.com/package/request)))" and t = "snk" and result = 0.1538461538 or
     repr = "(return (member serverError *))" and t = "snk" and result = 0.2500000000 or
     repr = "(parameter 0 (member test *))" and t = "snk" and result = 0.2500000000 or
     repr = "(parameter 1 (member writeHead *))" and t = "snk" and result = 0.2916666667 or
     repr = "(parameter 0 (member closeSync *))" and t = "snk" and result = 0.2500000000 or
     repr = "(parameter 0 (member open *))" and t = "snk" and result = 1.0000000000 or
     repr = "(parameter 0 (member find *))" and t = "snk" and result = 0.7500000000 or
     repr = "(parameter 0 (member limit *))" and t = "snk" and result = 0.2500000000 or
     repr = "(member * (parameter 0 (member find *)))" and t = "snk" and result = 0.2500000000 or
     repr = "(parameter 0 (member count *))" and t = "snk" and result = 0.2500000000 or
     repr = "(parameter 1 (member update *))" and t = "snk" and result = 0.5000000000 or
     repr = "(parameter 0 (member findOne *))" and t = "snk" and result = 0.3750000000 or
     repr = "(member name (parameter 0 (member findOne *)))" and t = "snk" and result = 0.6250000000 or
     repr = "(return (parameter 1 (member post *)))" and t = "snk" and result = 0.3958333333 or
     repr = "(parameter 1 (member jsonp *))" and t = "snk" and result = 0.2500000000 or
     repr = "(return (parameter 0 (member createServer *)))" and t = "snk" and result = 0.3750000000 or
     repr = "(return (parameter 1 (member exists *)))" and t = "snk" and result = 0.2500000000 or
     repr = "(parameter 0 (member mv *))" and t = "snk" and result = 0.7500000000 or
     repr = "(parameter 0 (member lstat *))" and t = "snk" and result = 1.0000000000 or
     repr = "(parameter 0 (member readlink *))" and t = "snk" and result = 1.0000000000 or
     repr = "(parameter 0 (member attachment *))" and t = "snk" and result = 0.2500000000 or
     repr = "(parameter 0 (return (root https://www.npmjs.com/package/esm)))" and t = "snk" and result = 1.0000000000 or
     repr = "(parameter 1 (member execSync *))" and t = "snk" and result = 0.2500000000 or
     repr = "(parameter 1 (member appendFileSync *))" and t = "snk" and result = 0.6666666667 or
     repr = "(parameter 0 (member slice *))" and t = "snk" and result = 0.3750000000 or
     repr = "(parameter 1 (parameter cb *))" and t = "snk" and result = 0.2500000000 or
     repr = "(member src (member data *))" and t = "snk" and result = 0.1500000000 or
     repr = "(member data (parameter 0 (member push *)))" and t = "snk" and result = 0.1500000000 or
     repr = "(member ref (member data *))" and t = "snk" and result = 0.1500000000 or
     repr = "(parameter 0 (member accessSync *))" and t = "snk" and result = 1.0000000000 or
     repr = "(parameter 0 (member map *))" and t = "snk" and result = 0.5000000000 or
     repr = "(parameter 0 (member rmdir *))" and t = "snk" and result = 1.0000000000 or
     repr = "(parameter 0 (member get *))" and t = "snk" and result = 0.5000000000 or
     repr = "(member pathname (instance (member Url *)))" and t = "snk" and result = 0.0593750000 or
     repr = "(return (member is *))" and t = "snk" and result = 0.0583333333 or
     repr = "(member length (parameter req *))" and t = "snk" and result = 0.0833333333 or
     repr = "(member path (instance (member Url *)))" and t = "snk" and result = 0.0593750000 or
     repr = "(return (member exports *))" and t = "snk" and result = 0.2345238095 or
     repr = "(return (member isFresh *))" and t = "snk" and result = 0.2500000000 or
     repr = "(return (parameter 4 (member process_params *)))" and t = "snk" and result = 0.2500000000 or
     repr = "(member header (return (member decode *)))" and t = "snk" and result = 0.2500000000 or
     repr = "(parameter 0 (member fatal *))" and t = "snk" and result = 0.2500000000 or
     repr = "(parameter 1 (member emit *))" and t = "snk" and result = 0.3040865385 or
     repr = "(member tokens *)" and t = "snk" and result = 0.2500000000 or
     repr = "(member buffer (instance (member exports *)))" and t = "snk" and result = 0.2500000000 or
     repr = "(parameter 0 (member symlink *))" and t = "snk" and result = 1.0000000000 or
     repr = "(parameter 0 (member link *))" and t = "snk" and result = 1.0000000000 or
     repr = "(parameter 1 (member symlink *))" and t = "snk" and result = 1.0000000000 or
     repr = "(parameter 0 (member parse *))" and t = "snk" and result = 0.1375000000 or
     repr = "(member handler *)" and t = "snk" and result = 0.2500000000 or
     repr = "(member _parsedUrl (parameter req (member exports *)))" and t = "snk" and result = 0.0593750000 or
     repr = "(member message (parameter 0 (member send *)))" and t = "snk" and result = 0.1250000000 or
     repr = "(parameter 0 (return (member hijack *)))" and t = "snk" and result = 1.0000000000 or
     repr = "(parameter 2 (member handler *))" and t = "snk" and result = 0.2500000000 or
     repr = "(member _raw (member _parsedUrl *))" and t = "snk" and result = 0.0593750000 or
     repr = "(member href (instance (member Url *)))" and t = "snk" and result = 0.0593750000 or
     repr = "(parameter 0 (member nextTick *))" and t = "snk" and result = 0.2500000000 or
     repr = "(return (member byteLength *))" and t = "snk" and result = 0.2500000000 or
     repr = "(parameter 1 (member * (instance (member exports *))))" and t = "snk" and result = 0.5000000000 or
     repr = "(return (return (member compileQueryParser *)))" and t = "snk" and result = 0.0593750000 or
     repr = "(parameter 1 (member link *))" and t = "snk" and result = 1.0000000000 or
     repr = "(member search (instance (member Url *)))" and t = "snk" and result = 0.0593750000 or
     repr = "(parameter 0 (member die *))" and t = "snk" and result = 0.2500000000 or
     repr = "(parameter 0 (member realpath *))" and t = "snk" and result = 1.0000000000 or
     repr = "(member query (instance (member Url *)))" and t = "snk" and result = 0.0593750000 or
     repr = "(parameter 0 (member call *))" and t = "snk" and result = 0.1666666667 or
     repr = "(return (parameter 1 (member on *)))" and t = "snk" and result = 0.3333333333 or
     repr = "(member message (parameter 0 (member json *)))" and t = "snk" and result = 0.1666666667 or
     repr = "(member body (parameter req (member exports *)))" and t = "snk" and result = 0.0833333333 or
     repr = "(return (parameter 1 (member stat *)))" and t = "snk" and result = 0.2500000000 or
     repr = "(member user *)" and t = "snk" and result = 0.2500000000 or
     repr = "(parameter 0 (member removeSync *))" and t = "snk" and result = 0.2500000000 or
     repr = "(parameter 0 (member request *))" and t = "snk" and result = 0.3011904762 or
     repr = "(parameter 1 (member flash *))" and t = "snk" and result = 0.2500000000 or
     repr = "(member path (parameter 0 (member request *)))" and t = "snk" and result = 0.3071428571 or
     repr = "(member port (parameter 0 (member request *)))" and t = "snk" and result = 0.1666666667 or
     repr = "(parameter 0 (member indexOf *))" and t = "snk" and result = 0.2500000000 or
     repr = "(member * (return (member split *)))" and t = "snk" and result = 0.2500000000 or
     repr = "(member id (parameter 0 (member update *)))" and t = "snk" and result = 0.2500000000 or
     repr = "(parameter 0 (member touch *))" and t = "snk" and result = 1.0000000000 or
     repr = "(parameter 0 (member eachSeries *))" and t = "snk" and result = 0.2500000000 or
     repr = "(parameter 0 (member cd *))" and t = "snk" and result = 1.0000000000 or
     repr = "(parameter 0 (member ok *))" and t = "snk" and result = 0.3750000000 or
     repr = "(member Content-Length (member headers *))" and t = "snk" and result = 0.1125000000 or
     repr = "(member headers (parameter 0 (member request *)))" and t = "snk" and result = 0.1041666667 or
     repr = "(parameter 1 (member writeFile *))" and t = "snk" and result = 0.4687500000 or
     repr = "(parameter 0 (member sendFile *))" and t = "snk" and result = 0.2333333333 or
     repr = "(member document (parameter 1 (member render *)))" and t = "snk" and result = 0.2500000000 or
     repr = "(parameter 0 (member watchFile *))" and t = "snk" and result = 1.0000000000 or
     repr = "(parameter 0 (member access *))" and t = "snk" and result = 0.9404761905 or
     repr = "(parameter 0 (member config (global)))" and t = "snk" and result = 1.0000000000 or
     repr = "(parameter 0 (member go (global)))" and t = "snk" and result = 1.0000000000 or
     repr = "(parameter 1 (member substring *))" and t = "snk" and result = 0.2500000000 or
     repr = "(parameter 0 (parameter cb *))" and t = "snk" and result = 0.5000000000 or
     repr = "(return (parameter 2 (member get *)))" and t = "snk" and result = 0.2500000000 or
     repr = "(return (parameter 3 (member get *)))" and t = "snk" and result = 0.5000000000 or
     repr = "(parameter 0 (member exec *))" and t = "snk" and result = 0.2500000000 or
     repr = "(return (parameter 2 (member post *)))" and t = "snk" and result = 0.5000000000 or
     repr = "(member * (parameter 1 (member writeHead *)))" and t = "snk" and result = 0.3125000000 or
     repr = "(parameter 1 (member deepEqual *))" and t = "snk" and result = 0.2500000000 or
     repr = "(parameter 1 (member apply *))" and t = "snk" and result = 0.7500000000 or
     repr = "(parameter 0 (member strictEqual *))" and t = "snk" and result = 0.7500000000 or
     repr = "(member data (parameter 0 (member json *)))" and t = "snk" and result = 0.5000000000 or
     repr = "(member json (parameter 0 (root https://www.npmjs.com/package/request)))" and t = "snk" and result = 0.3750000000 or
     repr = "(parameter 0 (member truncate *))" and t = "snk" and result = 1.0000000000 or
     repr = "(member host (parameter 0 (member request *)))" and t = "snk" and result = 0.1833333333 or
     repr = "(member method (parameter 0 (member request *)))" and t = "snk" and result = 0.0833333333 or
     repr = "(parameter 0 (member chown *))" and t = "snk" and result = 1.0000000000 or
     repr = "(parameter 1 (member rm *))" and t = "snk" and result = 1.0000000000 or
     repr = "(parameter 0 (member ls *))" and t = "snk" and result = 1.0000000000 or
     repr = "(parameter 0 (member chmod *))" and t = "snk" and result = 1.0000000000 or
     repr = "(parameter 0 (member rm *))" and t = "snk" and result = 1.0000000000 or
     repr = "(member result (parameter 1 (member render *)))" and t = "snk" and result = 0.4166666667 or
     repr = "(parameter 1 (member pump *))" and t = "snk" and result = 0.2500000000 or
     repr = "(member host (parameter 2 (member request *)))" and t = "snk" and result = 0.1160714285 or
     repr = "(parameter 2 (member request *))" and t = "snk" and result = 0.1160714285 or
     repr = "(parameter 1 (member request *))" and t = "snk" and result = 0.1160714285 or
     repr = "(parameter 1 (member createClient *))" and t = "snk" and result = 0.1160714285 or
     repr = "(parameter 0 (member cat *))" and t = "snk" and result = 1.0000000000 or
     repr = "(parameter 0 (member unset *))" and t = "snk" and result = 0.5000000000 or
     repr = "(parameter 1 (member get *))" and t = "snk" and result = 0.5000000000 or
     repr = "(member Location (parameter 1 (member writeHead *)))" and t = "snk" and result = 0.1250000000 or
     repr = "(member uri (parameter 0 (root https://www.npmjs.com/package/request)))" and t = "snk" and result = 0.0625000000 or
     repr = "(parameter 0 (member Package *))" and t = "snk" and result = 0.2500000000 or
     repr = "(parameter 0 (member writeHead *))" and t = "snk" and result = 0.2500000000 or
     repr = "(return (parameter 2 (member readFile *)))" and t = "snk" and result = 0.2500000000 or
     repr = "(return (parameter 1 (member getWorkspace *)))" and t = "snk" and result = 0.2500000000 or
     repr = "(member pathname (parameter 0 (member format *)))" and t = "snk" and result = 0.2500000000 or
     repr = "(member * (member json *))" and t = "snk" and result = 0.2500000000 or
     repr = "(member email (parameter 0 (member findOne *)))" and t = "snk" and result = 0.2500000000 or
     repr = "(parameter 0 (member green *))" and t = "snk" and result = 0.1538461539 or
     repr = "(member text (parameter 0 (member adminWriteLog *)))" and t = "snk" and result = 0.2500000000 or
     repr = "(parameter 1 (member updateOne *))" and t = "snk" and result = 0.2500000000 or
     repr = "(parameter 1 (member copy *))" and t = "snk" and result = 0.2500000000 or
     repr = "(parameter 0 (member ontext *))" and t = "snk" and result = 0.2500000000 or
     repr = "(parameter 3 (member copy *))" and t = "snk" and result = 0.2500000000 or
     repr = "(parameter 0 (member r (global)))" and t = "snk" and result = 1.0000000000 or
     repr = "(parameter 0 (member utimes *))" and t = "snk" and result = 1.0000000000 or
     repr = "(parameter 1 (member chmod *))" and t = "snk" and result = 1.0000000000 or
     repr = "(parameter 1 (member mkdir *))" and t = "snk" and result = 1.0000000000 or
     repr = "(parameter 1 (member cp *))" and t = "snk" and result = 1.0000000000 or
     repr = "(parameter 2 (member set *))" and t = "snk" and result = 0.2500000000 or
     repr = "(parameter 0 (member to *))" and t = "snk" and result = 1.0000000000 or
     repr = "(parameter 1 (member ln *))" and t = "snk" and result = 1.0000000000 or
     repr = "(parameter 0 (member set *))" and t = "snk" and result = 0.7500000000 or
     repr = "(return (parameter 1 (root https://www.npmjs.com/package/request)))" and t = "snk" and result = 0.3750000000 or
     repr = "(parameter 0 (member cp *))" and t = "snk" and result = 1.0000000000 or
     repr = "(parameter 2 (member cp *))" and t = "snk" and result = 1.0000000000 or
     repr = "(parameter 1 (member mv *))" and t = "snk" and result = 1.0000000000 or
     repr = "(parameter 2 (member ln *))" and t = "snk" and result = 1.0000000000 or
     repr = "(parameter 0 (member ln *))" and t = "snk" and result = 1.0000000000 or
     repr = "(parameter 0 (member charAt *))" and t = "snk" and result = 0.2500000000 or
     repr = "(member body (parameter res *))" and t = "snk" and result = 0.7500000000 or
     repr = "(parameter 1 (return (member bind *)))" and t = "snk" and result = 0.5000000000 or
     repr = "(parameter 1 (member writeFileAsync *))" and t = "snk" and result = 0.2500000000 or
     repr = "(parameter 0 (member unwatchFile *))" and t = "snk" and result = 1.0000000000 or
     repr = "(member path (member request *))" and t = "snk" and result = 0.1000000000 or
     repr = "(parameter 1 (member post *))" and t = "snk" and result = 0.2500000000 or
     repr = "(member start (parameter 1 (member createReadStream *)))" and t = "snk" and result = 0.2500000000 or
     repr = "(parameter 1 (member createHmac *))" and t = "snk" and result = 0.1000000000 or
     repr = "(parameter 1 (member send *))" and t = "snk" and result = 0.2500000000 or
     repr = "(member Authorization (member headers *))" and t = "snk" and result = 0.1000000000 or
     repr = "(parameter 0 (member chownSync *))" and t = "snk" and result = 1.0000000000 or
     repr = "(member val (parameter 0 (member used *)))" and t = "snk" and result = 0.1000000000 or
     repr = "(parameter 0 (member equal *))" and t = "snk" and result = 0.4437500000 or
     repr = "(parameter 1 (member appendFile *))" and t = "snk" and result = 0.5000000000 or
     repr = "(member result (parameter 0 (member json *)))" and t = "snk" and result = 0.1250000000 or
     repr = "(return (parameter 0 (member exec *)))" and t = "snk" and result = 0.1250000000 or
     repr = "(parameter 0 (member authenticate *))" and t = "snk" and result = 0.5000000000 or
     repr = "(member password (parameter user *))" and t = "snk" and result = 0.5000000000 or
     repr = "(parameter 0 (member createClient *))" and t = "snk" and result = 0.1250000000 or
     repr = "(member code *)" and t = "snk" and result = 0.7500000000 or
     repr = "(parameter 0 (member sendfile *))" and t = "snk" and result = 0.5000000000 or
     repr = "(return (parameter 1 (member put *)))" and t = "snk" and result = 0.5000000000 or
     repr = "(return (parameter 1 (member readFile *)))" and t = "snk" and result = 0.2500000000 or
     repr = "(parameter 0 (member setHeader *))" and t = "snk" and result = 0.2500000000 or
     repr = "(parameter 0 (member red *))" and t = "snk" and result = 0.0576923077 or
     repr = "(parameter 0 (member yellow *))" and t = "snk" and result = 0.0576923077 or
     repr = "(parameter 0 (member blue *))" and t = "snk" and result = 0.0576923077 or
     repr = "(parameter 0 (member linkSync *))" and t = "snk" and result = 1.0000000000 or
     repr = "(parameter 0 (member writeHeader *))" and t = "snk" and result = 0.2500000000 or
     repr = "(parameter 1 (member linkSync *))" and t = "snk" and result = 1.0000000000 or
     repr = "(parameter 1 (member writeSync *))" and t = "snk" and result = 0.1250000000 or
     repr = "(parameter 3 (member writeSync *))" and t = "snk" and result = 0.1250000000 or
     repr = "(return (parameter 5 (member get *)))" and t = "snk" and result = 0.5000000000 or
     repr = "(parameter 0 (root https://www.npmjs.com/package/assert))" and t = "snk" and result = 0.5000000000 or
     repr = "(parameter 1 (member equal *))" and t = "snk" and result = 0.2500000000 or
     repr = "(member * (parameter custom_val *))" and t = "snk" and result = 0.2500000000 or
     repr = "(member url (parameter 0 (root https://www.npmjs.com/package/request)))" and t = "snk" and result = 1.0000000000 or
     repr = "(member * (return (member Array (global))))" and t = "snk" and result = 0.2500000000 or
     repr = "(return (parameter 0 (member once *)))" and t = "snk" and result = 0.2500000000 or
     repr = "(return (member forEachRight *))" and t = "snk" and result = 0.2500000000 or
     repr = "(member stack (parameter error *))" and t = "snk" and result = 0.2500000000 or
     repr = "(return (member placeholder *))" and t = "snk" and result = 0.2500000000 or
     repr = "(return (member init *))" and t = "snk" and result = 0.2500000000 or
     repr = "(parameter 0 (parameter 1 (parameter eachFunc *)))" and t = "snk" and result = 0.2500000000 or
     repr = "(parameter 1 (member on *))" and t = "snk" and result = 0.2500000000 or
     repr = "(return (member write *))" and t = "snk" and result = 0.2500000000 or
     repr = "(return (member lastIndexOf *))" and t = "snk" and result = 0.2500000000 or
     repr = "(member message (instance (member exports *)))" and t = "snk" and result = 0.2500000000 or
     repr = "(member hostname (return (parameter 0 (member map *))))" and t = "snk" and result = 0.7500000000 or
     repr = "(parameter 1 (member noop *))" and t = "snk" and result = 0.5000000000 or
     repr = "(member * (parameter 0 (member call *)))" and t = "snk" and result = 0.2500000000 or
     repr = "(return (parameter 1 (member removeListener *)))" and t = "snk" and result = 0.2500000000 or
     repr = "(member * (member all *))" and t = "snk" and result = 0.2500000000 or
     repr = "(member * (parameter object *))" and t = "snk" and result = 0.2500000000 or
     repr = "(return (parameter 0 (member filter *)))" and t = "snk" and result = 0.5000000000 or
     repr = "(member * (parameter 0 (member defineProperty *)))" and t = "snk" and result = 0.2500000000 or
     repr = "(return (member on *))" and t = "snk" and result = 0.2500000000 or
     repr = "(member * (member formData *))" and t = "snk" and result = 0.2500000000 or
     repr = "(return (member delete *))" and t = "snk" and result = 0.2500000000 or
     repr = "(parameter 0 (parameter predicate *))" and t = "snk" and result = 0.2500000000 or
     repr = "(return (member * (instance (member exports *))))" and t = "snk" and result = 0.2500000000 or
     repr = "(parameter 0 (member createHmac *))" and t = "snk" and result = 0.2500000000 or
     repr = "(parameter 1 (member indexOf *))" and t = "snk" and result = 0.2500000000 or
     repr = "(return (member end *))" and t = "snk" and result = 0.2500000000 or
     repr = "(return (parameter 2 (member chmod *)))" and t = "snk" and result = 0.2500000000 or
     repr = "(parameter 1 (member stringify *))" and t = "snk" and result = 0.2500000000 or
     repr = "(parameter 0 (member splice *))" and t = "snk" and result = 0.2500000000 or
     repr = "(member abi *)" and t = "snk" and result = 0.2500000000 or
     repr = "(member code (parameter 0 (member json *)))" and t = "snk" and result = 0.5000000000 or
     repr = "(member user (instance (member exports *)))" and t = "snk" and result = 0.0357142857 or
     repr = "(member scrambleBuff (instance (member exports *)))" and t = "snk" and result = 0.0357142857 or
     repr = "(parameter 2 (member call *))" and t = "snk" and result = 0.0357142857 or
     repr = "(member database (instance (member exports *)))" and t = "snk" and result = 0.0357142857 or
     repr = "(parameter 2 (member forEach *))" and t = "snk" and result = 0.1428571429 or
     repr = "(member * (instance (member element *)))" and t = "snk" and result = 0.2500000000 or
     repr = "(member clientFlags (instance (member exports *)))" and t = "snk" and result = 0.0357142857 or
     repr = "(member protocol41 (instance (member exports *)))" and t = "snk" and result = 0.0357142857 or
     repr = "(member charsetNumber (instance (member exports *)))" and t = "snk" and result = 0.0357142857 or
     repr = "(member maxPacketSize (instance (member exports *)))" and t = "snk" and result = 0.0357142857 or
     repr = "(parameter 0 (member resolve *))" and t = "snk" and result = 0.1250000000 or
     repr = "(parameter 1 (member join *))" and t = "snk" and result = 0.1250000000 or
     repr = "(parameter 2 (member send *))" and t = "snk" and result = 0.1500000000 or
     repr = "(member templateUrl (parameter 1 (member component *)))" and t = "snk" and result = 1.0000000000 or
     repr = "(parameter 0 (return (member promisify *)))" and t = "snk" and result = 0.7500000000 or
     repr = "(return (member getIndex *))" and t = "snk" and result = 0.2500000000 or
     repr = "(return (member postPrintForm *))" and t = "snk" and result = 0.5000000000 or
     repr = "(parameter 1 (member slice *))" and t = "snk" and result = 0.7500000000 or
     repr = "(member query (parameter 0 (member format *)))" and t = "snk" and result = 0.2500000000 or
     repr = "(return (parameter 1 (member addGlobal *)))" and t = "snk" and result = 0.2500000000 or
     repr = "(parameter 0 (member addGlobal *))" and t = "snk" and result = 0.2500000000 or
     repr = "(parameter 1 (member spawn *))" and t = "snk" and result = 0.2500000000 or
     repr = "(member * (member _id *))" and t = "snk" and result = 0.2500000000 or
     repr = "(parameter 0 (member deleteOne *))" and t = "snk" and result = 0.2500000000 or
     repr = "(parameter 0 (member isBetween *))" and t = "snk" and result = 0.1250000000 or
     repr = "(parameter 1 (member isBetween *))" and t = "snk" and result = 0.1250000000 or
     repr = "(parameter 0 (member updateOne *))" and t = "snk" and result = 0.2500000000 or
     repr = "(parameter 1 (return (member promisify *)))" and t = "snk" and result = 0.2500000000 or
     repr = "(parameter 0 (member insertOne *))" and t = "snk" and result = 0.2500000000 or
     repr = "(member _id (parameter 0 (member remove *)))" and t = "snk" and result = 0.1250000000 or
     repr = "(member errors (parameter 0 (member json *)))" and t = "snk" and result = 0.5000000000 or
     repr = "(parameter 2 (member equal *))" and t = "snk" and result = 0.1500000000 or
     repr = "(parameter 1 (root https://www.npmjs.com/package/assert))" and t = "snk" and result = 0.1500000000 or
     repr = "(member id (parameter 0 (member send *)))" and t = "snk" and result = 0.5000000000 or
     repr = "(return (parameter 1 (member readdir *)))" and t = "snk" and result = 0.2083333333 or
     repr = "(return (parameter 1 (member delete *)))" and t = "snk" and result = 0.1666666667 or
     repr = "(return (parameter 2 (member put *)))" and t = "snk" and result = 0.3333333333 or
     repr = "(member page (parameter 0 (member send *)))" and t = "snk" and result = 0.1250000000 or
     repr = "(parameter 1 (member redirect *))" and t = "snk" and result = 0.5000000000 or
     repr = "(return (parameter 0 (member initializeProject *)))" and t = "snk" and result = 0.5000000000 or
     repr = "(return (parameter 1 (member auto *)))" and t = "snk" and result = 0.2500000000 or
     repr = "(return (member getDocument *))" and t = "snk" and result = 0.2500000000 or
     repr = "(member text (member message *))" and t = "snk" and result = 0.2500000000 or
     repr = "(return (member getProject *))" and t = "snk" and result = 0.2500000000 or
     repr = "(return (member getDoc *))" and t = "snk" and result = 0.5000000000 or
     repr = "(member id (parameter 0 (member json *)))" and t = "snk" and result = 0.2500000000 or
     repr = "(parameter 1 (return (member once *)))" and t = "snk" and result = 0.2500000000 or
     repr = "(return (parameter 1 (member series *)))" and t = "snk" and result = 0.5000000000 or
     repr = "(return (member getAllDocs *))" and t = "snk" and result = 0.5000000000 or
     repr = "(member body (parameter 0 (member apiRequest *)))" and t = "snk" and result = 0.2500000000 or
     repr = "(return (member user *))" and t = "snk" and result = 0.2500000000 or
     repr = "(return (member setCompiler *))" and t = "snk" and result = 0.7500000000 or
     repr = "(return (member add *))" and t = "snk" and result = 0.2500000000 or
     repr = "(member data (return (member queryResultToJson *)))" and t = "snk" and result = 0.2500000000 or
     repr = "(parameter 0 (member download *))" and t = "snk" and result = 0.2500000000 or
     repr = "(return (return (member exports *)))" and t = "snk" and result = 0.2500000000 or
     repr = "(parameter 1 (member json *))" and t = "snk" and result = 0.2500000000 or
     repr = "(return (parameter 2 (member findOneAndUpdate *)))" and t = "snk" and result = 0.5000000000 or
     repr = "(return (parameter 0 (member getCurrent *)))" and t = "snk" and result = 0.5000000000 or
     repr = "(return (parameter 0 (member save *)))" and t = "snk" and result = 0.3750000000 or
     repr = "(parameter 0 (member query *))" and t = "snk" and result = 0.5000000000 or
     repr = "(parameter 0 (member escapeSqlStr *))" and t = "snk" and result = 0.7500000000 or
     repr = "(member statusCode (parameter 0 (member pipe *)))" and t = "snk" and result = 0.7500000000 or
     repr = "(parameter 0 (member URL *))" and t = "snk" and result = 0.2500000000 or
     repr = "(member username (parameter 0 (member insert *)))" and t = "snk" and result = 0.7500000000 or
     repr = "(parameter 0 (member insert *))" and t = "snk" and result = 0.5000000000 or
     repr = "(return (parameter 0 (member use *)))" and t = "snk" and result = 0.2500000000 or
     repr = "(parameter 1 (member ls *))" and t = "snk" and result = 1.0000000000 or
     repr = "(member message *)" and t = "snk" and result = 0.5000000000 or
     repr = "(return (parameter 1 (member findOne *)))" and t = "snk" and result = 0.2500000000 or
     repr = "(return (parameter 2 (member update *)))" and t = "snk" and result = 0.2500000000 or
     repr = "(parameter 0 (member jsonp *))" and t = "snk" and result = 0.2500000000 or
     repr = "(return (member createUser *))" and t = "snk" and result = 0.2500000000 or
     repr = "(return (member updateUser *))" and t = "snk" and result = 0.2500000000 or
     repr = "(parameter 0 (member emit *))" and t = "snk" and result = 0.5000000000 or
     repr = "(member room_id (parameter 1 (member emit *)))" and t = "snk" and result = 0.5000000000 or
     repr = "(parameter 1 (member move *))" and t = "snk" and result = 0.2500000000 or
     repr = "(member userGroup (parameter 0 (member apiv3 *)))" and t = "snk" and result = 0.2500000000 or
     repr = "(parameter 0 (member apiv3 *))" and t = "snk" and result = 0.5000000000 or
     repr = "(parameter 0 (member puts *))" and t = "snk" and result = 0.2500000000 or
     repr = "(member data (parameter 1 (member emit *)))" and t = "snk" and result = 0.5000000000
     } 
  }
  