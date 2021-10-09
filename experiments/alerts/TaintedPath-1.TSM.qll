module TsmRepr {
  float getReprScore(string repr, string t){
   repr = "(member * (parameter 0 (member Proxy (global))))" and t = "snk" and result = 0.7500000000 or
   repr = "(member * (parameter 1 (member updateOne *)))" and t = "snk" and result = 0.0384615380 or
   repr = "(member * (parameter 1 (member writeHead *)))" and t = "snk" and result = 0.2738095237 or
   repr = "(member * (parameter obj (member exports *)))" and t = "snk" and result = 0.2500000000 or
   repr = "(member _id (parameter 0 (member updateOne *)))" and t = "snk" and result = 0.0384615380 or
   repr = "(member access (parameter 0 (member findOne *)))" and t = "snk" and result = 0.1666666700 or
   repr = "(member access (parameter 0 (member push *)))" and t = "snk" and result = 0.1666666700 or
   repr = "(member account (parameter 1 (member updateAuth *)))" and t = "snk" and result = 0.0384615380 or
   repr = "(member article (parameter 1 (member render *)))" and t = "snk" and result = 0.2500000000 or
   repr = "(member assertion (member form *))" and t = "snk" and result = 0.2500000000 or
   repr = "(member canShare (member userDocument *))" and t = "snk" and result = 0.1250000000 or
   repr = "(member code *)" and t = "snk" and result = 0.2500000000 or
   repr = "(member codeAndDescription (return (member getEventHtml *)))" and t = "snk" and result = 0.2500000000 or
   repr = "(member config (member module *))" and t = "snk" and result = 0.0080645161 or
   repr = "(member content (member data *))" and t = "snk" and result = 0.2500000000 or
   repr = "(member content (parameter 1 (member emit *)))" and t = "snk" and result = 0.5000000000 or
   repr = "(member country (member origin *))" and t = "snk" and result = 0.0705128210 or
   repr = "(member credit (member module *))" and t = "snk" and result = 0.0080645161 or
   repr = "(member data (parameter 0 (member Package *)))" and t = "snk" and result = 0.2500000000 or
   repr = "(member data (parameter 0 (member send *)))" and t = "snk" and result = 0.2500000000 or
   repr = "(member emails (parameter 1 (member assignAuth *)))" and t = "snk" and result = 0.0384615380 or
   repr = "(member emails (parameter 1 (member updateOne *)))" and t = "snk" and result = 0.0384615380 or
   repr = "(member end (parameter 1 (member createReadStream *)))" and t = "snk" and result = 0.0714285710 or
   repr = "(member foreign (parameter 1 (member render *)))" and t = "snk" and result = 0.5000000000 or
   repr = "(member form (parameter 0 (root https://www.npmjs.com/package/request)))" and t = "snk" and result = 0.2500000000 or
   repr = "(member formdatas (parameter 1 (member render *)))" and t = "snk" and result = 0.2500000000 or
   repr = "(member gas (parameter 1 (member invokeCallbackUrl *)))" and t = "snk" and result = 0.0192307690 or
   repr = "(member headers (parameter 0 (member request *)))" and t = "snk" and result = 0.5000000000 or
   repr = "(member hour (parameter 0 (root https://www.npmjs.com/package/moment)))" and t = "snk" and result = 0.2500000000 or
   repr = "(member id (parameter 0 (member push *)))" and t = "snk" and result = 0.1666666700 or
   repr = "(member id (parameter 0 (member send *)))" and t = "snk" and result = 0.2500000000 or
   repr = "(member id (parameter 1 (member emit *)))" and t = "snk" and result = 0.0080645161 or
   repr = "(member ip (member origin *))" and t = "snk" and result = 0.0705128210 or
   repr = "(member ip (parameter cn *))" and t = "snk" and result = 0.2500000000 or
   repr = "(member json (parameter 0 (member post *)))" and t = "snk" and result = 0.0192307690 or
   repr = "(member lastBrowserId (parameter 1 (member assignAuth *)))" and t = "snk" and result = 0.0384615380 or
   repr = "(member lastBrowserId (parameter 1 (member updateOne *)))" and t = "snk" and result = 0.0384615380 or
   repr = "(member lastUserAgent (parameter 1 (member assignAuth *)))" and t = "snk" and result = 0.0384615380 or
   repr = "(member lastUserAgent (parameter 1 (member updateOne *)))" and t = "snk" and result = 0.0384615380 or
   repr = "(member lastVisit (parameter 1 (member updateOne *)))" and t = "snk" and result = 0.0384615380 or
   repr = "(member log (parameter 0 (member AdminLog *)))" and t = "snk" and result = 0.5000000000 or
   repr = "(member message *)" and t = "snk" and result = 0.5000000000 or
   repr = "(member messages (parameter 1 (member render *)))" and t = "snk" and result = 0.2000000000 or
   repr = "(member minutes (parameter 0 (root https://www.npmjs.com/package/moment)))" and t = "snk" and result = 0.2500000000 or
   repr = "(member module (parameter 1 (member emit *)))" and t = "snk" and result = 0.0080645161 or
   repr = "(member name (member module *))" and t = "snk" and result = 0.0080645161 or
   repr = "(member name (parameter 1 (member assignAuth *)))" and t = "snk" and result = 0.0384615380 or
   repr = "(member name (parameter 1 (member updateOne *)))" and t = "snk" and result = 0.0384615380 or
   repr = "(member newDocument (parameter 0 (member json *)))" and t = "snk" and result = 0.1666666700 or
   repr = "(member newFileId (parameter 0 (member send *)))" and t = "snk" and result = 0.5000000000 or
   repr = "(member origin (parameter 0 (member create *)))" and t = "snk" and result = 0.0705128210 or
   repr = "(member origin (parameter 0 (member findOne *)))" and t = "snk" and result = 0.0705128210 or
   repr = "(member origins (member $push *))" and t = "snk" and result = 0.0384615380 or
   repr = "(member path (member module *))" and t = "snk" and result = 0.0080645161 or
   repr = "(member path (parameter 0 (member request *)))" and t = "snk" and result = 0.2500000000 or
   repr = "(member query (parameter 0 (member format *)))" and t = "snk" and result = 0.2500000000 or
   repr = "(member readAccess (member userDocument *))" and t = "snk" and result = 0.1250000000 or
   repr = "(member result (parameter 1 (member render *)))" and t = "snk" and result = 0.1666666665 or
   repr = "(member script (parameter 0 (member json *)))" and t = "snk" and result = 0.0833333330 or
   repr = "(member start (parameter 1 (member createReadStream *)))" and t = "snk" and result = 0.0714285710 or
   repr = "(member templateUrl (parameter 1 (member component *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member templateUrl (return (parameter 1 (member directive *))))" and t = "snk" and result = 1.0000000000 or
   repr = "(member templateUrl *)" and t = "snk" and result = 1.0000000000 or
   repr = "(member text (member body *))" and t = "snk" and result = 0.2500000000 or
   repr = "(member time (parameter 1 (member emit *)))" and t = "snk" and result = 0.0080645161 or
   repr = "(member url (parameter 0 (member send *)))" and t = "snk" and result = 0.2500000000 or
   repr = "(member userDocument (parameter 1 (member render *)))" and t = "snk" and result = 0.1250000000 or
   repr = "(member value *)" and t = "snk" and result = 0.2500000000 or
   repr = "(member values (parameter 0 (member cx *)))" and t = "snk" and result = 0.5000000000 or
   repr = "(member writeAccess (member userDocument *))" and t = "snk" and result = 0.1250000000 or
   repr = "(member x *)" and t = "snk" and result = 0.2500000000 or
   repr = "(member y *)" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 0 (member AdminLog *))" and t = "snk" and result = 0.5000000000 or
   repr = "(parameter 0 (member URL *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 0 (member __non_webpack_require__ (global)))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member access *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member accessSync *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member appendFile *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member appendFileSync *))" and t = "snk" and result = 0.5416666665 or
   repr = "(parameter 0 (member cat *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member chmod *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member chmodSync *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member chown *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member chownSync *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member copy *))" and t = "snk" and result = 0.1666666700 or
   repr = "(parameter 0 (member create *))" and t = "snk" and result = 0.0705128210 or
   repr = "(parameter 0 (member createReadStream *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member createWriteStream *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member define (global)))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member emit *))" and t = "snk" and result = 0.1785714300 or
   repr = "(parameter 0 (member end *))" and t = "snk" and result = 0.3323412700 or
   repr = "(parameter 0 (member eslRequire (global)))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member exec *))" and t = "snk" and result = 0.2083333350 or
   repr = "(parameter 0 (member exists *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member existsSync *))" and t = "snk" and result = 0.9791666667 or
   repr = "(parameter 0 (member exit *))" and t = "snk" and result = 0.7500000000 or
   repr = "(parameter 0 (member find *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 0 (member findOne *))" and t = "snk" and result = 0.1185897455 or
   repr = "(parameter 0 (member get *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 0 (member indexOf *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 0 (member json *))" and t = "snk" and result = 0.4471153854 or
   repr = "(parameter 0 (member jsonp *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 0 (member lchmod *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member lchown *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member link *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member ls *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member lstat *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member lstatSync *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member map *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 0 (member mkdir *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member mkdirSync *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member notStrictEqual *))" and t = "snk" and result = 0.0833333330 or
   repr = "(parameter 0 (member open *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member openSync *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member pipe *))" and t = "snk" and result = 0.2916666667 or
   repr = "(parameter 0 (member post *))" and t = "snk" and result = 0.0192307690 or
   repr = "(parameter 0 (member push *))" and t = "snk" and result = 0.2916666675 or
   repr = "(parameter 0 (member readFile *))" and t = "snk" and result = 0.9839743590 or
   repr = "(parameter 0 (member readFileSync *))" and t = "snk" and result = 0.9863184080 or
   repr = "(parameter 0 (member readSync *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 0 (member readdir *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member readdirSync *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member readlink *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member readlinkSync *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member realpath *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member redirect *))" and t = "snk" and result = 0.3928571429 or
   repr = "(parameter 0 (member removeSync *))" and t = "snk" and result = 0.0833333330 or
   repr = "(parameter 0 (member rename *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member renameSync *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member render *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member replace *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 0 (member require (global)))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member rm *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member rmdir *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member rmdirSync *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member send *))" and t = "snk" and result = 0.2968253967 or
   repr = "(parameter 0 (member sendFile *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 0 (member stat *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member statSync *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member static *))" and t = "snk" and result = 0.0080645161 or
   repr = "(parameter 0 (member strictEqual *))" and t = "snk" and result = 0.0833333330 or
   repr = "(parameter 0 (member symlink *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member symlinkSync *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member to *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 0 (member unlink *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member unlinkSync *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member unwatchFile *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member update *))" and t = "snk" and result = 0.7500000000 or
   repr = "(parameter 0 (member updateOne *))" and t = "snk" and result = 0.0384615380 or
   repr = "(parameter 0 (member use *))" and t = "snk" and result = 0.7500000000 or
   repr = "(parameter 0 (member utimes *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member utimesSync *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member watch *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member watchFile *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member write *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 0 (member writeFile *))" and t = "snk" and result = 0.9739583334 or
   repr = "(parameter 0 (member writeFileSync *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (return (root https://www.npmjs.com/package/esm)))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (root https://www.npmjs.com/package/moment))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 0 (root https://www.npmjs.com/package/request))" and t = "snk" and result = 0.3750000000 or
   repr = "(parameter 1 (member appendFileSync *))" and t = "snk" and result = 0.7500000000 or
   repr = "(parameter 1 (member createReadStream *))" and t = "snk" and result = 0.0714285710 or
   repr = "(parameter 1 (member deepEqual *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 1 (member define (global)))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 1 (member emit *))" and t = "snk" and result = 0.2738095250 or
   repr = "(parameter 1 (member execSync *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 1 (member link *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 1 (member noop *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 1 (member rename *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 1 (member renameSync *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 1 (member render *))" and t = "snk" and result = 0.2938888893 or
   repr = "(parameter 1 (member rm *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 1 (member setHeader *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 1 (member slice *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 1 (member spawn *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 1 (member strictEqual *))" and t = "snk" and result = 0.0833333330 or
   repr = "(parameter 1 (member symlink *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 1 (member symlinkSync *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 1 (member updateOne *))" and t = "snk" and result = 0.0384615380 or
   repr = "(parameter 1 (member writeFile *))" and t = "snk" and result = 0.4444444443 or
   repr = "(parameter 1 (member writeFileAsync *))" and t = "snk" and result = 0.7500000000 or
   repr = "(parameter 1 (member writeFileSync *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 1 (member writeHead *))" and t = "snk" and result = 0.2619047618 or
   repr = "(parameter 1 (parameter cb (member registered *)))" and t = "snk" and result = 0.2500000000 or
   repr = "(return (member createProject *))" and t = "snk" and result = 0.5000000000 or
   repr = "(return (member getIndex *))" and t = "snk" and result = 0.4166666700 or
   repr = "(return (member getSuggestions *))" and t = "snk" and result = 0.2500000000 or
   repr = "(return (member postPrintForm *))" and t = "snk" and result = 0.5000000000 or
   repr = "(return (member postSearchForm *))" and t = "snk" and result = 0.4166666700 or
   repr = "(return (member updateProject *))" and t = "snk" and result = 0.5000000000 or
   repr = "(return (parameter 0 (member createServer *)))" and t = "snk" and result = 0.7500000000 or
   repr = "(return (parameter 0 (member save *)))" and t = "snk" and result = 0.5000000000 or
   repr = "(return (parameter 1 (member exists *)))" and t = "snk" and result = 0.2500000000 or
   repr = "(return (parameter 1 (member findOne *)))" and t = "snk" and result = 0.5000000000 or
   repr = "(return (parameter 1 (member get *)))" and t = "snk" and result = 0.3125000000 or
   repr = "(return (parameter 1 (member on *)))" and t = "snk" and result = 0.2500000000 or
   repr = "(return (parameter 1 (member post *)))" and t = "snk" and result = 0.5000000000 or
   repr = "(return (parameter 1 (member stat *)))" and t = "snk" and result = 0.2500000000 or
   repr = "(return (parameter 2 (member update *)))" and t = "snk" and result = 0.5000000000 or
   repr = "(return (parameter 2 (member writeFile *)))" and t = "snk" and result = 0.2500000000
   } 
}
