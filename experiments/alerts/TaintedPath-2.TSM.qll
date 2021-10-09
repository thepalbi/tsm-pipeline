module TsmRepr {
  float getReprScore(string repr, string t){
   repr = "(member * (parameter 0 (member Proxy (global))))" and t = "snk" and result = 0.7500000000 or
   repr = "(member * (parameter 1 (member writeHead *)))" and t = "snk" and result = 0.5000000000 or
   repr = "(member * (parameter custom_val *))" and t = "snk" and result = 0.2500000000 or
   repr = "(member * (parameter obj (member exports *)))" and t = "snk" and result = 0.2500000000 or
   repr = "(member * (parameter thingvalue *))" and t = "snk" and result = 0.2500000000 or
   repr = "(member access (parameter 0 (member findOne *)))" and t = "snk" and result = 0.1666666700 or
   repr = "(member access (parameter 0 (member push *)))" and t = "snk" and result = 0.1666666700 or
   repr = "(member assetPath (parameter 0 (member apiv3 *)))" and t = "snk" and result = 0.5000000000 or
   repr = "(member body (parameter 0 (member post *)))" and t = "snk" and result = 0.5000000000 or
   repr = "(member canShare (member userDocument *))" and t = "snk" and result = 0.1250000000 or
   repr = "(member cancel_path (parameter 1 (member render *)))" and t = "snk" and result = 0.2500000000 or
   repr = "(member codeAndDescription (return (member getEventHtml *)))" and t = "snk" and result = 0.2500000000 or
   repr = "(member content (member vars *))" and t = "snk" and result = 0.0125000000 or
   repr = "(member content (return (member parseData *)))" and t = "snk" and result = 0.0125000000 or
   repr = "(member current (parameter 1 (member render *)))" and t = "snk" and result = 0.5000000000 or
   repr = "(member detailsStr *)" and t = "snk" and result = 0.5000000000 or
   repr = "(member engine *)" and t = "snk" and result = 0.2500000000 or
   repr = "(member fileDir (parameter 0 (member sendFile *)))" and t = "snk" and result = 0.0394736840 or
   repr = "(member foreign (parameter 1 (member render *)))" and t = "snk" and result = 0.5000000000 or
   repr = "(member headers (parameter 0 (member request *)))" and t = "snk" and result = 0.5000000000 or
   repr = "(member host (parameter 2 (member request *)))" and t = "snk" and result = 0.1071428600 or
   repr = "(member id (parameter 0 (member push *)))" and t = "snk" and result = 0.1666666700 or
   repr = "(member index (return (parameter 0 (member map *))))" and t = "snk" and result = 0.2500000000 or
   repr = "(member mime (parameter 0 (parameter callback *)))" and t = "snk" and result = 0.5000000000 or
   repr = "(member newDocument (parameter 0 (member json *)))" and t = "snk" and result = 0.1666666700 or
   repr = "(member ok (parameter 0 (member json *)))" and t = "snk" and result = 0.2500000000 or
   repr = "(member paginateResult (parameter 0 (member apiv3 *)))" and t = "snk" and result = 0.5000000000 or
   repr = "(member path (parameter 0 (member request *)))" and t = "snk" and result = 0.2500000000 or
   repr = "(member pathname (parameter 0 (member format *)))" and t = "snk" and result = 0.2142857150 or
   repr = "(member position (return (parameter 0 (member map *))))" and t = "snk" and result = 0.2500000000 or
   repr = "(member query (parameter 0 (member format *)))" and t = "snk" and result = 0.2500000000 or
   repr = "(member readAccess (member userDocument *))" and t = "snk" and result = 0.1250000000 or
   repr = "(member receivedlength (parameter 1 (member writeHead *)))" and t = "snk" and result = 0.5000000000 or
   repr = "(member rest (return (member parseData *)))" and t = "snk" and result = 0.0125000000 or
   repr = "(member result (parameter 1 (member render *)))" and t = "snk" and result = 0.0833333330 or
   repr = "(member saved_path (parameter 0 (member send *)))" and t = "snk" and result = 0.2500000000 or
   repr = "(member schedule (parameter 1 (member render *)))" and t = "snk" and result = 0.5000000000 or
   repr = "(member script (parameter 0 (member json *)))" and t = "snk" and result = 0.0833333330 or
   repr = "(member templateUrl (parameter 1 (member component *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member templateUrl (return (parameter 1 (member directive *))))" and t = "snk" and result = 1.0000000000 or
   repr = "(member templateUrl *)" and t = "snk" and result = 1.0000000000 or
   repr = "(member userDocument (parameter 1 (member render *)))" and t = "snk" and result = 0.1250000000 or
   repr = "(member value *)" and t = "snk" and result = 0.2500000000 or
   repr = "(member video_name (parameter 0 (member send *)))" and t = "snk" and result = 0.2500000000 or
   repr = "(member webServer *)" and t = "snk" and result = 0.2500000000 or
   repr = "(member writeAccess (member userDocument *))" and t = "snk" and result = 0.1250000000 or
   repr = "(parameter 0 (member * (parameter res *)))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 0 (member URL *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 0 (member access *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member accessSync *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member apiv3 *))" and t = "snk" and result = 0.5000000000 or
   repr = "(parameter 0 (member appendFile *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member appendFileSync *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member cat *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member cd *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member chmod *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member chmodSync *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member chown *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member copy *))" and t = "snk" and result = 0.1666666700 or
   repr = "(parameter 0 (member createReadStream *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member createWriteStream *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member deepStrictEqual *))" and t = "snk" and result = 0.7500000000 or
   repr = "(parameter 0 (member define (global)))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member eachSeries *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 0 (member end *))" and t = "snk" and result = 0.3095238100 or
   repr = "(parameter 0 (member endsWith *))" and t = "snk" and result = 0.4166666700 or
   repr = "(parameter 0 (member equal *))" and t = "snk" and result = 0.0625000000 or
   repr = "(parameter 0 (member eslRequire (global)))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member exec *))" and t = "snk" and result = 0.1666666700 or
   repr = "(parameter 0 (member exists *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member existsSync *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member exit *))" and t = "snk" and result = 0.7500000000 or
   repr = "(parameter 0 (member find *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 0 (member findOne *))" and t = "snk" and result = 0.1666666700 or
   repr = "(parameter 0 (member get *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 0 (member indexOf *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 0 (member json *))" and t = "snk" and result = 0.3571428576 or
   repr = "(parameter 0 (member lchmod *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member lchmodSync *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member link *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member linkSync *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member ls *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member lstat *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member lstatSync *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member map *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 0 (member mkdir *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member mkdirSync *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member mv *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 0 (member ok *))" and t = "snk" and result = 0.5000000000 or
   repr = "(parameter 0 (member open *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member openSync *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member pathExists *))" and t = "snk" and result = 0.0394736840 or
   repr = "(parameter 0 (member pipe *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 0 (member post *))" and t = "snk" and result = 0.5000000000 or
   repr = "(parameter 0 (member push *))" and t = "snk" and result = 0.2222222233 or
   repr = "(parameter 0 (member puts *))" and t = "snk" and result = 0.1785714300 or
   repr = "(parameter 0 (member readFile *))" and t = "snk" and result = 0.9601364523 or
   repr = "(parameter 0 (member readFileSync *))" and t = "snk" and result = 0.9866071429 or
   repr = "(parameter 0 (member readSync *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 0 (member readdir *))" and t = "snk" and result = 0.8993808049 or
   repr = "(parameter 0 (member readdirSync *))" and t = "snk" and result = 0.9772727273 or
   repr = "(parameter 0 (member readlink *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member readlinkSync *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member realpath *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member redirect *))" and t = "snk" and result = 0.3750000000 or
   repr = "(parameter 0 (member rename *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member renameSync *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member render *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member replace *))" and t = "snk" and result = 0.0394736840 or
   repr = "(parameter 0 (member require (global)))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member rm *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member rmdir *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member rmdirSync *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member send *))" and t = "snk" and result = 0.3516483515 or
   repr = "(parameter 0 (member sendFile *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 0 (member splice *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 0 (member stat *))" and t = "snk" and result = 0.9501385042 or
   repr = "(parameter 0 (member statSync *))" and t = "snk" and result = 0.9772727273 or
   repr = "(parameter 0 (member symlink *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member symlinkSync *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member sync *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member to *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 0 (member touch *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member truncate *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member truncateSync *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member unlink *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member unlinkSync *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member unwatchFile *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member update *))" and t = "snk" and result = 0.3571428570 or
   repr = "(parameter 0 (member utimes *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member utimesSync *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member watch *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member watchFile *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member write *))" and t = "snk" and result = 0.3500000000 or
   repr = "(parameter 0 (member writeFile *))" and t = "snk" and result = 0.9731182797 or
   repr = "(parameter 0 (member writeFileSync *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (parameter B *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (parameter callback (parameter 1 (member on *))))" and t = "snk" and result = 0.5000000000 or
   repr = "(parameter 0 (root https://www.npmjs.com/package/assert))" and t = "snk" and result = 0.5000000000 or
   repr = "(parameter 0 (root https://www.npmjs.com/package/request))" and t = "snk" and result = 0.4166666667 or
   repr = "(parameter 1 (member append *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 1 (member appendFile *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 1 (member appendFileSync *))" and t = "snk" and result = 0.7500000000 or
   repr = "(parameter 1 (member createClient *))" and t = "snk" and result = 0.1071428600 or
   repr = "(parameter 1 (member createReadStream *))" and t = "snk" and result = 0.1000000000 or
   repr = "(parameter 1 (member define (global)))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 1 (member emit *))" and t = "snk" and result = 0.2083333350 or
   repr = "(parameter 1 (member equal *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 1 (member json *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 1 (member link *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 1 (member linkSync *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 1 (member redirect *))" and t = "snk" and result = 0.7500000000 or
   repr = "(parameter 1 (member rename *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 1 (member renameSync *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 1 (member render *))" and t = "snk" and result = 0.3458333340 or
   repr = "(parameter 1 (member request *))" and t = "snk" and result = 0.1071428600 or
   repr = "(parameter 1 (member rm *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 1 (member setHeader *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 1 (member slice *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 1 (member spawn *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 1 (member symlink *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 1 (member symlinkSync *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 1 (member writeFile *))" and t = "snk" and result = 0.4166666665 or
   repr = "(parameter 1 (member writeFileSync *))" and t = "snk" and result = 0.3000000000 or
   repr = "(parameter 1 (member writeHead *))" and t = "snk" and result = 0.3750000000 or
   repr = "(parameter 1 (parameter cb (member registered *)))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 2 (member request *))" and t = "snk" and result = 0.1071428600 or
   repr = "(return (member getIndex *))" and t = "snk" and result = 0.4166666700 or
   repr = "(return (member getSuggestions *))" and t = "snk" and result = 0.2500000000 or
   repr = "(return (member postPrintForm *))" and t = "snk" and result = 0.5000000000 or
   repr = "(return (member postSearchForm *))" and t = "snk" and result = 0.4166666700 or
   repr = "(return (member response *))" and t = "snk" and result = 0.2500000000 or
   repr = "(return (parameter 0 (member createServer *)))" and t = "snk" and result = 0.7500000000 or
   repr = "(return (parameter 1 (member get *)))" and t = "snk" and result = 0.3750000000 or
   repr = "(return (parameter 1 (member post *)))" and t = "snk" and result = 0.5000000000 or
   repr = "(return (parameter 1 (member readdir *)))" and t = "snk" and result = 0.2500000000 or
   repr = "(return (parameter 1 (member stat *)))" and t = "snk" and result = 0.2500000000 or
   repr = "(return (parameter 2 (member writeFile *)))" and t = "snk" and result = 0.2500000000 or
   repr = "(return (return (member exports *)))" and t = "snk" and result = 0.2500000000 or
   repr = "(return (return (member getMiddleware *)))" and t = "snk" and result = 0.2500000000
   } 
}
