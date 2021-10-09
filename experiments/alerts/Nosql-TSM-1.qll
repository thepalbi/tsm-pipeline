module TsmRepr {
  float getReprScore(string repr, string t){
   repr = "(parameter 0 (member Image *))" and t = "snk" and result = 0.7500000000 or
   repr = "(parameter 0 (member Log *))" and t = "snk" and result = 0.5000000000 or
   repr = "(parameter 0 (member Node *))" and t = "snk" and result = 0.3333333300 or
   repr = "(parameter 0 (member Rental *))" and t = "snk" and result = 0.7500000000 or
   repr = "(parameter 0 (member User (global)))" and t = "snk" and result = 0.5000000000 or
   repr = "(parameter 0 (member aggregate *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 0 (member bulk *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 0 (member count *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member create *))" and t = "snk" and result = 0.5000000000 or
   repr = "(parameter 0 (member end *))" and t = "snk" and result = 0.0833333330 or
   repr = "(parameter 0 (member exists *))" and t = "snk" and result = 0.0833333330 or
   repr = "(parameter 0 (member find *))" and t = "snk" and result = 0.9728260870 or
   repr = "(parameter 0 (member findAndModify *))" and t = "snk" and result = 0.5000000000 or
   repr = "(parameter 0 (member findById *))" and t = "snk" and result = 0.7500000000 or
   repr = "(parameter 0 (member findByIdAndUpdate *))" and t = "snk" and result = 0.5000000000 or
   repr = "(parameter 0 (member findOne *))" and t = "snk" and result = 0.3518518522 or
   repr = "(parameter 0 (member findOneAndRemove *))" and t = "snk" and result = 0.1666666700 or
   repr = "(parameter 0 (member findOneAndUpdate *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 0 (member get *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 0 (member id *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 0 (member insert *))" and t = "snk" and result = 0.2916666667 or
   repr = "(parameter 0 (member json *))" and t = "snk" and result = 0.4791666670 or
   repr = "(parameter 0 (member limit *))" and t = "snk" and result = 0.3750000000 or
   repr = "(parameter 0 (member listAsStream *))" and t = "snk" and result = 0.5000000000 or
   repr = "(parameter 0 (member mkdirSync *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 0 (member model *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 0 (member pbkdf2Sync *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 0 (member push *))" and t = "snk" and result = 0.5000000000 or
   repr = "(parameter 0 (member readFile *))" and t = "snk" and result = 0.0833333330 or
   repr = "(parameter 0 (member redirect *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 0 (member request *))" and t = "snk" and result = 0.5000000000 or
   repr = "(parameter 0 (member send *))" and t = "snk" and result = 0.5694444450 or
   repr = "(parameter 0 (member set *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 0 (member sort *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 0 (member statSync *))" and t = "snk" and result = 0.0833333330 or
   repr = "(parameter 0 (member subtract *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 0 (member toDate *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 0 (member unlinkSync *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 0 (member update *))" and t = "snk" and result = 0.3194444450 or
   repr = "(parameter 0 (member updateOne *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 0 (member users *))" and t = "snk" and result = 0.5000000000 or
   repr = "(parameter 0 (member whitelist *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 0 (member writeFileSync *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 0 (parameter 0 (member getquerySendResponse *)))" and t = "snk" and result = 0.5000000000 or
   repr = "(parameter 0 (return (member getModel *)))" and t = "snk" and result = 0.5000000000 or
   repr = "(parameter 0 (return (member model *)))" and t = "snk" and result = 0.5000000000 or
   repr = "(parameter 0 (return (member promisify *)))" and t = "snk" and result = 0.6250000000 or
   repr = "(parameter 1 (member addVotetoId *))" and t = "snk" and result = 0.1666666700 or
   repr = "(parameter 1 (member createHmac *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 1 (member distinct *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 1 (member find *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 1 (member findByIdAndUpdate *))" and t = "snk" and result = 0.3888888900 or
   repr = "(parameter 1 (member findOneAndUpdate *))" and t = "snk" and result = 0.3750000000 or
   repr = "(parameter 1 (member pbkdf2Sync *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 1 (member rename *))" and t = "snk" and result = 0.5000000000 or
   repr = "(parameter 1 (member renameSync *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 1 (member render *))" and t = "snk" and result = 0.3750000000 or
   repr = "(parameter 1 (member set *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 1 (member update *))" and t = "snk" and result = 0.4166666675 or
   repr = "(parameter 1 (member updateArticleVotes *))" and t = "snk" and result = 0.1666666700 or
   repr = "(parameter 1 (return (member getTranslatorForEmail *)))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 1 (return (member getTranslatorForUser *)))" and t = "snk" and result = 0.5000000000
   } 
}
