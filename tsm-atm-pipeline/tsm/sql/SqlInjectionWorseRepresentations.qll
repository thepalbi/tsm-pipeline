module TsmRepr {float getReprScore(string repr, string t){
    repr = "(return (member header *))" and t = "src" and result = 1.0000000000 or
    repr = "(return (member get *))" and t = "src" and result = 1.0000000000 or
    repr = "(parameter err (parameter 1 (member on *)))" and t = "src" and result = 1.0000000000 or
    repr = "(member body (parameter req *))" and t = "src" and result = 1.0000000000 or
    repr = "(member content-length *)" and t = "src" and result = 1.0000000000 or
    repr = "(member id (member params *))" and t = "src" and result = 1.0000000000 or
    repr = "(member url (parameter req *))" and t = "src" and result = 1.0000000000 or
    repr = "(parameter data (parameter 1 (member on *)))" and t = "src" and result = 1.0000000000 or
    repr = "(return (member param *))" and t = "src" and result = 1.0000000000 or
    repr = "(member * (member headers *))" and t = "src" and result = 1.0000000000 or
    repr = "(parameter e (parameter 1 (member on *)))" and t = "src" and result = 1.0000000000 or
    repr = "(member host (member headers *))" and t = "src" and result = 1.0000000000 or
    repr = "(parameter chunk (parameter 1 (member on *)))" and t = "src" and result = 1.0000000000 or
    repr = "(member token (member query *))" and t = "src" and result = 1.0000000000 or
    repr = "(member 0 (member params *))" and t = "src" and result = 1.0000000000 or
    repr = "(member authorization (member headers *))" and t = "src" and result = 1.0000000000 or
    repr = "(member body (parameter request *))" and t = "src" and result = 1.0000000000 or
    repr = "(member csql (member query *))" and t = "src" and result = 1.0000000000 or
    repr = "(parameter 0 (parameter 1 (member on *)))" and t = "src" and result = 1.0000000000 or
    repr = "(member offset (member query *))" and t = "src" and result = 1.0000000000 or
    repr = "(return (member search *))" and t = "src" and result = 1.0000000000 or
    repr = "(member name (global))" and t = "src" and result = 1.0000000000 or
    repr = "(member limit (member query *))" and t = "src" and result = 1.0000000000 or
    repr = "(member * (member query *))" and t = "src" and result = 1.0000000000 or
    repr = "(member login (member query *))" and t = "src" and result = 1.0000000000 or
    repr = "(member files (parameter req *))" and t = "src" and result = 1.0000000000 or
    repr = "(member vuln (member params *))" and t = "src" and result = 1.0000000000 or
    repr = "(member id (member query *))" and t = "src" and result = 1.0000000000 or
    repr = "(member content-type *)" and t = "src" and result = 1.0000000000 or
    repr = "(member q (member query *))" and t = "src" and result = 1.0000000000 or
    repr = "(member coupon (member params *))" and t = "src" and result = 1.0000000000 or
    repr = "(member cookies (parameter req *))" and t = "src" and result = 1.0000000000 or
    repr = "(member to (member query *))" and t = "src" and result = 1.0000000000 or
    repr = "(member callback (member query *))" and t = "src" and result = 1.0000000000 or
    repr = "(member user-agent *)" and t = "src" and result = 1.0000000000 or
    repr = "(member x-user-email *)" and t = "src" and result = 1.0000000000 or
    repr = "(parameter entry (parameter 1 (member on *)))" and t = "src" and result = 1.0000000000 or
    repr = "(member originalUrl (parameter req *))" and t = "src" and result = 1.0000000000 or
    repr = "(member file (member params *))" and t = "src" and result = 1.0000000000 or
    repr = "(member email (member query *))" and t = "src" and result = 1.0000000000 or
    repr = "(member name (member params *))" and t = "src" and result = 1.0000000000 or
    repr = "(member userId (member params *))" and t = "src" and result = 1.0000000000 or
    repr = "(member action (member params *))" and t = "src" and result = 1.0000000000 or
    repr = "(member username (member query *))" and t = "src" and result = 1.0000000000 or
    repr = "(member category (member params *))" and t = "src" and result = 1.0000000000 or
    repr = "(parameter callback (parameter 1 (member on *)))" and t = "src" and result = 1.0000000000 or
    repr = "(parameter e (member onmessage *))" and t = "src" and result = 1.0000000000 or
    repr = "(member nodeId (member params *))" and t = "src" and result = 1.0000000000 or
    repr = "(member redirect (member query *))" and t = "src" and result = 1.0000000000 or
    repr = "(member datasetId (member params *))" and t = "src" and result = 1.0000000000 or
    repr = "(member state (member query *))" and t = "src" and result = 1.0000000000 or
    repr = "(member mode (member query *))" and t = "src" and result = 1.0000000000 or
    repr = "(member version (member query *))" and t = "src" and result = 1.0000000000 or
    repr = "(member rpc (member query *))" and t = "src" and result = 1.0000000000 or
    repr = "(member page (member query *))" and t = "src" and result = 1.0000000000 or
    repr = "(member shortname (member params *))" and t = "src" and result = 1.0000000000 or
    repr = "(member num (member params *))" and t = "src" and result = 1.0000000000 or
    repr = "(member status (member query *))" and t = "src" and result = 1.0000000000 or
    repr = "(member name (member query *))" and t = "src" and result = 1.0000000000 or
    repr = "(member search (member query *))" and t = "src" and result = 1.0000000000 or
    repr = "(member pivot (member query *))" and t = "src" and result = 1.0000000000 or
    repr = "(member sort (member query *))" and t = "src" and result = 1.0000000000
    or
    repr = "(parameter 0 (member query *))" and t = "snk" and result = 1.0000000000 or
    repr = "(parameter 0 (member get *))" and t = "snk" and result = 1.0000000000 or
    repr = "(parameter 0 (member create *))" and t = "snk" and result = 0.2500000000 or
    repr = "(parameter 1 (member query *))" and t = "snk" and result = 0.7500000000 or
    repr = "(parameter 0 (member all *))" and t = "snk" and result = 1.0000000000 or
    repr = "(parameter 0 (member each *))" and t = "snk" and result = 1.0000000000 or
    repr = "(member where (parameter 0 (member findOne *)))" and t = "snk" and result = 0.5000000000 or
    repr = "(parameter 0 (member findOne *))" and t = "snk" and result = 0.5000000000 or
    repr = "(parameter 0 (member run *))" and t = "snk" and result = 1.0000000000 or
    repr = "(parameter 1 (member run *))" and t = "snk" and result = 0.5000000000 or
    repr = "(parameter 0 (member updateAttributes *))" and t = "snk" and result = 0.7500000000
    or
    repr = "(return (member parse *))" and t = "san" and result = 0.7500000000 or
    repr = "(return (member stringify *))" and t = "san" and result = 0.2500000000 or
    repr = "(return (member join *))" and t = "san" and result = 0.2500000000 or
    repr = "(return (member split *))" and t = "san" and result = 0.2500000000 or
    repr = "(return (member substring *))" and t = "san" and result = 0.7500000000 or
    repr = "(return (member toString *))" and t = "san" and result = 0.5000000000 or
    repr = "(return (member call *))" and t = "san" and result = 0.7500000000 or
    repr = "(return (member trim *))" and t = "san" and result = 0.5000000000 or
    repr = "(return (member create *))" and t = "san" and result = 0.2500000000 or
    repr = "(return (member test *))" and t = "san" and result = 0.7500000000 or
    repr = "(return (member decodeURIComponent (global)))" and t = "san" and result = 0.5000000000 or
    repr = "(return (member verify *))" and t = "san" and result = 0.7500000000 or
    repr = "(return (member parseInt (global)))" and t = "san" and result = 1.0000000000 or
    repr = "(return (member hashSync *))" and t = "san" and result = 0.7500000000 or
    repr = "(return (member hash *))" and t = "san" and result = 0.7500000000 or
    repr = "(return (member escape *))" and t = "san" and result = 1.0000000000 or
    repr = "(return (root https://www.npmjs.com/package/md5))" and t = "san" and result = 0.7500000000 or
    repr = "(return (member getSqlQuery *))" and t = "san" and result = 0.2500000000
}}