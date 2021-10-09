module TsmRepr {
  float getReprScore(string repr, string t){
   repr = "(member * (member _id *))" and t = "snk" and result = 0.0833333330 or
   repr = "(member * (parameter 0 (member count *)))" and t = "snk" and result = 0.0833333330 or
   repr = "(member * (parameter 1 (member updateOne *)))" and t = "snk" and result = 0.0384615380 or
   repr = "(member * (parameter 1 (member writeHead *)))" and t = "snk" and result = 0.1741071427 or
   repr = "(member Content-Length (member headers *))" and t = "snk" and result = 0.2500000000 or
   repr = "(member _id (parameter 0 (member updateOne *)))" and t = "snk" and result = 0.0384615380 or
   repr = "(member _id (parameter 1 (member dbQuery *)))" and t = "snk" and result = 0.0833333330 or
   repr = "(member _parsedUrl (parameter req (member default *)))" and t = "snk" and result = 0.0555555560 or
   repr = "(member _raw (member _parsedUrl *))" and t = "snk" and result = 0.0555555560 or
   repr = "(member account (parameter 1 (member updateAuth *)))" and t = "snk" and result = 0.0384615380 or
   repr = "(member article (parameter 1 (member render *)))" and t = "snk" and result = 0.2500000000 or
   repr = "(member assertion (member form *))" and t = "snk" and result = 0.2500000000 or
   repr = "(member body (parameter 0 (member post *)))" and t = "snk" and result = 0.5000000000 or
   repr = "(member buffer (instance (member exports *)))" and t = "snk" and result = 0.2500000000 or
   repr = "(member cancel_path (parameter 1 (member render *)))" and t = "snk" and result = 0.2500000000 or
   repr = "(member content (member data *))" and t = "snk" and result = 0.2500000000 or
   repr = "(member country (member origin *))" and t = "snk" and result = 0.0705128210 or
   repr = "(member current (parameter 1 (member render *)))" and t = "snk" and result = 0.5000000000 or
   repr = "(member data (parameter 0 (member json *)))" and t = "snk" and result = 0.5000000000 or
   repr = "(member data (parameter 0 (member send *)))" and t = "snk" and result = 0.2500000000 or
   repr = "(member emails (parameter 1 (member assignAuth *)))" and t = "snk" and result = 0.0384615380 or
   repr = "(member emails (parameter 1 (member updateOne *)))" and t = "snk" and result = 0.0384615380 or
   repr = "(member end (parameter 1 (member createReadStream *)))" and t = "snk" and result = 0.0825892855 or
   repr = "(member error (instance (member IncomingForm *)))" and t = "snk" and result = 0.5000000000 or
   repr = "(member errors (parameter 0 (member json *)))" and t = "snk" and result = 0.5000000000 or
   repr = "(member fileDir (parameter 0 (member sendFile *)))" and t = "snk" and result = 0.0394736840 or
   repr = "(member foreign (parameter 1 (member render *)))" and t = "snk" and result = 0.5000000000 or
   repr = "(member form (parameter 0 (root https://www.npmjs.com/package/request)))" and t = "snk" and result = 0.2500000000 or
   repr = "(member hash (parameter 0 (member jsonp *)))" and t = "snk" and result = 0.2500000000 or
   repr = "(member host (parameter 0 (member request *)))" and t = "snk" and result = 0.1250000000 or
   repr = "(member hour (parameter 0 (root https://www.npmjs.com/package/moment)))" and t = "snk" and result = 0.2500000000 or
   repr = "(member href (instance (member Url *)))" and t = "snk" and result = 0.0555555560 or
   repr = "(member index (return (parameter 0 (member map *))))" and t = "snk" and result = 0.2500000000 or
   repr = "(member ip (member origin *))" and t = "snk" and result = 0.0705128210 or
   repr = "(member ip (parameter cn *))" and t = "snk" and result = 0.2500000000 or
   repr = "(member kb_keywords (parameter 0 (member add *)))" and t = "snk" and result = 0.1250000000 or
   repr = "(member lastBrowserId (parameter 1 (member assignAuth *)))" and t = "snk" and result = 0.0384615380 or
   repr = "(member lastBrowserId (parameter 1 (member updateOne *)))" and t = "snk" and result = 0.0384615380 or
   repr = "(member lastUserAgent (parameter 1 (member assignAuth *)))" and t = "snk" and result = 0.0384615380 or
   repr = "(member lastUserAgent (parameter 1 (member updateOne *)))" and t = "snk" and result = 0.0384615380 or
   repr = "(member lastVisit (parameter 1 (member updateOne *)))" and t = "snk" and result = 0.0384615380 or
   repr = "(member level (instance (member Logger *)))" and t = "snk" and result = 0.0357142860 or
   repr = "(member level *)" and t = "snk" and result = 0.0357142860 or
   repr = "(member message (parameter 0 (member json *)))" and t = "snk" and result = 0.1250000000 or
   repr = "(member message (parameter 0 (member send *)))" and t = "snk" and result = 0.0625000000 or
   repr = "(member messages (parameter 1 (member render *)))" and t = "snk" and result = 0.2000000000 or
   repr = "(member minutes (parameter 0 (root https://www.npmjs.com/package/moment)))" and t = "snk" and result = 0.2500000000 or
   repr = "(member name (parameter 1 (member assignAuth *)))" and t = "snk" and result = 0.0384615380 or
   repr = "(member name (parameter 1 (member updateOne *)))" and t = "snk" and result = 0.0384615380 or
   repr = "(member ok (parameter 0 (member json *)))" and t = "snk" and result = 0.2500000000 or
   repr = "(member origin (parameter 0 (member create *)))" and t = "snk" and result = 0.0705128210 or
   repr = "(member origin (parameter 0 (member findOne *)))" and t = "snk" and result = 0.0705128210 or
   repr = "(member origins (member $push *))" and t = "snk" and result = 0.0384615380 or
   repr = "(member params (parameter req (member lookup *)))" and t = "snk" and result = 0.1250000000 or
   repr = "(member path (instance (member Url *)))" and t = "snk" and result = 0.0555555560 or
   repr = "(member path (parameter 0 (member request *)))" and t = "snk" and result = 0.1250000000 or
   repr = "(member pathname (instance (member Url *)))" and t = "snk" and result = 0.0555555560 or
   repr = "(member pathname (parameter 0 (member format *)))" and t = "snk" and result = 0.2142857150 or
   repr = "(member position (return (parameter 0 (member map *))))" and t = "snk" and result = 0.2500000000 or
   repr = "(member query (instance (member Url *)))" and t = "snk" and result = 0.0555555560 or
   repr = "(member receivedlength (parameter 1 (member writeHead *)))" and t = "snk" and result = 0.5000000000 or
   repr = "(member result (parameter 1 (member render *)))" and t = "snk" and result = 0.2500000000 or
   repr = "(member saved_path (parameter 0 (member send *)))" and t = "snk" and result = 0.2500000000 or
   repr = "(member schedule (parameter 1 (member render *)))" and t = "snk" and result = 0.5000000000 or
   repr = "(member search (instance (member Url *)))" and t = "snk" and result = 0.0555555560 or
   repr = "(member secret (parameter 0 (member json *)))" and t = "snk" and result = 0.0625000000 or
   repr = "(member start (parameter 1 (member createReadStream *)))" and t = "snk" and result = 0.0714285710 or
   repr = "(member templateUrl (parameter 1 (member component *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member templateUrl (return (parameter 1 (member directive *))))" and t = "snk" and result = 1.0000000000 or
   repr = "(member templateUrl *)" and t = "snk" and result = 1.0000000000 or
   repr = "(member text (member body *))" and t = "snk" and result = 0.2500000000 or
   repr = "(member url (parameter 0 (member jsonp *)))" and t = "snk" and result = 0.2500000000 or
   repr = "(member url (parameter 0 (member send *)))" and t = "snk" and result = 0.2500000000 or
   repr = "(member values (parameter 0 (member cx *)))" and t = "snk" and result = 0.5000000000 or
   repr = "(member video_name (parameter 0 (member send *)))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 0 (member * (parameter res *)))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 0 (member URL *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 0 (member __non_webpack_require__ (global)))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member _error *))" and t = "snk" and result = 0.5000000000 or
   repr = "(parameter 0 (member _log *))" and t = "snk" and result = 0.0357142860 or
   repr = "(parameter 0 (member access *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member accessSync *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member add *))" and t = "snk" and result = 0.1250000000 or
   repr = "(parameter 0 (member appendFile *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member appendFileSync *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member call *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 0 (member cat *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member cd *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member chmod *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member chmodSync *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member chown *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member chownSync *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member create *))" and t = "snk" and result = 0.0705128210 or
   repr = "(parameter 0 (member createReadStream *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member createWriteStream *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member deepStrictEqual *))" and t = "snk" and result = 0.7500000000 or
   repr = "(parameter 0 (member define (global)))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member eachSeries *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 0 (member end *))" and t = "snk" and result = 0.3354591836 or
   repr = "(parameter 0 (member endsWith *))" and t = "snk" and result = 0.4166666700 or
   repr = "(parameter 0 (member equal *))" and t = "snk" and result = 0.0357142860 or
   repr = "(parameter 0 (member exec *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 0 (member exists *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member existsSync *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member exit *))" and t = "snk" and result = 0.7500000000 or
   repr = "(parameter 0 (member find *))" and t = "snk" and result = 0.0833333330 or
   repr = "(parameter 0 (member findOne *))" and t = "snk" and result = 0.0769230770 or
   repr = "(parameter 0 (member get *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 0 (member indexOf *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 0 (member insert *))" and t = "snk" and result = 0.5000000000 or
   repr = "(parameter 0 (member isLessThanOrEqualTo *))" and t = "snk" and result = 0.0357142860 or
   repr = "(parameter 0 (member isLevelEnabled *))" and t = "snk" and result = 0.0357142860 or
   repr = "(parameter 0 (member json *))" and t = "snk" and result = 0.4375000000 or
   repr = "(parameter 0 (member jsonp *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 0 (member lchmod *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member lchmodSync *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member lchown *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member link *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member linkSync *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member log *))" and t = "snk" and result = 0.0357142860 or
   repr = "(parameter 0 (member ls *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member lstat *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member lstatSync *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member mkdir *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member mkdirSync *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member mv *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 0 (member nextTick *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 0 (member ok *))" and t = "snk" and result = 0.5833333333 or
   repr = "(parameter 0 (member open *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member openSync *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member pathExists *))" and t = "snk" and result = 0.0394736840 or
   repr = "(parameter 0 (member pipe *))" and t = "snk" and result = 0.2916666667 or
   repr = "(parameter 0 (member post *))" and t = "snk" and result = 0.5000000000 or
   repr = "(parameter 0 (member push *))" and t = "snk" and result = 0.3333333333 or
   repr = "(parameter 0 (member puts *))" and t = "snk" and result = 0.1785714300 or
   repr = "(parameter 0 (member readFile *))" and t = "snk" and result = 0.9811661507 or
   repr = "(parameter 0 (member readFileSync *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member readSync *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 0 (member readdir *))" and t = "snk" and result = 0.9494459834 or
   repr = "(parameter 0 (member readdirSync *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member readlink *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member readlinkSync *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member realpath *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member redirect *))" and t = "snk" and result = 0.3928571429 or
   repr = "(parameter 0 (member rename *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member renameSync *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member render *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member replace *))" and t = "snk" and result = 0.1447368420 or
   repr = "(parameter 0 (member request *))" and t = "snk" and result = 0.1875000000 or
   repr = "(parameter 0 (member require (global)))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member rm *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member rmdir *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member rmdirSync *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member send *))" and t = "snk" and result = 0.3541666667 or
   repr = "(parameter 0 (member splice *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 0 (member stat *))" and t = "snk" and result = 0.9605263158 or
   repr = "(parameter 0 (member statSync *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member symlink *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member symlinkSync *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member sync *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member touch *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member truncate *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member truncateSync *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member unlink *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member unlinkSync *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member unwatchFile *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member update *))" and t = "snk" and result = 0.0714285710 or
   repr = "(parameter 0 (member updateOne *))" and t = "snk" and result = 0.0384615380 or
   repr = "(parameter 0 (member use *))" and t = "snk" and result = 0.7500000000 or
   repr = "(parameter 0 (member utimes *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member utimesSync *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member watch *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member watchFile *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member write *))" and t = "snk" and result = 0.4000000000 or
   repr = "(parameter 0 (member writeFile *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member writeFileSync *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (parameter B *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (return (member hijack *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (return (root https://www.npmjs.com/package/esm)))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (root https://www.npmjs.com/package/assert))" and t = "snk" and result = 0.5000000000 or
   repr = "(parameter 0 (root https://www.npmjs.com/package/moment))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 0 (root https://www.npmjs.com/package/request))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 1 (member append *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 1 (member appendFileSync *))" and t = "snk" and result = 0.7500000000 or
   repr = "(parameter 1 (member createReadStream *))" and t = "snk" and result = 0.0714285710 or
   repr = "(parameter 1 (member define (global)))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 1 (member emit *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 1 (member equal *))" and t = "snk" and result = 0.1428571430 or
   repr = "(parameter 1 (member execSync *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 1 (member json *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 1 (member jsonp *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 1 (member link *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 1 (member linkSync *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 1 (member noop *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 1 (member onField *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 1 (member rename *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 1 (member renameSync *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 1 (member render *))" and t = "snk" and result = 0.3363636364 or
   repr = "(parameter 1 (member rm *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 1 (member set *))" and t = "snk" and result = 0.1250000000 or
   repr = "(parameter 1 (member setHeader *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 1 (member spawn *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 1 (member symlink *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 1 (member symlinkSync *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 1 (member updateOne *))" and t = "snk" and result = 0.0384615380 or
   repr = "(parameter 1 (member writeFileAsync *))" and t = "snk" and result = 0.7500000000 or
   repr = "(parameter 1 (member writeFileSync *))" and t = "snk" and result = 0.4375000000 or
   repr = "(parameter 1 (member writeHead *))" and t = "snk" and result = 0.2440476190 or
   repr = "(parameter 2 (member emit *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 2 (member equal *))" and t = "snk" and result = 0.0357142860 or
   repr = "(parameter 2 (member handler *))" and t = "snk" and result = 0.1250000000 or
   repr = "(parameter 3 (member handler *))" and t = "snk" and result = 0.1250000000 or
   repr = "(return (member * (instance (member Logger *))))" and t = "snk" and result = 0.0357142860 or
   repr = "(return (member byteLength *))" and t = "snk" and result = 0.2500000000 or
   repr = "(return (member decode *))" and t = "snk" and result = 0.2500000000 or
   repr = "(return (member exports *))" and t = "snk" and result = 0.0555555560 or
   repr = "(return (member isFresh *))" and t = "snk" and result = 0.2500000000 or
   repr = "(return (member isLevelEnabled *))" and t = "snk" and result = 0.0357142860 or
   repr = "(return (member isPreconditionFailure *))" and t = "snk" and result = 0.2500000000 or
   repr = "(return (member location *))" and t = "snk" and result = 0.1250000000 or
   repr = "(return (member response *))" and t = "snk" and result = 0.2500000000 or
   repr = "(return (member send *))" and t = "snk" and result = 0.2500000000 or
   repr = "(return (member write *))" and t = "snk" and result = 0.2500000000 or
   repr = "(return (parameter 0 (member createServer *)))" and t = "snk" and result = 0.7500000000 or
   repr = "(return (parameter 1 (member exists *)))" and t = "snk" and result = 0.2500000000 or
   repr = "(return (parameter 1 (member get *)))" and t = "snk" and result = 0.5000000000 or
   repr = "(return (parameter 1 (member on *)))" and t = "snk" and result = 0.2500000000 or
   repr = "(return (parameter 1 (member post *)))" and t = "snk" and result = 0.3750000000 or
   repr = "(return (parameter 1 (member readdir *)))" and t = "snk" and result = 0.2500000000 or
   repr = "(return (parameter 1 (member stat *)))" and t = "snk" and result = 0.2500000000 or
   repr = "(return (parameter 4 (member process_params *)))" and t = "snk" and result = 0.2500000000 or
   repr = "(return (return (member compileQueryParser *)))" and t = "snk" and result = 0.0555555560 or
   repr = "(return (return (member exports *)))" and t = "snk" and result = 0.2500000000 or
   repr = "(return (return (member getMiddleware *)))" and t = "snk" and result = 0.2500000000
   } 
}
