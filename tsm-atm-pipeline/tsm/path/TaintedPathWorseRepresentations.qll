module TsmRepr {float getReprScore(string repr, string t){
    repr = "(return (member match *))" and t = "san" and result = 1.0000000000  or 
    repr = "(parameter err (parameter 1 (member on *)))" and t = "src" and result = 1.0000000000  or 
    repr = "(parameter 2 (member emit *))" and t = "snk" and result = 0.7500000000  or 
    repr = "(return (member exec *))" and t = "san" and result = 1.0000000000  or 
    repr = "(member sid (member query *))" and t = "src" and result = 1.0000000000  or 
    repr = "(return (member get *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member * (parameter obj *))" and t = "src" and result = 1.0000000000  or 
    repr = "(parameter 0 (member define (global)))" and t = "snk" and result = 1.0000000000  or 
    repr = "(parameter e (parameter 1 (member on *)))" and t = "src" and result = 1.0000000000  or 
    repr = "(parameter 0 (member open *))" and t = "snk" and result = 1.0000000000  or 
    repr = "(parameter 0 (member stat *))" and t = "snk" and result = 1.0000000000  or 
    repr = "(parameter event (parameter 1 (member addEventListener *)))" and t = "src" and result = 1.0000000000  or 
    repr = "(parameter err (parameter 1 (member removeListener *)))" and t = "src" and result = 1.0000000000  or 
    repr = "(member origin (member headers *))" and t = "src" and result = 1.0000000000  or 
    repr = "(return (member hasOwnProperty *))" and t = "san" and result = 1.0000000000  or 
    repr = "(parameter 0 (member writeFileSync *))" and t = "snk" and result = 1.0000000000  or 
    repr = "(return (member indexOf *))" and t = "san" and result = 1.0000000000  or 
    repr = "(parameter 0 (member readFileSync *))" and t = "snk" and result = 1.0000000000  or 
    repr = "(member * (member query *))" and t = "src" and result = 1.0000000000  or 
    repr = "(parameter 0 (parameter callback *))" and t = "snk" and result = 0.7500000000  or 
    repr = "(parameter 0 (member render *))" and t = "snk" and result = 1.0000000000  or 
    repr = "(return (member decode *))" and t = "snk" and result = 0.5000000000  or 
    repr = "(member url (member request *))" and t = "src" and result = 1.0000000000  or 
    repr = "(parameter 0 (member require (global)))" and t = "snk" and result = 1.0000000000  or 
    repr = "(parameter data (parameter 1 (member on *)))" and t = "src" and result = 1.0000000000  or 
    repr = "(parameter 1 (member define (global)))" and t = "snk" and result = 1.0000000000  or 
    repr = "(return (member test *))" and t = "san" and result = 1.0000000000  or 
    repr = "(parameter chunk (parameter 1 (member on *)))" and t = "src" and result = 1.0000000000  or 
    repr = "(parameter 0 (member mkdirSync *))" and t = "snk" and result = 1.0000000000  or 
    repr = "(parameter msg (parameter 1 (member on *)))" and t = "src" and result = 1.0000000000  or 
    repr = "(parameter 0 (member existsSync *))" and t = "snk" and result = 1.0000000000  or 
    repr = "(parameter evt (parameter 1 (member addEventListener *)))" and t = "src" and result = 1.0000000000  or 
    repr = "(parameter 0 (member sendFile *))" and t = "snk" and result = 1.0000000000  or 
    repr = "(parameter 0 (member readdirSync *))" and t = "snk" and result = 1.0000000000  or 
    repr = "(parameter 0 (member createWriteStream *))" and t = "snk" and result = 1.0000000000  or 
    repr = "(parameter 1 (member mkdir *))" and t = "snk" and result = 1.0000000000  or 
    repr = "(return (member has *))" and t = "san" and result = 1.0000000000  or 
    repr = "(parameter 0 (member find *))" and t = "snk" and result = 1.0000000000  or 
    repr = "(member body (parameter req *))" and t = "src" and result = 1.0000000000  or 
    repr = "(parameter 0 (member unlink *))" and t = "snk" and result = 1.0000000000  or 
    repr = "(parameter 0 (member readdir *))" and t = "snk" and result = 1.0000000000  or 
    repr = "(member 0 (member params *))" and t = "src" and result = 1.0000000000  or 
    repr = "(parameter 0 (member writeFile *))" and t = "snk" and result = 1.0000000000  or 
    repr = "(parameter 0 (member ncp *))" and t = "snk" and result = 1.0000000000  or 
    repr = "(parameter 0 (member exists *))" and t = "snk" and result = 1.0000000000  or 
    repr = "(member originalUrl (parameter req *))" and t = "src" and result = 1.0000000000  or 
    repr = "(return (member contains *))" and t = "san" and result = 1.0000000000  or 
    repr = "(parameter 0 (member createReadStream *))" and t = "snk" and result = 1.0000000000  or 
    repr = "(member token (member query *))" and t = "src" and result = 1.0000000000  or 
    repr = "(parameter 1 (member ncp *))" and t = "snk" and result = 1.0000000000  or 
    repr = "(parameter 0 (member mkdir *))" and t = "snk" and result = 1.0000000000  or 
    repr = "(parameter 0 (root https://www.npmjs.com/package/rimraf))" and t = "snk" and result = 1.0000000000  or 
    repr = "(parameter 0 (member readFile *))" and t = "snk" and result = 1.0000000000  or 
    repr = "(return (member include *))" and t = "san" and result = 1.0000000000  or 
    repr = "(return (member includes *))" and t = "san" and result = 1.0000000000  or 
    repr = "(member id (member params *))" and t = "src" and result = 1.0000000000  or 
    repr = "(parameter 1 (member symlinkSync *))" and t = "snk" and result = 1.0000000000  or 
    repr = "(parameter 0 (member renameSync *))" and t = "snk" and result = 1.0000000000  or 
    repr = "(parameter b (parameter 1 (member on *)))" and t = "src" and result = 1.0000000000  or 
    repr = "(parameter 1 (member rename *))" and t = "snk" and result = 1.0000000000  or 
    repr = "(return (member param *))" and t = "src" and result = 1.0000000000  or 
    repr = "(parameter 1 (member symlink *))" and t = "snk" and result = 1.0000000000  or 
    repr = "(return (member header *))" and t = "src" and result = 1.0000000000  or 
    repr = "(parameter e (parameter 1 (member addEventListener *)))" and t = "src" and result = 1.0000000000  or 
    repr = "(return (member search *))" and t = "src" and result = 1.0000000000  or 
    repr = "(parameter event (parameter 1 (member removeEventListener *)))" and t = "src" and result = 1.0000000000  or 
    repr = "(return (member unique *))" and t = "san" and result = 1.0000000000  or 
    repr = "(parameter 0 (member truncate *))" and t = "snk" and result = 1.0000000000  or 
    repr = "(return (member is *))" and t = "san" and result = 1.0000000000  or 
    repr = "(parameter event (member onmessage *))" and t = "src" and result = 1.0000000000  or 
    repr = "(parameter 0 (member symlinkSync *))" and t = "snk" and result = 1.0000000000  or 
    repr = "(parameter 0 (member utimesSync *))" and t = "snk" and result = 1.0000000000  or 
    repr = "(member * (member headers *))" and t = "src" and result = 1.0000000000  or 
    repr = "(parameter 0 (member rmdir *))" and t = "snk" and result = 1.0000000000  or 
    repr = "(parameter 0 (member readlinkSync *))" and t = "snk" and result = 1.0000000000  or 
    repr = "(member request (member params *))" and t = "src" and result = 1.0000000000  or 
    repr = "(parameter 0 (member lstatSync *))" and t = "snk" and result = 1.0000000000  or 
    repr = "(parameter 0 (member access *))" and t = "snk" and result = 1.0000000000  or 
    repr = "(parameter event (parameter 1 (member attachEvent *)))" and t = "src" and result = 1.0000000000  or 
    repr = "(parameter 0 (member to *))" and t = "snk" and result = 1.0000000000  or 
    repr = "(parameter 0 (member rename *))" and t = "snk" and result = 1.0000000000  or 
    repr = "(parameter 0 (member readlink *))" and t = "snk" and result = 1.0000000000  or 
    repr = "(return (member val *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member color (parameter item *))" and t = "src" and result = 1.0000000000  or 
    repr = "(parameter 1 (member renameSync *))" and t = "snk" and result = 1.0000000000  or 
    repr = "(parameter 0 (member chmodSync *))" and t = "snk" and result = 1.0000000000  or 
    repr = "(parameter event (parameter 1 (member on *)))" and t = "src" and result = 1.0000000000  or 
    repr = "(parameter 0 (member chown *))" and t = "snk" and result = 1.0000000000  or 
    repr = "(parameter ev (parameter 1 (member addEventListener *)))" and t = "src" and result = 1.0000000000  or 
    repr = "(parameter c (parameter 1 (member on *)))" and t = "src" and result = 1.0000000000  or 
    repr = "(parameter 1 (member chmod *))" and t = "snk" and result = 1.0000000000  or 
    repr = "(parameter 0 (member openSync *))" and t = "snk" and result = 1.0000000000  or 
    repr = "(member files (parameter req *))" and t = "src" and result = 1.0000000000  or 
    repr = "(parameter e (member onmessage *))" and t = "src" and result = 1.0000000000  or 
    repr = "(parameter 0 (member truncateSync *))" and t = "snk" and result = 1.0000000000  or 
    repr = "(parameter 0 (member unlinkSync *))" and t = "snk" and result = 1.0000000000  or 
    repr = "(parameter error (parameter 1 (member on *)))" and t = "src" and result = 1.0000000000  or 
    repr = "(parameter 0 (member symlink *))" and t = "snk" and result = 1.0000000000  or 
    repr = "(parameter 0 (member rmdirSync *))" and t = "snk" and result = 1.0000000000  or 
    repr = "(parameter 0 (member chmod *))" and t = "snk" and result = 1.0000000000  or 
    repr = "(return (member endsWith *))" and t = "san" and result = 1.0000000000  or 
    repr = "(return (member startsWith *))" and t = "san" and result = 1.0000000000  or 
    repr = "(member name (global))" and t = "src" and result = 1.0000000000  or 
    repr = "(member url (parameter req *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member name (member headers *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member host (member headers *))" and t = "src" and result = 1.0000000000  or 
    repr = "(parameter 0 (member cd *))" and t = "snk" and result = 1.0000000000  or 
    repr = "(member * (parameter input *))" and t = "src" and result = 1.0000000000  or 
    repr = "(parameter 0 (member appendFile *))" and t = "snk" and result = 1.0000000000  or 
    repr = "(member date (member query *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member * (member params *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member id (member query *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member search (member params *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member my (member query *))" and t = "src" and result = 1.0000000000  or 
    repr = "(parameter 0 (member sendfile *))" and t = "snk" and result = 1.0000000000  or 
    repr = "(parameter 0 (member src *))" and t = "snk" and result = 1.0000000000  or 
    repr = "(parameter 0 (member dest *))" and t = "snk" and result = 1.0000000000  or 
    repr = "(member url (parameter request *))" and t = "src" and result = 1.0000000000  or 
    repr = "(return (member $matchTokenType *))" and t = "san" and result = 1.0000000000  or 
    repr = "(member x-api-key *)" and t = "src" and result = 1.0000000000  or 
    repr = "(member url (parameter e *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member content-type *)" and t = "src" and result = 1.0000000000  or 
    repr = "(parameter 0 (parameter 1 (member on *)))" and t = "src" and result = 1.0000000000  or 
    repr = "(member userId (member params *))" and t = "src" and result = 1.0000000000  or 
    repr = "(parameter 0 (member statSync *))" and t = "snk" and result = 1.0000000000  or 
    repr = "(member format (member query *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member key (member params *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member accept (member headers *))" and t = "src" and result = 1.0000000000  or 
    repr = "(parameter n (parameter 1 (member attachEvent *)))" and t = "src" and result = 1.0000000000  or 
    repr = "(member type (member params *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member resource (member params *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member action (member params *))" and t = "src" and result = 1.0000000000  or 
    repr = "(parameter e (parameter 1 (member removeEventListener *)))" and t = "src" and result = 1.0000000000  or 
    repr = "(parameter 0 (member onmessage *))" and t = "src" and result = 1.0000000000  or 
    repr = "(return (member isAbsolute *))" and t = "san" and result = 1.0000000000  or 
    repr = "(parameter reason (parameter 1 (member on *)))" and t = "src" and result = 1.0000000000  or 
    repr = "(parameter evt (member onmessage *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member length (member params *))" and t = "src" and result = 1.0000000000  or 
    repr = "(parameter a (parameter 1 (member on *)))" and t = "src" and result = 1.0000000000  or 
    repr = "(member name (member params *))" and t = "src" and result = 1.0000000000  or 
    repr = "(parameter messageEvent (parameter 1 (member removeEventListener *)))" and t = "src" and result = 1.0000000000  or 
    repr = "(parameter er (parameter 1 (member on *)))" and t = "src" and result = 1.0000000000  or 
    repr = "(parameter 0 (member Writer *))" and t = "snk" and result = 1.0000000000  or 
    repr = "(parameter data (parameter 1 (member once *)))" and t = "src" and result = 1.0000000000  or 
    repr = "(member content-length *)" and t = "src" and result = 1.0000000000  or 
    repr = "(parameter msg (member onmessage *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member path (member path *))" and t = "snk" and result = 1.0000000000  or 
    repr = "(member filter (member params *))" and t = "src" and result = 1.0000000000  or 
    repr = "(parameter 0 (member link *))" and t = "snk" and result = 1.0000000000  or 
    repr = "(parameter options (parameter 1 (member on *)))" and t = "src" and result = 1.0000000000  or 
    repr = "(parameter event (parameter 1 (member addEventListener (global))))" and t = "src" and result = 1.0000000000  or 
    repr = "(parameter 0 (parameter 1 (member removeEventListener *)))" and t = "src" and result = 1.0000000000  or 
    repr = "(parameter 0 (member sync *))" and t = "snk" and result = 1.0000000000  or 
    repr = "(member cookie (member headers *))" and t = "src" and result = 1.0000000000  or 
    repr = "(parameter 0 (member watch *))" and t = "snk" and result = 1.0000000000  or 
    repr = "(parameter 0 (member require *))" and t = "snk" and result = 1.0000000000  or 
    repr = "(parameter message (parameter 1 (member on *)))" and t = "src" and result = 1.0000000000  or 
    repr = "(parameter arg (parameter 1 (member on *)))" and t = "src" and result = 1.0000000000  or 
    repr = "(member * (parameter query *))" and t = "src" and result = 1.0000000000  or 
    repr = "(parameter 1 (return (member promisify *)))" and t = "snk" and result = 1.0000000000  or 
    repr = "(member if-none-match *)" and t = "src" and result = 1.0000000000  or 
    repr = "(parameter 0 (return (member promisify *)))" and t = "snk" and result = 1.0000000000  or 
    repr = "(parameter 1 (member link *))" and t = "snk" and result = 1.0000000000  or 
    repr = "(member source (member query *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member accept-encoding *)" and t = "src" and result = 1.0000000000  or 
    repr = "(member access-control-request-headers *)" and t = "src" and result = 1.0000000000  or 
    repr = "(member type (member query *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member length (member query *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member user-agent *)" and t = "src" and result = 1.0000000000  or 
    repr = "(member end (member query *))" and t = "src" and result = 1.0000000000  or 
    repr = "(return (member hash *))" and t = "src" and result = 1.0000000000  or 
    repr = "(parameter 0 (member files *))" and t = "snk" and result = 1.0000000000  or 
    repr = "(parameter event (member handler *))" and t = "src" and result = 1.0000000000  or 
    repr = "(parameter value (parameter 1 (member on *)))" and t = "src" and result = 1.0000000000  or 
    repr = "(parameter file (parameter 1 (member on *)))" and t = "src" and result = 1.0000000000  or 
    repr = "(parameter 0 (member watchFile *))" and t = "snk" and result = 1.0000000000  or 
    repr = "(parameter args (parameter 1 (member on *)))" and t = "src" and result = 1.0000000000  or 
    repr = "(member term (member query *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member start (member query *))" and t = "src" and result = 1.0000000000  or 
    repr = "(parameter obj (parameter 1 (member on *)))" and t = "src" and result = 1.0000000000  or 
    repr = "(parameter name (parameter 1 (member on *)))" and t = "src" and result = 1.0000000000  or 
    repr = "(member direction (member query *))" and t = "src" and result = 1.0000000000  or 
    repr = "(parameter context (parameter 1 (member on *)))" and t = "src" and result = 1.0000000000  or 
    repr = "(member name (member query *))" and t = "src" and result = 1.0000000000  or 
    repr = "(parameter d (parameter 1 (member on *)))" and t = "src" and result = 1.0000000000  or 
    repr = "(parameter i (parameter 1 (member on *)))" and t = "src" and result = 1.0000000000  or 
    repr = "(member page (member params *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member cookies (parameter req *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member x-forwarded-proto *)" and t = "src" and result = 1.0000000000  or 
    repr = "(member data (member params *))" and t = "src" and result = 1.0000000000  or 
    repr = "(return (parameter 0 (member createServer *)))" and t = "snk" and result = 0.7500000000  or 
    repr = "(member hostname (parameter req *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member body (member request *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member accept-language *)" and t = "src" and result = 1.0000000000  or 
    repr = "(member range (member headers *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member map (member query *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member limit (member query *))" and t = "src" and result = 1.0000000000  or 
    repr = "(parameter res (parameter 1 (member on *)))" and t = "src" and result = 1.0000000000  or 
    repr = "(member sort (member query *))" and t = "src" and result = 1.0000000000  or 
    repr = "(parameter response (parameter 1 (member on *)))" and t = "src" and result = 1.0000000000  or 
    repr = "(member fields (member query *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member templateUrl (return (parameter 1 (member directive *))))" and t = "snk" and result = 1.0000000000  or 
    repr = "(member files (parameter request *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member access_token (member query *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member uuid (member params *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member key (member query *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member file (member query *))" and t = "src" and result = 1.0000000000  or 
    repr = "(parameter ex (parameter 1 (member on *)))" and t = "src" and result = 1.0000000000  or 
    repr = "(parameter 0 (member appendFileSync *))" and t = "snk" and result = 1.0000000000  or 
    repr = "(parameter 1 (member ln *))" and t = "snk" and result = 1.0000000000  or 
    repr = "(parameter err (parameter 1 (member once *)))" and t = "src" and result = 1.0000000000  or 
    repr = "(parameter 2 (member ln *))" and t = "snk" and result = 1.0000000000  or 
    repr = "(parameter 0 (member ln *))" and t = "snk" and result = 1.0000000000  or 
    repr = "(member slug (member params *))" and t = "src" and result = 1.0000000000  or 
    repr = "(parameter evt (parameter 1 (member removeEventListener *)))" and t = "src" and result = 1.0000000000  or 
    repr = "(member authorization (member headers *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member hash (member params *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member body (parameter request *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member templateUrl (parameter 1 (member component *)))" and t = "snk" and result = 1.0000000000  or 
    repr = "(parameter r (member onmessage *))" and t = "src" and result = 1.0000000000  or 
    repr = "(parameter e (member message *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member date (member params *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member join (member params *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member id (parameter $routeParams *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member size (member params *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member templateUrl (return (member * (parameter 1 (member directive *)))))" and t = "snk" and result = 1.0000000000  or 
    repr = "(member page (parameter query *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member fileName (member params *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member from (member query *))" and t = "src" and result = 1.0000000000  or 
    repr = "(parameter r (parameter 1 (member on *)))" and t = "src" and result = 1.0000000000  or 
    repr = "(member tags (member query *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member results (member query *))" and t = "src" and result = 1.0000000000  or 
    repr = "(parameter q (parameter 1 (member on *)))" and t = "src" and result = 1.0000000000  or 
    repr = "(parameter oEvent (member onmessage *))" and t = "src" and result = 1.0000000000  or 
    repr = "(parameter 0 (parameter B *))" and t = "snk" and result = 1.0000000000  or 
    repr = "(member segment_id (member params *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member if-modified-since *)" and t = "src" and result = 1.0000000000  or 
    repr = "(parameter req (parameter 1 (member on *)))" and t = "src" and result = 1.0000000000  or 
    repr = "(parameter 0 (member lstat *))" and t = "snk" and result = 1.0000000000  or 
    repr = "(member filename (member params *))" and t = "src" and result = 1.0000000000  or 
    repr = "(parameter error (parameter 1 (member removeListener *)))" and t = "src" and result = 1.0000000000  or 
    repr = "(member productId (parameter item *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member token (member params *))" and t = "src" and result = 1.0000000000  or 
    repr = "(parameter buf (parameter 1 (member on *)))" and t = "src" and result = 1.0000000000  or 
    repr = "(member npid (member params *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member pid (member query *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member lang (member query *))" and t = "src" and result = 1.0000000000  or 
    repr = "(parameter room (parameter 1 (member on *)))" and t = "src" and result = 1.0000000000  or 
    repr = "(parameter a (parameter 1 (member addEventListener *)))" and t = "src" and result = 1.0000000000  or 
    repr = "(parameter 0 (member go (global)))" and t = "snk" and result = 1.0000000000  or 
    repr = "(member search (member query *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member page (member query *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member number (member params *))" and t = "src" and result = 1.0000000000  or 
    repr = "(parameter request (parameter 1 (member on *)))" and t = "src" and result = 1.0000000000  or 
    repr = "(parameter 0 (member cat *))" and t = "snk" and result = 1.0000000000  or 
    repr = "(parameter path (parameter 1 (member on *)))" and t = "src" and result = 1.0000000000  or 
    repr = "(member * (parameter info *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member url (member query *))" and t = "src" and result = 1.0000000000  or 
    repr = "(parameter 1 (member mv *))" and t = "snk" and result = 1.0000000000  or 
    repr = "(parameter 0 (member mv *))" and t = "snk" and result = 1.0000000000  or 
    repr = "(parameter exception (parameter 1 (member on *)))" and t = "src" and result = 1.0000000000  or 
    repr = "(parameter 0 (member importScripts *))" and t = "snk" and result = 1.0000000000  or 
    repr = "(parameter 0 (member touch *))" and t = "snk" and result = 1.0000000000  or 
    repr = "(parameter 0 (parameter 1 (member addEventListener *)))" and t = "src" and result = 1.0000000000  or 
    repr = "(parameter config (parameter 1 (member on *)))" and t = "src" and result = 1.0000000000  or 
    repr = "(parameter 0 (member realpath *))" and t = "snk" and result = 1.0000000000  or 
    repr = "(member path (member params *))" and t = "src" and result = 1.0000000000  or 
    repr = "(parameter t (member onmessage *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member propertyName (member params *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member format (member params *))" and t = "src" and result = 1.0000000000  or 
    repr = "(parameter 0 (return (root https://www.npmjs.com/package/esm)))" and t = "snk" and result = 1.0000000000  or 
    repr = "(member category (member params *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member q (member query *))" and t = "src" and result = 1.0000000000  or 
    repr = "(return (root https://www.npmjs.com/package/path-is-inside))" and t = "san" and result = 1.0000000000  or 
    repr = "(member x-forwarded-for *)" and t = "src" and result = 1.0000000000  or 
    repr = "(member size (parameter item *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member ref (member query *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member version (member params *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member ref (member params *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member f (member query *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member t (member query *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member over18 (member query *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member data (member query *))" and t = "src" and result = 1.0000000000  or 
    repr = "(parameter 0 (member accessSync *))" and t = "snk" and result = 1.0000000000  or 
    repr = "(member scenario (member query *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member toggleVersion (member query *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member documentReceived10 (member query *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member page6 (member query *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member error1 (member query *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member reason3 (member query *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member error (member query *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member documentReceived9 (member query *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member toggleContent (member query *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member documentReceived6 (member query *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member page4 (member query *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member page5 (member query *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member alldocumentsReceived (member query *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member nothingToView (member query *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member documentReceived13 (member query *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member interimDesign (member query *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member documentReceived11 (member query *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member apprenticeshipServiceAccess (member query *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member page3 (member query *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member documentReceived7 (member query *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member page2 (member query *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member documentReceived2 (member query *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member uploadedDocumentName (member query *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member documentReceived12 (member query *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member documentReceived4 (member query *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member documentReceived8 (member query *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member tab (member query *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member paginationRequired (member query *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member documentReceived3 (member query *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member page1 (member query *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member reason2 (member query *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member noFilterResults (member query *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member alternativeContentRequired (member query *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member reason1 (member query *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member error2 (member query *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member documentReceived1 (member query *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member documentReceived5 (member query *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member searchTerm (member query *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member redirectURL (member query *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member offer_id (member params *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member user_id (member params *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member branch (member params *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member project_id (member params *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member result_number (member params *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member job_id (member params *))" and t = "src" and result = 1.0000000000  or 
    repr = "(parameter buffer (parameter 1 (member on *)))" and t = "src" and result = 1.0000000000  or 
    repr = "(member content-encoding *)" and t = "src" and result = 1.0000000000  or 
    repr = "(parameter query (parameter 1 (member on *)))" and t = "src" and result = 1.0000000000  or 
    repr = "(member url (member req *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member channelName (member params *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member accept-version *)" and t = "src" and result = 1.0000000000  or 
    repr = "(parameter 0 (member cp *))" and t = "snk" and result = 1.0000000000  or 
    repr = "(member if-range *)" and t = "src" and result = 1.0000000000  or 
    repr = "(member :path *)" and t = "src" and result = 1.0000000000  or 
    repr = "(member query (member query *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member x-custom-header *)" and t = "src" and result = 1.0000000000  or 
    repr = "(parameter 1 (member linkSync *))" and t = "snk" and result = 1.0000000000  or 
    repr = "(member www-authenticate *)" and t = "src" and result = 1.0000000000  or 
    repr = "(member if-unmodified-since *)" and t = "src" and result = 1.0000000000  or 
    repr = "(parameter 2 (member cp *))" and t = "snk" and result = 1.0000000000  or 
    repr = "(parameter res (parameter 1 (member once *)))" and t = "src" and result = 1.0000000000  or 
    repr = "(member body (member req *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member referer (member headers *))" and t = "src" and result = 1.0000000000  or 
    repr = "(parameter 0 (member linkSync *))" and t = "snk" and result = 1.0000000000  or 
    repr = "(parameter resp (parameter 1 (member on *)))" and t = "src" and result = 1.0000000000  or 
    repr = "(parameter port (parameter 1 (member on *)))" and t = "src" and result = 1.0000000000  or 
    repr = "(member connection (member headers *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member if-match *)" and t = "src" and result = 1.0000000000  or 
    repr = "(member peer (member query *))" and t = "src" and result = 1.0000000000  or 
    repr = "(parameter 0 (return (member hijack *)))" and t = "snk" and result = 1.0000000000  or 
    repr = "(member referrer (member headers *))" and t = "src" and result = 1.0000000000  or 
    repr = "(parameter 1 (member cp *))" and t = "snk" and result = 1.0000000000  or 
    repr = "(member :method *)" and t = "src" and result = 1.0000000000  or 
    repr = "(member originalUrl (member req *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member order (member query *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member x-access-token *)" and t = "src" and result = 1.0000000000  or 
    repr = "(member email (member query *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member filePath (member query *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member json (member query *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member foo (member headers *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member repo (member params *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member owner (member params *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member path (member query *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member bookId (member query *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member pageSize (member query *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member user (member params *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member view (member query *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member code (member query *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member state (member query *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member demoName (member params *))" and t = "src" and result = 1.0000000000  or 
    repr = "(parameter 0 (member ls *))" and t = "snk" and result = 1.0000000000  or 
    repr = "(parameter 1 (member ls *))" and t = "snk" and result = 1.0000000000  or 
    repr = "(member title (member query *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member filter (member query *))" and t = "src" and result = 1.0000000000  or 
    repr = "(parameter 0 (parameter req *))" and t = "snk" and result = 1.0000000000  or 
    repr = "(member formname (member params *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member age16 (member query *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member sec-websocket-protocol *)" and t = "src" and result = 1.0000000000  or 
    repr = "(member sec-websocket-version *)" and t = "src" and result = 1.0000000000  or 
    repr = "(member sec-websocket-extensions *)" and t = "src" and result = 1.0000000000  or 
    repr = "(member framework (member query *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member framework (member params *))" and t = "src" and result = 1.0000000000  or 
    repr = "(parameter 0 (member config (global)))" and t = "snk" and result = 1.0000000000  or 
    repr = "(member test (member params *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member user (member query *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member event (member query *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member account (member query *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member sortField (member query *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member startTime (parameter reqQuery *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member expression (member query *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member size (member query *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member index (member query *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member line (member query *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member show (member query *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member field (member query *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member ids (member query *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member nodeName (member params *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member cancelId (member query *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member stopTime (parameter reqQuery *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member value (member params *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member desc (member query *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member stopTime (member query *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member start (member params *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member dstField (member query *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member packets (member query *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member bounding (member query *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member segments (member query *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member step (member params *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member hide (member query *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member baselineDate (member query *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member saveId (member query *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member interval (member query *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member index (member params *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member srcField (member query *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member startTime (member query *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member base (member query *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member userId (member query *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member exp (member query *))" and t = "src" and result = 1.0000000000  or 
    repr = "(parameter proxyRes (parameter 1 (member on *)))" and t = "src" and result = 1.0000000000  or 
    repr = "(member limit (member params *))" and t = "src" and result = 1.0000000000  or 
    repr = "(parameter err (parameter 1 (member addListener *)))" and t = "src" and result = 1.0000000000  or 
    repr = "(member status (member query *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member password (member query *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member x-requested-with *)" and t = "src" and result = 1.0000000000  or 
    repr = "(parameter callback (parameter 1 (member on *)))" and t = "src" and result = 1.0000000000  or 
    repr = "(parameter chunk (parameter 1 (member addListener *)))" and t = "src" and result = 1.0000000000  or 
    repr = "(member channel (member params *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member stubIndex (member params *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member 2 (member params *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member userid (member params *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member offset (member params *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member file (member params *))" and t = "src" and result = 1.0000000000  or 
    repr = "(parameter cmd (parameter 1 (member on *)))" and t = "src" and result = 1.0000000000  or 
    repr = "(member text (member params *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member fromDate (member query *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member 1 (member params *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member host (member params *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member value (member query *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member tagName (member params *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member x-foo *)" and t = "src" and result = 1.0000000000  or 
    repr = "(member offset (parameter params *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member mapid (member params *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member mode (member params *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member _id (member query *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member scope (member params *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member current (member query *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member body (parameter httpRequest *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member uid (member params *))" and t = "src" and result = 1.0000000000  or 
    repr = "(parameter channel (parameter 1 (member on *)))" and t = "src" and result = 1.0000000000  or 
    repr = "(parameter 0 (member rm *))" and t = "snk" and result = 1.0000000000  or 
    repr = "(parameter 1 (member rm *))" and t = "snk" and result = 1.0000000000  or 
    repr = "(member paging (member query *))" and t = "src" and result = 1.0000000000  or 
    repr = "(return (root https://www.npmjs.com/package/lodash/includes))" and t = "san" and result = 1.0000000000  or 
    repr = "(member event (member params *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member pageLength (member query *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member num (member params *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member language (member params *))" and t = "src" and result = 1.0000000000  or 
    repr = "(parameter filePath (parameter 1 (member on *)))" and t = "src" and result = 1.0000000000  or 
    repr = "(member username (member params *))" and t = "src" and result = 1.0000000000  or 
    repr = "(parameter position (parameter 1 (member on *)))" and t = "src" and result = 1.0000000000  or 
    repr = "(member email (member params *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member widget (member params *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member depth (member query *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member read-if-exists *)" and t = "src" and result = 1.0000000000  or 
    repr = "(member branchName (member params *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member Target (member query *))" and t = "src" and result = 1.0000000000  or 
    repr = "(parameter msg (parameter 1 (member removeListener *)))" and t = "src" and result = 1.0000000000  or 
    repr = "(member project (member params *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member parts (member query *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member template (member params *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member md5 (member query *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member item (member query *))" and t = "src" and result = 1.0000000000  or 
    repr = "(parameter i (parameter 1 (member attachEvent *)))" and t = "src" and result = 1.0000000000  or 
    repr = "(member x-broccoli *)" and t = "src" and result = 1.0000000000  or 
    repr = "(member count (member query *))" and t = "src" and result = 1.0000000000  or 
    repr = "(parameter button (parameter 1 (member on *)))" and t = "src" and result = 1.0000000000  or 
    repr = "(parameter 0 (member r (global)))" and t = "snk" and result = 1.0000000000  or 
    repr = "(parameter update (parameter 1 (member on *)))" and t = "src" and result = 1.0000000000  or 
    repr = "(parameter 0 (member utimes *))" and t = "snk" and result = 1.0000000000  or 
    repr = "(member limit (parameter params *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member originalUrl (parameter request *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member op (member query *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member gid (member params *))" and t = "src" and result = 1.0000000000  or 
    repr = "(parameter 0 (member unwatchFile *))" and t = "snk" and result = 1.0000000000  or 
    repr = "(parameter 0 (member chownSync *))" and t = "snk" and result = 1.0000000000  or 
    repr = "(parameter query_object (parameter 1 (member on *)))" and t = "src" and result = 1.0000000000  or 
    repr = "(parameter content (parameter 1 (member on *)))" and t = "src" and result = 1.0000000000  or 
    repr = "(member api (member params *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member oauth_verifier (member query *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member p (member query *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member url (parameter ctx *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member project_id (parameter $routeParams *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member x-real-ip *)" and t = "src" and result = 1.0000000000  or 
    repr = "(member rev (member params *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member bin (member params *))" and t = "src" and result = 1.0000000000  or 
    repr = "(parameter 0 (root https://www.npmjs.com/package/write-file-atomic))" and t = "snk" and result = 1.0000000000  or 
    repr = "(parameter had_error (parameter 1 (member on *)))" and t = "src" and result = 1.0000000000  or 
    repr = "(member path (parameter 0 (member Writer *)))" and t = "snk" and result = 1.0000000000  or 
    repr = "(return (root https://www.npmjs.com/package/is-path-inside))" and t = "san" and result = 1.0000000000  or 
    repr = "(member location (member params *))" and t = "src" and result = 1.0000000000  or 
    repr = "(return (member isInArray (global)))" and t = "san" and result = 1.0000000000  or 
    repr = "(member deviceId (member params *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member token (member headers *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member path (parameter 0 (member Reader *)))" and t = "snk" and result = 1.0000000000  or 
    repr = "(member decoded (member headers *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member locale (member query *))" and t = "src" and result = 1.0000000000  or 
    repr = "(parameter y (parameter 1 (member removeEventListener *)))" and t = "src" and result = 1.0000000000  or 
    repr = "(return (member inStr *))" and t = "san" and result = 1.0000000000  or 
    repr = "(parameter login (parameter 1 (member on *)))" and t = "src" and result = 1.0000000000  or 
    repr = "(member shortList (member query *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member prisonNo (member params *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member block (member params *))" and t = "src" and result = 1.0000000000  or 
    repr = "(parameter user_map (parameter 1 (member on *)))" and t = "src" and result = 1.0000000000  or 
    repr = "(parameter chat_map (parameter 1 (member on *)))" and t = "src" and result = 1.0000000000  or 
    repr = "(member obj_type (member params *))" and t = "src" and result = 1.0000000000  or 
    repr = "(parameter avtr_map (parameter 1 (member on *)))" and t = "src" and result = 1.0000000000  or 
    repr = "(member thingId (member params *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member eventName (member params *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member hostname (parameter request *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member pageNum (member params *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member tag (member params *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member teamId (member query *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member articleId (member query *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member service_slug (member params *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member feedId (member params *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member applicationName (member params *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member featureName (member params *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member period (member query *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member user_id (member query *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member Project_id (member params *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member tagId (member params *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member entity_id (member params *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member projectId (member params *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member submission_id (member params *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member rs (member query *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member v1_user_id (member params *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member x-sl-update-source *)" and t = "src" and result = 1.0000000000  or 
    repr = "(member doc_id (member params *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member currency (member query *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member overleaf.id *)" and t = "snk" and result = 0.7500000000  or 
    repr = "(member entity_type (member params *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member rm (member query *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member range (member query *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member ensureAffiliation (member query *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member build_id (member params *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member pdfng (member query *))" and t = "src" and result = 1.0000000000  or 
    repr = "(return (member setCompiler *))" and t = "snk" and result = 0.5000000000  or 
    repr = "(member tid (member params *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member avatarData (parameter requestData *))" and t = "snk" and result = 0.2500000000  or 
    repr = "(member param (member params *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member module (member params *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member pii (member params *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member journalname (member params *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member spp (member query *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member example (member params *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member moduleId (member params *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member provider (member params *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member page_id (member query *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member offset (member query *))" and t = "src" and result = 1.0000000000  or 
    repr = "(member isbn (member params *))" and t = "src" and result = 1.0000000000    
}}