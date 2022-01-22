module TsmRepr {float getReprScore(string repr, string t){
    repr = "(member 0 (member params (parameter req *)))" and t = "src" and result = 1.0000000000  or 
    repr = "(member body (parameter req (parameter 1 (member post *))))" and t = "src" and result = 1.0000000000  or 
    repr = "(member code (member params (parameter req *)))" and t = "src" and result = 1.0000000000  or 
    repr = "(member foreign (parameter 1 (member render *)))" and t = "snk" and result = 0.5000000000  or 
    repr = "(member host (parameter req (parameter 1 (member all *))))" and t = "src" and result = 1.0000000000  or 
    repr = "(member hostname (parameter req (parameter 1 (member get *))))" and t = "src" and result = 1.0000000000  or 
    repr = "(member isbn (member params (parameter req *)))" and t = "src" and result = 1.0000000000  or 
    repr = "(member key (member query (parameter req *)))" and t = "src" and result = 1.0000000000  or 
    repr = "(member lang (member params (parameter req *)))" and t = "src" and result = 1.0000000000  or 
    repr = "(member originalUrl (parameter req (parameter 1 (member all *))))" and t = "src" and result = 1.0000000000  or 
    repr = "(member pisgfile (member params (parameter req *)))" and t = "src" and result = 1.0000000000  or 
    repr = "(member returnTo (member query (parameter req *)))" and t = "src" and result = 1.0000000000  or 
    repr = "(member slug (member params (parameter req *)))" and t = "src" and result = 1.0000000000  or 
    repr = "(member user (member params (parameter req *)))" and t = "src" and result = 1.0000000000  or 
    repr = "(parameter 0 (member mkdirSync *))" and t = "snk" and result = 1.0000000000  or 
    repr = "(parameter 0 (member readFile *))" and t = "snk" and result = 1.0000000000  or 
    repr = "(parameter 0 (member readFileSync *))" and t = "snk" and result = 1.0000000000  or 
    repr = "(parameter 0 (member render *))" and t = "snk" and result = 1.0000000000  or 
    repr = "(parameter 0 (member unlink *))" and t = "snk" and result = 1.0000000000  or 
    repr = "(parameter 0 (member unlinkSync *))" and t = "snk" and result = 1.0000000000  or 
    repr = "(parameter 0 (member writeFileSync *))" and t = "snk" and result = 1.0000000000  or 
    repr = "(parameter 1 (member render *))" and t = "snk" and result = 0.5000000000  or 
    repr = "(parameter 1 (member writeFileSync *))" and t = "snk" and result = 0.2500000000  or 
    repr = "(return (member Boolean (global)))" and t = "san" and result = 0.2500000000  or 
    repr = "(return (member get (root https://www.npmjs.com/package/classify2)))" and t = "san" and result = 0.2500000000  or 
    repr = "(return (member getCatalog (global)))" and t = "san" and result = 0.7500000000  or 
    repr = "(return (member hasOwnProperty (member electorate *)))" and t = "san" and result = 1.0000000000  or 
    repr = "(return (member hasOwnProperty (member keys *)))" and t = "san" and result = 1.0000000000  or 
    repr = "(return (member includes (member logFiles *)))" and t = "san" and result = 1.0000000000  or 
    repr = "(return (member includes *))" and t = "san" and result = 1.0000000000  or 
    repr = "(return (member join (root https://www.npmjs.com/package/path)))" and t = "san" and result = 0.7500000000  or 
    repr = "(return (member load *))" and t = "san" and result = 0.5000000000  or 
    repr = "(return (member render (parameter res *)))" and t = "san" and result = 0.7500000000  or 
    repr = "(return (member replace *))" and t = "san" and result = 0.2500000000  or 
    repr = "(return (member resolve (root https://www.npmjs.com/package/path)))" and t = "san" and result = 0.5000000000  or 
    repr = "(return (member send (root https://www.npmjs.com/package/librcon)))" and t = "san" and result = 0.2500000000  or 
    repr = "(return (member startsWith (member 0 (member params *))))" and t = "san" and result = 1.0000000000  or 
    repr = "(return (member startsWith (parameter x *)))" and t = "san" and result = 1.0000000000  or 
    repr = "(return (member startsWith (return (member __ *))))" and t = "san" and result = 1.0000000000  or 
    repr = "(return (parameter 1 (member get *)))" and t = "snk" and result = 0.5000000000  or 
    repr = "(return (parameter 1 (member post *)))" and t = "snk" and result = 0.5000000000
    }}