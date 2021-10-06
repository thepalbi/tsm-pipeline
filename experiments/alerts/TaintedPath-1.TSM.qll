module TsmRepr {
  float getReprScore(string repr, string t){
   repr = "(member * (parameter 1 (member executeQuery *)))" and t = "snk" and result = 0.2500000000 or
   repr = "(member * (parameter 1 (member update *)))" and t = "snk" and result = 0.0714285710 or
   repr = "(member * (parameter 1 (member writeHead *)))" and t = "snk" and result = 0.3571428570 or
   repr = "(member * (return (member split *)))" and t = "snk" and result = 0.2500000000 or
   repr = "(member Content-Length (member headers *))" and t = "snk" and result = 0.2500000000 or
   repr = "(member Location (parameter 1 (member writeHead *)))" and t = "snk" and result = 0.1250000000 or
   repr = "(member ap_ssid (parameter 1 (member render *)))" and t = "snk" and result = 0.5000000000 or
   repr = "(member bcHash (member $set *))" and t = "snk" and result = 0.0714285710 or
   repr = "(member bcMeta (member data *))" and t = "snk" and result = 0.2500000000 or
   repr = "(member bc_hash (parameter 1 (parameter callback *)))" and t = "snk" and result = 0.0714285710 or
   repr = "(member body (parameter 0 (member post *)))" and t = "snk" and result = 0.5000000000 or
   repr = "(member content (parameter 1 (member emit *)))" and t = "snk" and result = 0.5000000000 or
   repr = "(member data (parameter 0 (member json *)))" and t = "snk" and result = 0.2500000000 or
   repr = "(member data (parameter 1 (member emit *)))" and t = "snk" and result = 0.5000000000 or
   repr = "(member data (parameter 1 (member render *)))" and t = "snk" and result = 0.2500000000 or
   repr = "(member dbHash (member $set *))" and t = "snk" and result = 0.0714285710 or
   repr = "(member end (parameter 1 (member createReadStream *)))" and t = "snk" and result = 0.0714285710 or
   repr = "(member evidenceId (member $set *))" and t = "snk" and result = 0.0714285710 or
   repr = "(member evidence_id (parameter 1 (parameter callback *)))" and t = "snk" and result = 0.0714285710 or
   repr = "(member formdatas (parameter 1 (member render *)))" and t = "snk" and result = 0.2500000000 or
   repr = "(member hash (parameter 0 (member jsonp *)))" and t = "snk" and result = 0.2500000000 or
   repr = "(member host (parameter 2 (member request *)))" and t = "snk" and result = 0.1250000000 or
   repr = "(member id (parameter 0 (member push *)))" and t = "snk" and result = 0.1250000000 or
   repr = "(member id (parameter 0 (member send *)))" and t = "snk" and result = 0.3750000000 or
   repr = "(member index (return (parameter 0 (member map *))))" and t = "snk" and result = 0.2500000000 or
   repr = "(member isIE (parameter response *))" and t = "snk" and result = 0.5000000000 or
   repr = "(member items (parameter 0 (member send *)))" and t = "snk" and result = 0.2500000000 or
   repr = "(member locals (parameter 1 (member render *)))" and t = "snk" and result = 0.5000000000 or
   repr = "(member log (parameter 0 (member AdminLog *)))" and t = "snk" and result = 0.5000000000 or
   repr = "(member loginId (parameter 0 (member findOne *)))" and t = "snk" and result = 0.5000000000 or
   repr = "(member path (parameter 0 (member request *)))" and t = "snk" and result = 0.2500000000 or
   repr = "(member position (return (parameter 0 (member map *))))" and t = "snk" and result = 0.2500000000 or
   repr = "(member removed (parameter 0 (member json *)))" and t = "snk" and result = 0.5000000000 or
   repr = "(member result (parameter 1 (member render *)))" and t = "snk" and result = 0.1666666665 or
   repr = "(member showNotification (parameter 0 (member json *)))" and t = "snk" and result = 0.5000000000 or
   repr = "(member size (member page *))" and t = "snk" and result = 0.5000000000 or
   repr = "(member start (parameter 1 (member createReadStream *)))" and t = "snk" and result = 0.0714285710 or
   repr = "(member sunburst (parameter 1 (member render *)))" and t = "snk" and result = 0.5000000000 or
   repr = "(member templateUrl (return (parameter 1 (member directive *))))" and t = "snk" and result = 1.0000000000 or
   repr = "(member templateUrl *)" and t = "snk" and result = 1.0000000000 or
   repr = "(member text (member body *))" and t = "snk" and result = 0.2500000000 or
   repr = "(member uri (parameter 0 (root https://www.npmjs.com/package/request)))" and t = "snk" and result = 0.1250000000 or
   repr = "(member url (parameter 0 (member jsonp *)))" and t = "snk" and result = 0.2500000000 or
   repr = "(member url (parameter 0 (root https://www.npmjs.com/package/request)))" and t = "snk" and result = 0.5000000000 or
   repr = "(member user *)" and t = "snk" and result = 0.1250000000 or
   repr = "(parameter 0 (member AdminLog *))" and t = "snk" and result = 0.5000000000 or
   repr = "(parameter 0 (member URL *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 0 (member access *))" and t = "snk" and result = 0.7222222233 or
   repr = "(parameter 0 (member accessSync *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member appendFile *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member appendFileSync *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member attachment *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 0 (member chmod *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member chmodSync *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member chown *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member cp *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member createClient *))" and t = "snk" and result = 0.1250000000 or
   repr = "(parameter 0 (member createReadStream *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member createWriteStream *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member define (global)))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member end *))" and t = "snk" and result = 0.3016666670 or
   repr = "(parameter 0 (member equal *))" and t = "snk" and result = 0.1500000000 or
   repr = "(parameter 0 (member exists *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member existsSync *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member exit *))" and t = "snk" and result = 0.7500000000 or
   repr = "(parameter 0 (member findOne *))" and t = "snk" and result = 0.5000000000 or
   repr = "(parameter 0 (member get *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 0 (member indexOf *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 0 (member isNull *))" and t = "snk" and result = 0.5000000000 or
   repr = "(parameter 0 (member isUndefined *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 0 (member item *))" and t = "snk" and result = 0.5000000000 or
   repr = "(parameter 0 (member json *))" and t = "snk" and result = 0.4642857143 or
   repr = "(parameter 0 (member jsonp *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 0 (member justSend *))" and t = "snk" and result = 0.5000000000 or
   repr = "(parameter 0 (member link *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member ls *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member lstat *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member lstatSync *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member map *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 0 (member mkdir *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member mkdirSync *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member open *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member openSync *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member pipe *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 0 (member post *))" and t = "snk" and result = 0.5000000000 or
   repr = "(parameter 0 (member puts *))" and t = "snk" and result = 0.5000000000 or
   repr = "(parameter 0 (member r (global)))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member readFile *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member readFileSync *))" and t = "snk" and result = 0.9861111111 or
   repr = "(parameter 0 (member readdir *))" and t = "snk" and result = 0.9700000000 or
   repr = "(parameter 0 (member readdirSync *))" and t = "snk" and result = 0.9700000000 or
   repr = "(parameter 0 (member readlink *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member readlinkSync *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member redirect *))" and t = "snk" and result = 0.5000000000 or
   repr = "(parameter 0 (member removeSync *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 0 (member rename *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member renameSync *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member render *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member replace *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 0 (member request *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 0 (member require (global)))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member require *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member rm *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member rmdir *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member rmdirSync *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member send *))" and t = "snk" and result = 0.4383116882 or
   repr = "(parameter 0 (member sendFile *))" and t = "snk" and result = 0.2083333350 or
   repr = "(parameter 0 (member sendfile *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 0 (member startsWith *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 0 (member stat *))" and t = "snk" and result = 0.9621212123 or
   repr = "(parameter 0 (member statSync *))" and t = "snk" and result = 0.9758064516 or
   repr = "(parameter 0 (member symlink *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member symlinkSync *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member truncateSync *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member unlink *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member unlinkSync *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member update *))" and t = "snk" and result = 0.5000000000 or
   repr = "(parameter 0 (member utimes *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member utimesSync *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member watch *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member watchFile *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member write *))" and t = "snk" and result = 0.3888888889 or
   repr = "(parameter 0 (member writeFile *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member writeFileSync *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (return (member hijack *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (root https://www.npmjs.com/package/assert))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 0 (root https://www.npmjs.com/package/request))" and t = "snk" and result = 0.4125000000 or
   repr = "(parameter 1 (member cp *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 1 (member createClient *))" and t = "snk" and result = 0.1250000000 or
   repr = "(parameter 1 (member createReadStream *))" and t = "snk" and result = 0.0714285710 or
   repr = "(parameter 1 (member define (global)))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 1 (member emit *))" and t = "snk" and result = 0.5833333333 or
   repr = "(parameter 1 (member flash *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 1 (member get *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 1 (member jsonp *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 1 (member link *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 1 (member mkdir *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 1 (member on *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 1 (member rename *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 1 (member renameSync *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 1 (member render *))" and t = "snk" and result = 0.3645833338 or
   repr = "(parameter 1 (member request *))" and t = "snk" and result = 0.1250000000 or
   repr = "(parameter 1 (member rm *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 1 (member set *))" and t = "snk" and result = 0.3750000000 or
   repr = "(parameter 1 (member setHeader *))" and t = "snk" and result = 0.3750000000 or
   repr = "(parameter 1 (member substring *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 1 (member symlink *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 1 (member symlinkSync *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 1 (member update *))" and t = "snk" and result = 0.0714285710 or
   repr = "(parameter 1 (member writeFile *))" and t = "snk" and result = 0.3333333333 or
   repr = "(parameter 1 (member writeFileSync *))" and t = "snk" and result = 0.5000000000 or
   repr = "(parameter 1 (member writeHead *))" and t = "snk" and result = 0.2718253968 or
   repr = "(parameter 1 (parameter callback *))" and t = "snk" and result = 0.0714285710 or
   repr = "(parameter 1 (parameter cb (member registered *)))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 1 (root https://www.npmjs.com/package/assert))" and t = "snk" and result = 0.1500000000 or
   repr = "(parameter 2 (member cp *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 2 (member equal *))" and t = "snk" and result = 0.1500000000 or
   repr = "(parameter 2 (member request *))" and t = "snk" and result = 0.1250000000 or
   repr = "(return (member createProject *))" and t = "snk" and result = 0.5000000000 or
   repr = "(return (member response *))" and t = "snk" and result = 0.2500000000 or
   repr = "(return (member updateProject *))" and t = "snk" and result = 0.5000000000 or
   repr = "(return (parameter 0 (member save *)))" and t = "snk" and result = 0.5000000000 or
   repr = "(return (parameter 1 (member delete *)))" and t = "snk" and result = 0.1666666700 or
   repr = "(return (parameter 1 (member exists *)))" and t = "snk" and result = 0.2500000000 or
   repr = "(return (parameter 1 (member findOne *)))" and t = "snk" and result = 0.5000000000 or
   repr = "(return (parameter 1 (member get *)))" and t = "snk" and result = 0.3055555567 or
   repr = "(return (parameter 1 (member post *)))" and t = "snk" and result = 0.2500000000 or
   repr = "(return (parameter 1 (member readdir *)))" and t = "snk" and result = 0.1666666700 or
   repr = "(return (parameter 2 (member put *)))" and t = "snk" and result = 0.1666666700 or
   repr = "(return (parameter 2 (member update *)))" and t = "snk" and result = 0.5000000000
   } 
}
