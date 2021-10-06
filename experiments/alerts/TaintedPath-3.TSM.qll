module TsmRepr {
  float getReprScore(string repr, string t){
   repr = "(member * (member deferredTpdsFlushCounter *))" and t = "snk" and result = 0.1250000000 or
   repr = "(member * (parameter 0 (member getUser *)))" and t = "snk" and result = 0.2500000000 or
   repr = "(member * (parameter 1 (member executeQuery *)))" and t = "snk" and result = 0.2500000000 or
   repr = "(member * (parameter 1 (member update *)))" and t = "snk" and result = 0.0714285710 or
   repr = "(member * (parameter 1 (member writeHead *)))" and t = "snk" and result = 0.3571428570 or
   repr = "(member * (return (member split *)))" and t = "snk" and result = 0.2500000000 or
   repr = "(member Content-Length (member headers *))" and t = "snk" and result = 0.2500000000 or
   repr = "(member Location (parameter 1 (member writeHead *)))" and t = "snk" and result = 0.1250000000 or
   repr = "(member _id (parameter 0 (member getUser *)))" and t = "snk" and result = 0.2500000000 or
   repr = "(member _id (parameter 0 (member updateOne *)))" and t = "snk" and result = 0.1250000000 or
   repr = "(member admin_id (parameter 0 (member findOne *)))" and t = "snk" and result = 0.2500000000 or
   repr = "(member args (member ctorMsg *))" and t = "snk" and result = 0.1250000000 or
   repr = "(member bcHash (member $set *))" and t = "snk" and result = 0.0714285710 or
   repr = "(member bcMeta (member data *))" and t = "snk" and result = 0.2500000000 or
   repr = "(member bc_hash (parameter 1 (parameter callback *)))" and t = "snk" and result = 0.0714285710 or
   repr = "(member body (parameter 0 (member apiRequest *)))" and t = "snk" and result = 0.1250000000 or
   repr = "(member body (parameter 0 (member post *)))" and t = "snk" and result = 0.5000000000 or
   repr = "(member compiler (parameter 1 (member render *)))" and t = "snk" and result = 0.2500000000 or
   repr = "(member compiler (parameter 1 (member update *)))" and t = "snk" and result = 0.5000000000 or
   repr = "(member content (parameter 1 (member emit *)))" and t = "snk" and result = 0.5000000000 or
   repr = "(member ctorMsg (member params *))" and t = "snk" and result = 0.1250000000 or
   repr = "(member data (parameter 0 (member json *)))" and t = "snk" and result = 0.2500000000 or
   repr = "(member data (parameter 1 (member emit *)))" and t = "snk" and result = 0.5000000000 or
   repr = "(member data (parameter 1 (member render *)))" and t = "snk" and result = 0.2500000000 or
   repr = "(member dbHash (member $set *))" and t = "snk" and result = 0.0714285710 or
   repr = "(member deferredTpdsFlushCounter (parameter 0 (member updateOne *)))" and t = "snk" and result = 0.1250000000 or
   repr = "(member end (parameter 1 (member createReadStream *)))" and t = "snk" and result = 0.0714285710 or
   repr = "(member evidenceId (member $set *))" and t = "snk" and result = 0.0714285710 or
   repr = "(member evidence_id (parameter 1 (parameter callback *)))" and t = "snk" and result = 0.0714285710 or
   repr = "(member formdatas (parameter 1 (member render *)))" and t = "snk" and result = 0.2500000000 or
   repr = "(member host (parameter 2 (member request *)))" and t = "snk" and result = 0.1250000000 or
   repr = "(member id (parameter 0 (member push *)))" and t = "snk" and result = 0.1250000000 or
   repr = "(member id (parameter 0 (member send *)))" and t = "snk" and result = 0.3750000000 or
   repr = "(member input_file_uri (parameter 0 (member json *)))" and t = "snk" and result = 0.0833333330 or
   repr = "(member isIE (parameter response *))" and t = "snk" and result = 0.5000000000 or
   repr = "(member items (parameter 0 (member send *)))" and t = "snk" and result = 0.2500000000 or
   repr = "(member json (parameter 0 (root https://www.npmjs.com/package/request)))" and t = "snk" and result = 0.1250000000 or
   repr = "(member jsonData (instance (member SamlLog *)))" and t = "snk" and result = 0.5000000000 or
   repr = "(member log (parameter 0 (member AdminLog *)))" and t = "snk" and result = 0.5000000000 or
   repr = "(member loginId (parameter 0 (member findOne *)))" and t = "snk" and result = 0.5000000000 or
   repr = "(member message (parameter 0 (member json *)))" and t = "snk" and result = 0.1666666700 or
   repr = "(member params (member json *))" and t = "snk" and result = 0.1250000000 or
   repr = "(member path (parameter 0 (member request *)))" and t = "snk" and result = 0.2500000000 or
   repr = "(member plan (parameter 1 (member render *)))" and t = "snk" and result = 0.5000000000 or
   repr = "(member result (parameter 1 (member render *)))" and t = "snk" and result = 0.1666666665 or
   repr = "(member setNewPasswordUrl (parameter 1 (member sendEmail *)))" and t = "snk" and result = 0.2500000000 or
   repr = "(member showNotification (parameter 0 (member json *)))" and t = "snk" and result = 0.5000000000 or
   repr = "(member size (member page *))" and t = "snk" and result = 0.5000000000 or
   repr = "(member start (parameter 1 (member createReadStream *)))" and t = "snk" and result = 0.0714285710 or
   repr = "(member sunburst (parameter 1 (member render *)))" and t = "snk" and result = 0.5000000000 or
   repr = "(member templateUrl (return (parameter 1 (member directive *))))" and t = "snk" and result = 1.0000000000 or
   repr = "(member templateUrl *)" and t = "snk" and result = 1.0000000000 or
   repr = "(member text (member body *))" and t = "snk" and result = 0.2500000000 or
   repr = "(member text (member message *))" and t = "snk" and result = 0.1666666700 or
   repr = "(member uri (parameter 0 (root https://www.npmjs.com/package/request)))" and t = "snk" and result = 0.1250000000 or
   repr = "(member url (member opts *))" and t = "snk" and result = 0.5000000000 or
   repr = "(member url (parameter 0 (root https://www.npmjs.com/package/request)))" and t = "snk" and result = 0.5000000000 or
   repr = "(member user *)" and t = "snk" and result = 0.1250000000 or
   repr = "(parameter 0 (member AdminLog *))" and t = "snk" and result = 0.5000000000 or
   repr = "(parameter 0 (member URL *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 0 (member access *))" and t = "snk" and result = 0.7222222233 or
   repr = "(parameter 0 (member accessSync *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member appendFile *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member appendFileSync *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member attachment *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 0 (member cd *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member chmod *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member chmodSync *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member chown *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member cp *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member createClient *))" and t = "snk" and result = 0.1250000000 or
   repr = "(parameter 0 (member createReadStream *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member createWriteStream *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member define (global)))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member end *))" and t = "snk" and result = 0.2969696973 or
   repr = "(parameter 0 (member equal *))" and t = "snk" and result = 0.1500000000 or
   repr = "(parameter 0 (member equals *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 0 (member exists *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member existsSync *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member exit *))" and t = "snk" and result = 0.7500000000 or
   repr = "(parameter 0 (member findOne *))" and t = "snk" and result = 0.3750000000 or
   repr = "(parameter 0 (member flushProjectToMongo *))" and t = "snk" and result = 0.1250000000 or
   repr = "(parameter 0 (member get *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 0 (member getUserByMainEmail *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 0 (member indexOf *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 0 (member isNull *))" and t = "snk" and result = 0.5000000000 or
   repr = "(parameter 0 (member isUndefined *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 0 (member item *))" and t = "snk" and result = 0.5000000000 or
   repr = "(parameter 0 (member json *))" and t = "snk" and result = 0.3809523814 or
   repr = "(parameter 0 (member jsonp *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 0 (member justSend *))" and t = "snk" and result = 0.5000000000 or
   repr = "(parameter 0 (member limit *))" and t = "snk" and result = 0.0833333330 or
   repr = "(parameter 0 (member link *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member ls *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member lstat *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member lstatSync *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member map *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 0 (member mkdir *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member mkdirSync *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member mv *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member open *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member openSync *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member pipe *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 0 (member post *))" and t = "snk" and result = 0.5000000000 or
   repr = "(parameter 0 (member puts *))" and t = "snk" and result = 0.5000000000 or
   repr = "(parameter 0 (member readFile *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member readFileSync *))" and t = "snk" and result = 0.9863636364 or
   repr = "(parameter 0 (member readdir *))" and t = "snk" and result = 0.9711538462 or
   repr = "(parameter 0 (member readdirSync *))" and t = "snk" and result = 0.9722222222 or
   repr = "(parameter 0 (member readlink *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member readlinkSync *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member redirect *))" and t = "snk" and result = 0.3500000000 or
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
   repr = "(parameter 0 (member send *))" and t = "snk" and result = 0.4837662336 or
   repr = "(parameter 0 (member sendFile *))" and t = "snk" and result = 0.1666666700 or
   repr = "(parameter 0 (member sendfile *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 0 (member slice *))" and t = "snk" and result = 0.5000000000 or
   repr = "(parameter 0 (member stat *))" and t = "snk" and result = 0.9652777779 or
   repr = "(parameter 0 (member statSync *))" and t = "snk" and result = 0.9765625000 or
   repr = "(parameter 0 (member symlink *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member symlinkSync *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member sync *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member timingSafeEqual *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 0 (member truncateSync *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member unlink *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member unlinkSync *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member update *))" and t = "snk" and result = 0.4166666667 or
   repr = "(parameter 0 (member updateOne *))" and t = "snk" and result = 0.1250000000 or
   repr = "(parameter 0 (member utimes *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member utimesSync *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member watch *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member watchFile *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member write *))" and t = "snk" and result = 0.3928571429 or
   repr = "(parameter 0 (member writeFile *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member writeFileSync *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (parameter callback (member setUserPasswordInV2 *)))" and t = "snk" and result = 0.1666666700 or
   repr = "(parameter 0 (return (member hijack *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (root https://www.npmjs.com/package/request))" and t = "snk" and result = 0.3839285714 or
   repr = "(parameter 0 (root https://www.npmjs.com/package/resolve))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 1 (member basename *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 1 (member cp *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 1 (member createClient *))" and t = "snk" and result = 0.1250000000 or
   repr = "(parameter 1 (member createProjectFromZipArchive *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 1 (member createReadStream *))" and t = "snk" and result = 0.0714285710 or
   repr = "(parameter 1 (member define (global)))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 1 (member emit *))" and t = "snk" and result = 0.5178571425 or
   repr = "(parameter 1 (member flash *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 1 (member get *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 1 (member link *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 1 (member mkdir *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 1 (member mv *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 1 (member on *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 1 (member redirect *))" and t = "snk" and result = 0.7500000000 or
   repr = "(parameter 1 (member rename *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 1 (member renameSync *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 1 (member render *))" and t = "snk" and result = 0.3333333338 or
   repr = "(parameter 1 (member request *))" and t = "snk" and result = 0.1250000000 or
   repr = "(parameter 1 (member rm *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 1 (member set *))" and t = "snk" and result = 0.5000000000 or
   repr = "(parameter 1 (member setHeader *))" and t = "snk" and result = 0.3750000000 or
   repr = "(parameter 1 (member substring *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 1 (member symlink *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 1 (member symlinkSync *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 1 (member update *))" and t = "snk" and result = 0.2857142855 or
   repr = "(parameter 1 (member writeFile *))" and t = "snk" and result = 0.3333333333 or
   repr = "(parameter 1 (member writeFileSync *))" and t = "snk" and result = 0.5000000000 or
   repr = "(parameter 1 (member writeHead *))" and t = "snk" and result = 0.2718253968 or
   repr = "(parameter 1 (parameter callback (member _checkForConflictingPaths *)))" and t = "snk" and result = 0.1666666700 or
   repr = "(parameter 1 (parameter callback *))" and t = "snk" and result = 0.0714285710 or
   repr = "(parameter 1 (parameter cb (member registered *)))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 1 (return (member once *)))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 1 (root https://www.npmjs.com/package/assert))" and t = "snk" and result = 0.1500000000 or
   repr = "(parameter 2 (member cp *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 2 (member equal *))" and t = "snk" and result = 0.1500000000 or
   repr = "(parameter 2 (member request *))" and t = "snk" and result = 0.1250000000 or
   repr = "(return (member * (parameter 0 (member series *))))" and t = "snk" and result = 0.5000000000 or
   repr = "(return (member _sendMessages *))" and t = "snk" and result = 0.5000000000 or
   repr = "(return (member acceptInvite *))" and t = "snk" and result = 0.2500000000 or
   repr = "(return (member add *))" and t = "snk" and result = 0.2500000000 or
   repr = "(return (member cancelV1Subscription *))" and t = "snk" and result = 0.2500000000 or
   repr = "(return (member compileAndDownloadPdf *))" and t = "snk" and result = 0.7500000000 or
   repr = "(return (member conflictedPaths *))" and t = "snk" and result = 0.2500000000 or
   repr = "(return (member createBlankProject *))" and t = "snk" and result = 0.2500000000 or
   repr = "(return (member createInvite *))" and t = "snk" and result = 0.2500000000 or
   repr = "(return (member createProject *))" and t = "snk" and result = 0.5000000000 or
   repr = "(return (member deactivateOldProjects *))" and t = "snk" and result = 0.2500000000 or
   repr = "(return (member deleteProjectContents *))" and t = "snk" and result = 0.5000000000 or
   repr = "(return (member downloadMultipleProjects *))" and t = "snk" and result = 0.2500000000 or
   repr = "(return (member exportProject *))" and t = "snk" and result = 0.2500000000 or
   repr = "(return (member findAllUsersProjects *))" and t = "snk" and result = 0.2500000000 or
   repr = "(return (member findManagedSubscription *))" and t = "snk" and result = 0.2500000000 or
   repr = "(return (member getAllDocs *))" and t = "snk" and result = 0.2500000000 or
   repr = "(return (member getDoc *))" and t = "snk" and result = 0.2500000000 or
   repr = "(return (member getFileFromClsiWithoutUser *))" and t = "snk" and result = 0.2500000000 or
   repr = "(return (member getFileStream *))" and t = "snk" and result = 0.5000000000 or
   repr = "(return (member getHistoryId *))" and t = "snk" and result = 0.2500000000 or
   repr = "(return (member getLabels *))" and t = "snk" and result = 0.2500000000 or
   repr = "(return (member getMessages *))" and t = "snk" and result = 0.2500000000 or
   repr = "(return (member getPage *))" and t = "snk" and result = 0.2500000000 or
   repr = "(return (member getProject *))" and t = "snk" and result = 0.2500000000 or
   repr = "(return (member getProjectWithoutDocLines *))" and t = "snk" and result = 0.2500000000 or
   repr = "(return (member getUserIndividualSubscription *))" and t = "snk" and result = 0.2500000000 or
   repr = "(return (member getV1Template *))" and t = "snk" and result = 0.2500000000 or
   repr = "(return (member historyVersion *))" and t = "snk" and result = 0.2500000000 or
   repr = "(return (member index *))" and t = "snk" and result = 0.2500000000 or
   repr = "(return (member indexAll *))" and t = "snk" and result = 0.2500000000 or
   repr = "(return (member inviteToProject *))" and t = "snk" and result = 0.2500000000 or
   repr = "(return (member mergeUpdate *))" and t = "snk" and result = 0.2500000000 or
   repr = "(return (member plansPage *))" and t = "snk" and result = 0.2500000000 or
   repr = "(return (member processUpgradeToAnnualPlan *))" and t = "snk" and result = 0.5000000000 or
   repr = "(return (member recurlyCallback *))" and t = "snk" and result = 0.2500000000 or
   repr = "(return (member redirectToSubscriptionGroupAdminPage *))" and t = "snk" and result = 0.2500000000 or
   repr = "(return (member resendInvite *))" and t = "snk" and result = 0.2500000000 or
   repr = "(return (member restoreFileFromV2 *))" and t = "snk" and result = 0.2500000000 or
   repr = "(return (member selectHistoryApi *))" and t = "snk" and result = 0.2500000000 or
   repr = "(return (member sendMessage *))" and t = "snk" and result = 0.2500000000 or
   repr = "(return (member setCompiler *))" and t = "snk" and result = 0.2500000000 or
   repr = "(return (member setHistoryId *))" and t = "snk" and result = 0.2500000000 or
   repr = "(return (member setImageName *))" and t = "snk" and result = 0.2500000000 or
   repr = "(return (member setRootDocAutomatically *))" and t = "snk" and result = 0.2500000000 or
   repr = "(return (member sizeCheck *))" and t = "snk" and result = 0.5000000000 or
   repr = "(return (member stopCompile *))" and t = "snk" and result = 0.2500000000 or
   repr = "(return (member updateProject *))" and t = "snk" and result = 0.5000000000 or
   repr = "(return (member uploadProject *))" and t = "snk" and result = 0.2500000000 or
   repr = "(return (member upsertDocWithPath *))" and t = "snk" and result = 0.2500000000 or
   repr = "(return (member user *))" and t = "snk" and result = 0.2500000000 or
   repr = "(return (member v1SubscriptionStatus *))" and t = "snk" and result = 0.2500000000 or
   repr = "(return (parameter 0 (member initializeProject *)))" and t = "snk" and result = 0.2500000000 or
   repr = "(return (parameter 0 (member save *)))" and t = "snk" and result = 0.3750000000 or
   repr = "(return (parameter 1 (member auto *)))" and t = "snk" and result = 0.2500000000 or
   repr = "(return (parameter 1 (member delete *)))" and t = "snk" and result = 0.1666666700 or
   repr = "(return (parameter 1 (member ensureHistoryExistsForProject *)))" and t = "snk" and result = 0.2500000000 or
   repr = "(return (parameter 1 (member ensureRootDocumentIsValid *)))" and t = "snk" and result = 0.2500000000 or
   repr = "(return (parameter 1 (member exists *)))" and t = "snk" and result = 0.2500000000 or
   repr = "(return (parameter 1 (member findManagedSubscription *)))" and t = "snk" and result = 0.5000000000 or
   repr = "(return (parameter 1 (member findOne *)))" and t = "snk" and result = 0.5000000000 or
   repr = "(return (parameter 1 (member flushMultipleProjectsToMongo *)))" and t = "snk" and result = 0.2500000000 or
   repr = "(return (parameter 1 (member get *)))" and t = "snk" and result = 0.3055555567 or
   repr = "(return (parameter 1 (member getInvitedCollaboratorCount *)))" and t = "snk" and result = 0.5000000000 or
   repr = "(return (parameter 1 (member on *)))" and t = "snk" and result = 0.2500000000 or
   repr = "(return (parameter 1 (member post *)))" and t = "snk" and result = 0.2500000000 or
   repr = "(return (parameter 1 (member readFile *)))" and t = "snk" and result = 0.2500000000 or
   repr = "(return (parameter 1 (member readdir *)))" and t = "snk" and result = 0.1666666700 or
   repr = "(return (parameter 1 (member series *)))" and t = "snk" and result = 0.5000000000 or
   repr = "(return (parameter 1 (root https://www.npmjs.com/package/request)))" and t = "snk" and result = 0.5000000000 or
   repr = "(return (parameter 2 (member addAllDocsToArchive *)))" and t = "snk" and result = 0.7500000000 or
   repr = "(return (parameter 2 (member createBlankProject *)))" and t = "snk" and result = 0.2500000000 or
   repr = "(return (parameter 2 (member find *)))" and t = "snk" and result = 0.2500000000 or
   repr = "(return (parameter 2 (member isUserInvitedMemberOfProject *)))" and t = "snk" and result = 0.2500000000 or
   repr = "(return (parameter 2 (member put *)))" and t = "snk" and result = 0.3333333350 or
   repr = "(return (parameter 2 (member readFile *)))" and t = "snk" and result = 0.2500000000 or
   repr = "(return (parameter 2 (member setHistoryId *)))" and t = "snk" and result = 0.5000000000 or
   repr = "(return (parameter 2 (member update *)))" and t = "snk" and result = 0.5000000000 or
   repr = "(return (return (member rateLimit *)))" and t = "snk" and result = 0.5000000000 or
   repr = "(return (return (member validateCaptcha *)))" and t = "snk" and result = 0.5000000000
   } 
}
