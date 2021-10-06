module TsmRepr {
  float getReprScore(string repr, string t){
   repr = "(member * (member data *))" and t = "snk" and result = 0.2500000000 or
   repr = "(member Id (member data *))" and t = "snk" and result = 0.2500000000 or
   repr = "(member accessToken (parameter 0 (member send *)))" and t = "snk" and result = 0.1250000000 or
   repr = "(member batchImages (parameter 0 (member send *)))" and t = "snk" and result = 0.1250000000 or
   repr = "(member bid (member authentication *))" and t = "snk" and result = 0.2500000000 or
   repr = "(member data (parameter 0 (member json *)))" and t = "snk" and result = 0.5000000000 or
   repr = "(member data (parameter 1 (member render *)))" and t = "snk" and result = 0.2500000000 or
   repr = "(member end (parameter 1 (member createReadStream *)))" and t = "snk" and result = 0.5000000000 or
   repr = "(member error (parameter 0 (member json *)))" and t = "snk" and result = 0.5000000000 or
   repr = "(member error (parameter 0 (member send *)))" and t = "snk" and result = 0.5000000000 or
   repr = "(member errorMessage (parameter 0 (member json *)))" and t = "snk" and result = 0.2500000000 or
   repr = "(member identifier (return (parameter 0 (member map *))))" and t = "snk" and result = 0.2500000000 or
   repr = "(member message (parameter 0 (member send *)))" and t = "snk" and result = 0.5000000000 or
   repr = "(member output (parameter 1 (member render *)))" and t = "snk" and result = 0.5000000000 or
   repr = "(member params (return (member opaResultToSqlClause *)))" and t = "snk" and result = 0.3333333300 or
   repr = "(member question (parameter 0 (member json *)))" and t = "snk" and result = 0.1250000000 or
   repr = "(member refreshToken (parameter 0 (member send *)))" and t = "snk" and result = 0.1250000000 or
   repr = "(member responseText (parameter 0 (member send *)))" and t = "snk" and result = 0.5000000000 or
   repr = "(member roles (return (member valueOr *)))" and t = "snk" and result = 0.2500000000 or
   repr = "(member root (parameter 1 (member sendFile *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member search_term (parameter 1 (member render *)))" and t = "snk" and result = 0.5000000000 or
   repr = "(member sliValuesObj (parameter 0 (member json *)))" and t = "snk" and result = 0.2500000000 or
   repr = "(member templateUrl (return (parameter 1 (member directive *))))" and t = "snk" and result = 1.0000000000 or
   repr = "(member templateUrl *)" and t = "snk" and result = 1.0000000000 or
   repr = "(member token (parameter 0 (member json *)))" and t = "snk" and result = 0.2500000000 or
   repr = "(member totpSecret (parameter 0 (member queryResultToJson *)))" and t = "snk" and result = 0.2500000000 or
   repr = "(member type *)" and t = "snk" and result = 0.2500000000 or
   repr = "(member uri (parameter 0 (member post *)))" and t = "snk" and result = 0.5000000000 or
   repr = "(member url (parameter 1 (member render *)))" and t = "snk" and result = 0.5000000000 or
   repr = "(member user (parameter 0 (member json *)))" and t = "snk" and result = 0.5000000000 or
   repr = "(member userData (parameter 0 (member send *)))" and t = "snk" and result = 0.2500000000 or
   repr = "(member verify (parameter 1 (member render *)))" and t = "snk" and result = 0.5000000000 or
   repr = "(parameter 0 (member appendFile *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member appendFileSync *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member createReadStream *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member createWriteStream *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member default *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member define (global)))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member end *))" and t = "snk" and result = 0.7500000000 or
   repr = "(parameter 0 (member exists *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member existsSync *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member includes *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 0 (member json *))" and t = "snk" and result = 0.4500000000 or
   repr = "(parameter 0 (member lstatSync *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member mkdir *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member mkdirSync *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member open *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member openSync *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member pipe *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 0 (member post *))" and t = "snk" and result = 0.5000000000 or
   repr = "(parameter 0 (member promisify *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 0 (member r (global)))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member readFile *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member readFileSync *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member readdir *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member readdirSync *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member redirect *))" and t = "snk" and result = 0.5000000000 or
   repr = "(parameter 0 (member rejects *))" and t = "snk" and result = 0.5000000000 or
   repr = "(parameter 0 (member rename *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member renameSync *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member render *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member require (global)))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member rmdir *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member rmdirSync *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member send *))" and t = "snk" and result = 0.4583333333 or
   repr = "(parameter 0 (member sendFile *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member sendfile *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member stat *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member statSync *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member unlink *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member unlinkSync *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member update *))" and t = "snk" and result = 0.5000000000 or
   repr = "(parameter 0 (member watch *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member watchFile *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member write *))" and t = "snk" and result = 0.3750000000 or
   repr = "(parameter 0 (member writeFile *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member writeFileSync *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (parameter callback (member getEventsHandler *)))" and t = "snk" and result = 0.5000000000 or
   repr = "(parameter 0 (parameter callback (member getPositionUpdatesHandler *)))" and t = "snk" and result = 0.5000000000 or
   repr = "(parameter 0 (parameter next (return (member exports *))))" and t = "snk" and result = 0.3000000000 or
   repr = "(parameter 0 (return (member promisify *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (root https://www.npmjs.com/package/recursive-readdir))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (root https://www.npmjs.com/package/request))" and t = "snk" and result = 0.5000000000 or
   repr = "(parameter 0 (root https://www.npmjs.com/package/rimraf))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 1 (member basename *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 1 (member cookie *))" and t = "snk" and result = 0.7500000000 or
   repr = "(parameter 1 (member define (global)))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 1 (member equal *))" and t = "snk" and result = 0.5000000000 or
   repr = "(parameter 1 (member redirect *))" and t = "snk" and result = 0.5000000000 or
   repr = "(parameter 1 (member rename *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 1 (member renameSync *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 1 (member render *))" and t = "snk" and result = 0.4375000000 or
   repr = "(parameter 1 (member writeFileSync *))" and t = "snk" and result = 0.2500000000
   } 
}
