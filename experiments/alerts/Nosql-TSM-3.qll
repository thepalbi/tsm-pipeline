module TsmRepr {
  float getReprScore(string repr, string t){
   repr = "(parameter 0 (member Image *))" and t = "snk" and result = 0.7500000000 or
   repr = "(parameter 0 (member aggregate *))" and t = "snk" and result = 0.3333333333 or
   repr = "(parameter 0 (member bulk *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 0 (member call *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 0 (member count *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member countDocuments *))" and t = "snk" and result = 0.5000000000 or
   repr = "(parameter 0 (member create *))" and t = "snk" and result = 0.5000000000 or
   repr = "(parameter 0 (member end *))" and t = "snk" and result = 0.4166666667 or
   repr = "(parameter 0 (member existsSync *))" and t = "snk" and result = 0.1250000000 or
   repr = "(parameter 0 (member find *))" and t = "snk" and result = 0.9562500000 or
   repr = "(parameter 0 (member findAndModify *))" and t = "snk" and result = 0.5000000000 or
   repr = "(parameter 0 (member findById *))" and t = "snk" and result = 0.1250000000 or
   repr = "(parameter 0 (member findByIdAndUpdate *))" and t = "snk" and result = 0.5000000000 or
   repr = "(parameter 0 (member findOne *))" and t = "snk" and result = 0.3472222222 or
   repr = "(parameter 0 (member get *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 0 (member id *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 0 (member insert *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 0 (member json *))" and t = "snk" and result = 0.4826388892 or
   repr = "(parameter 0 (member jsonp *))" and t = "snk" and result = 0.5000000000 or
   repr = "(parameter 0 (member limit *))" and t = "snk" and result = 0.3750000000 or
   repr = "(parameter 0 (member listAsStream *))" and t = "snk" and result = 0.5000000000 or
   repr = "(parameter 0 (member mkdirSync *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 0 (member model *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 0 (member pbkdf2Sync *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 0 (member push *))" and t = "snk" and result = 0.5000000000 or
   repr = "(parameter 0 (member readFileSync *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 0 (member redirect *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 0 (member remove *))" and t = "snk" and result = 0.5000000000 or
   repr = "(parameter 0 (member request *))" and t = "snk" and result = 0.5000000000 or
   repr = "(parameter 0 (member send *))" and t = "snk" and result = 0.5625000000 or
   repr = "(parameter 0 (member sendFile *))" and t = "snk" and result = 0.7500000000 or
   repr = "(parameter 0 (member set *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 0 (member sort *))" and t = "snk" and result = 0.3750000000 or
   repr = "(parameter 0 (member subtract *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 0 (member trim *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 0 (member unlinkSync *))" and t = "snk" and result = 0.2083333333 or
   repr = "(parameter 0 (member update *))" and t = "snk" and result = 0.3125000000 or
   repr = "(parameter 0 (member updateOne *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 0 (member urlModel *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 0 (member wrapSend *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 0 (member write *))" and t = "snk" and result = 0.7500000000 or
   repr = "(parameter 0 (member writeFileSync *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 0 (return (member getModel *)))" and t = "snk" and result = 0.3750000000 or
   repr = "(parameter 0 (return (member model *)))" and t = "snk" and result = 0.5000000000 or
   repr = "(parameter 0 (return (member promisify *)))" and t = "snk" and result = 0.4375000000 or
   repr = "(parameter 1 (member addVotetoId *))" and t = "snk" and result = 0.1666666700 or
   repr = "(parameter 1 (member bind *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 1 (member createHmac *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 1 (member distinct *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 1 (member find *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 1 (member findByIdAndUpdate *))" and t = "snk" and result = 0.3333333350 or
   repr = "(parameter 1 (member findOneAndUpdate *))" and t = "snk" and result = 0.3333333333 or
   repr = "(parameter 1 (member once *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 1 (member pbkdf2Sync *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 1 (member rename *))" and t = "snk" and result = 0.5000000000 or
   repr = "(parameter 1 (member renameSync *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 1 (member render *))" and t = "snk" and result = 0.3500000000 or
   repr = "(parameter 1 (member set *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 1 (member slice *))" and t = "snk" and result = 0.5000000000 or
   repr = "(parameter 1 (member update *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 1 (member updateArticleVotes *))" and t = "snk" and result = 0.1666666700 or
   repr = "(parameter 1 (member wrapRender *))" and t = "snk" and result = 0.5000000000 or
   repr = "(parameter 1 (member writeHead *))" and t = "snk" and result = 0.7500000000 or
   repr = "(parameter 1 (parameter next (member protect *)))" and t = "snk" and result = 0.1250000000 or
   repr = "(parameter 1 (return (member getTranslatorForEmail *)))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 1 (return (member getTranslatorForUser *)))" and t = "snk" and result = 0.5000000000 or
   repr = "(parameter 2 (member setex *))" and t = "snk" and result = 0.2500000000
   } 
}
