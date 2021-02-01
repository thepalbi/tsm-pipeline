module TsmRepr {
    float getReprScore(string repr, string t){
     repr = "(parameter 0 (member element *))" and t = "snk" and result = 1.0000000000 or
     repr = "(parameter 0 (member $ (global)))" and t = "snk" and result = 1.0000000000 or
     repr = "(member innerHTML (return (member getElementById *)))" and t = "snk" and result = 1.0000000000 or
     repr = "(parameter 0 (member prepend *))" and t = "snk" and result = 1.0000000000 or
     repr = "(parameter 0 (member createElement *))" and t = "snk" and result = 1.0000000000 or
     repr = "(parameter 0 (member html *))" and t = "snk" and result = 1.0000000000 or
     repr = "(parameter 0 (member wrap *))" and t = "snk" and result = 1.0000000000 or
     repr = "(parameter 0 (member append *))" and t = "snk" and result = 1.0000000000 or
     repr = "(parameter 0 (member jQuery (global)))" and t = "snk" and result = 1.0000000000 or
     repr = "(member innerHTML (return (member createElement *)))" and t = "snk" and result = 1.0000000000 or
     repr = "(parameter 1 (member setAttribute *))" and t = "snk" and result = 0.9952830189 or
     repr = "(parameter 0 (member parseFromString *))" and t = "snk" and result = 1.0000000000 or
     repr = "(parameter 0 (member after *))" and t = "snk" and result = 1.0000000000 or
     repr = "(parameter 0 (member appendChild *))" and t = "snk" and result = 1.0000000000 or
     repr = "(member innerHTML (parameter 0 (member appendChild *)))" and t = "snk" and result = 1.0000000000 or
     repr = "(parameter 0 (member insertBefore *))" and t = "snk" and result = 1.0000000000 or
     repr = "(parameter 0 (member prependTo *))" and t = "snk" and result = 1.0000000000 or
     repr = "(member innerHTML (parameter 0 (member insertBefore *)))" and t = "snk" and result = 1.0000000000 or
     repr = "(member outerHTML *)" and t = "snk" and result = 1.0000000000 or
     repr = "(parameter 0 (member appendTo *))" and t = "snk" and result = 1.0000000000 or
     repr = "(parameter 0 (member insertAfter *))" and t = "snk" and result = 1.0000000000 or
     repr = "(member innerHTML (return (member createElementNS *)))" and t = "snk" and result = 1.0000000000 or
     repr = "(member innerHTML (return (member querySelector *)))" and t = "snk" and result = 1.0000000000 or
     repr = "(member innerHTML *)" and t = "snk" and result = 1.0000000000 or
     repr = "(return (member setLocation *))" and t = "snk" and result = 0.5000000000 or
     repr = "(member innerHTML (parameter 0 (member removeChild *)))" and t = "snk" and result = 1.0000000000 or
     repr = "(parameter 0 (member write *))" and t = "snk" and result = 0.9853146853 or
     repr = "(return (member * (parameter 1 (member apply *))))" and t = "snk" and result = 0.1666666667 or
     repr = "(parameter 1 (member apply *))" and t = "snk" and result = 0.3333333333 or
     repr = "(parameter 0 (member * (return (member find *))))" and t = "snk" and result = 1.0000000000 or
     repr = "(parameter 0 (member replaceWith *))" and t = "snk" and result = 1.0000000000 or
     repr = "(return (member h *))" and t = "snk" and result = 0.0230769231 or
     repr = "(return (member runRoute *))" and t = "snk" and result = 0.1666666667 or
     repr = "(parameter 1 (member on *))" and t = "snk" and result = 0.1538461538 or
     repr = "(parameter 0 (root https://www.npmjs.com/package/jquery))" and t = "snk" and result = 1.0000000000 or
     repr = "(member innerHTML (parameter 0 (member getComputedStyle (global))))" and t = "snk" and result = 1.0000000000 or
     repr = "(parameter 0 (member setLocation *))" and t = "snk" and result = 0.5000000000 or
     repr = "(parameter 0 (member wrapAll *))" and t = "snk" and result = 1.0000000000 or
     repr = "(parameter 0 (member * (member $element *)))" and t = "snk" and result = 1.0000000000 or
     repr = "(parameter 1 (member off *))" and t = "snk" and result = 0.1538461538 or
     repr = "(member * (parameter params (member _parseParamPair *)))" and t = "snk" and result = 0.1666666667 or
     repr = "(member template (parameter 1 (member component *)))" and t = "snk" and result = 1.0000000000 or
     repr = "(parameter 0 (member wrapInner *))" and t = "snk" and result = 1.0000000000 or
     repr = "(parameter 0 (member format *))" and t = "snk" and result = 0.3750000000 or
     repr = "(parameter 0 (member undefined (global)))" and t = "snk" and result = 1.0000000000 or
     repr = "(member template (parameter 0 (member default *)))" and t = "snk" and result = 1.0000000000 or
     repr = "(parameter 0 (member before *))" and t = "snk" and result = 1.0000000000 or
     repr = "(member template (parameter 0 (member extend *)))" and t = "snk" and result = 1.0000000000 or
     repr = "(parameter 0 (member jsonp *))" and t = "snk" and result = 0.2500000000 or
     repr = "(member innerHTML (member body *))" and t = "snk" and result = 1.0000000000 or
     repr = "(member innerHTML (parameter 0 (member contains *)))" and t = "snk" and result = 1.0000000000 or
     repr = "(parameter 2 (member append *))" and t = "snk" and result = 1.0000000000 or
     repr = "(parameter 1 (member append *))" and t = "snk" and result = 1.0000000000 or
     repr = "(parameter 0 (member trustAsHtml *))" and t = "snk" and result = 1.0000000000 or
     repr = "(member innerHTML (member span *))" and t = "snk" and result = 1.0000000000 or
     repr = "(return (parameter 1 (member addMethod *)))" and t = "snk" and result = 0.3490566038 or
     repr = "(parameter 0 (member match *))" and t = "snk" and result = 0.7500000000 or
     repr = "(parameter 0 (member * (parameter $element *)))" and t = "snk" and result = 1.0000000000 or
     repr = "(parameter 0 (member find *))" and t = "snk" and result = 0.0471698113 or
     repr = "(member * (member rules *))" and t = "snk" and result = 0.0471698113 or
     repr = "(parameter 0 (member each *))" and t = "snk" and result = 0.1485849056 or
     repr = "(parameter 1 (member substring *))" and t = "snk" and result = 0.3490566038 or
     repr = "(parameter 0 (member default *))" and t = "snk" and result = 1.0000000000 or
     repr = "(parameter 0 (member filter *))" and t = "snk" and result = 0.0471698113 or
     repr = "(parameter 0 (return (root https://www.npmjs.com/package/jquery-validation)))" and t = "snk" and result = 1.0000000000 or
     repr = "(member outerHTML (parameter 0 (member appendChild *)))" and t = "snk" and result = 1.0000000000 or
     repr = "(parameter 0 (member * (return (parameter $ *))))" and t = "snk" and result = 1.0000000000 or
     repr = "(parameter 0 (member window (global)))" and t = "snk" and result = 1.0000000000 or
     repr = "(parameter 0 (member * (return (parameter b *))))" and t = "snk" and result = 1.0000000000 or
     repr = "(parameter 0 (member * (parameter input *)))" and t = "snk" and result = 1.0000000000 or
     repr = "(member innerHTML (member 0 (return (member getElementsByClassName *))))" and t = "snk" and result = 1.0000000000 or
     repr = "(parameter 0 (parameter 0 (member isFunction *)))" and t = "snk" and result = 0.1892857143 or
     repr = "(return (member cookie *))" and t = "snk" and result = 0.3446428571 or
     repr = "(return (member date *))" and t = "snk" and result = 0.1250000000 or
     repr = "(return (parameter 1 (member grep *)))" and t = "snk" and result = 0.1250000000 or
     repr = "(return (member number *))" and t = "snk" and result = 0.1250000000 or
     repr = "(parameter 0 (parameter $ (member exports *)))" and t = "snk" and result = 1.0000000000 or
     repr = "(parameter 1 (member when *))" and t = "snk" and result = 0.2500000000 or
     repr = "(member innerHTML (parameter 0 (member push *)))" and t = "snk" and result = 1.0000000000 or
     repr = "(parameter 0 (member ajax *))" and t = "snk" and result = 0.7500000000 or
     repr = "(parameter 0 (parameter $ (root https://www.npmjs.com/package/spectrum-colorpicker)))" and t = "snk" and result = 1.0000000000 or
     repr = "(parameter 0 (member render *))" and t = "snk" and result = 0.2500000000 or
     repr = "(member width (return (parameter 0 (member map *))))" and t = "snk" and result = 0.2500000000 or
     repr = "(member url (parameter 0 (member ajax *)))" and t = "snk" and result = 0.2500000000 or
     repr = "(parameter 2 (member data *))" and t = "snk" and result = 0.2500000000 or
     repr = "(parameter 0 (member indexOf *))" and t = "snk" and result = 0.4761904762 or
     repr = "(parameter 1 (member writeFileSync *))" and t = "snk" and result = 0.1120129870 or
     repr = "(parameter 0 (member when *))" and t = "snk" and result = 0.2500000000 or
     repr = "(member __html (member dangerouslySetInnerHTML *))" and t = "snk" and result = 1.0000000000 or
     repr = "(parameter 3 (member append *))" and t = "snk" and result = 1.0000000000 or
     repr = "(parameter 4 (member append *))" and t = "snk" and result = 1.0000000000 or
     repr = "(member current *)" and t = "snk" and result = 0.2500000000 or
     repr = "(parameter 0 (parameter listener (parameter 1 (member forEach *))))" and t = "snk" and result = 0.2500000000 or
     repr = "(member $$url *)" and t = "snk" and result = 0.2500000000 or
     repr = "(parameter 2 (member forEach *))" and t = "snk" and result = 0.7500000000 or
     repr = "(parameter 0 (member json *))" and t = "snk" and result = 0.7500000000 or
     repr = "(member innerHTML (parameter 1 (member assertHtmlContentsMatch *)))" and t = "snk" and result = 1.0000000000 or
     repr = "(member innerHTML (parameter 0 (member decorate *)))" and t = "snk" and result = 1.0000000000 or
     repr = "(member innerHTML (parameter 1 (member fireMouseOverEvent *)))" and t = "snk" and result = 1.0000000000 or
     repr = "(member innerHTML (parameter 0 (member removeChildren *)))" and t = "snk" and result = 1.0000000000 or
     repr = "(member innerHTML (parameter 0 (member createFromNodeContents *)))" and t = "snk" and result = 1.0000000000 or
     repr = "(member innerHTML (parameter 0 (member render *)))" and t = "snk" and result = 1.0000000000 or
     repr = "(member innerHTML (parameter 0 (member setTextContent *)))" and t = "snk" and result = 1.0000000000 or
     repr = "(parameter 1 (member insertBefore *))" and t = "snk" and result = 1.0000000000 or
     repr = "(parameter 0 (member SafeString *))" and t = "snk" and result = 1.0000000000 or
     repr = "(parameter 2 (member setAttributeNS *))" and t = "snk" and result = 1.0000000000 or
     repr = "(return (member minChunks *))" and t = "snk" and result = 0.7500000000 or
     repr = "(parameter 0 (parameter h (member render *)))" and t = "snk" and result = 1.0000000000 or
     repr = "(member innerHTML (parameter 0 (member replaceChild *)))" and t = "snk" and result = 1.0000000000 or
     repr = "(member err (parameter 0 (parameter callback *)))" and t = "snk" and result = 0.2500000000 or
     repr = "(member innerHTML (parameter 0 (member element *)))" and t = "snk" and result = 1.0000000000 or
     repr = "(parameter 0 (parameter 4 (member isAllowed *)))" and t = "snk" and result = 0.2500000000 or
     repr = "(member result (parameter 0 (parameter callback *)))" and t = "snk" and result = 0.2500000000 or
     repr = "(member innerHTML (member sourceNode *))" and t = "snk" and result = 1.0000000000 or
     repr = "(member innerHTML (member h *))" and t = "snk" and result = 1.0000000000 or
     repr = "(return (member _resolveWidth *))" and t = "snk" and result = 0.0691489362 or
     repr = "(parameter 0 (return (member require (global))))" and t = "snk" and result = 1.0000000000 or
     repr = "(member * (parameter 0 (member concat *)))" and t = "snk" and result = 0.0691489362 or
     repr = "(parameter 1 (member css *))" and t = "snk" and result = 0.1345744681 or
     repr = "(return (member escapeMarkup *))" and t = "snk" and result = 0.0691489362 or
     repr = "(member start (parameter 2 (member extend *)))" and t = "snk" and result = 0.1333333333 or
     repr = "(member innerHTML (parameter 1 (member call *)))" and t = "snk" and result = 1.0000000000 or
     repr = "(member end (parameter 2 (member extend *)))" and t = "snk" and result = 0.1333333333 or
     repr = "(parameter 0 (parameter 0 (member apply *)))" and t = "snk" and result = 1.0000000000 or
     repr = "(parameter 0 (member isAfter *))" and t = "snk" and result = 0.1333333333 or
     repr = "(return (member fnFormatNumber *))" and t = "snk" and result = 0.5000000000 or
     repr = "(return (member * (parameter 1 (member extend *))))" and t = "snk" and result = 0.4166666667 or
     repr = "(parameter 0 (member subtract *))" and t = "snk" and result = 0.1666666667 or
     repr = "(parameter 0 (member attr *))" and t = "snk" and result = 0.2500000000 or
     repr = "(member innerHTML (return (member getFormInputDescription *)))" and t = "snk" and result = 1.0000000000 or
     repr = "(member innerHTML (return (member getDescription *)))" and t = "snk" and result = 1.0000000000 or
     repr = "(member innerHTML (return (member getTabHolder *)))" and t = "snk" and result = 1.0000000000 or
     repr = "(parameter 1 (member wrapInner *))" and t = "snk" and result = 1.0000000000 or
     repr = "(parameter 1 (member wrapAll *))" and t = "snk" and result = 1.0000000000 or
     repr = "(member * (instance (member constructor *)))" and t = "snk" and result = 0.7500000000 or
     repr = "(return (member _fnReadCookie *))" and t = "snk" and result = 0.5000000000 or
     repr = "(member innerHTML (parameter 0 (member prepend *)))" and t = "snk" and result = 1.0000000000 or
     repr = "(parameter 0 (member stat *))" and t = "snk" and result = 0.5000000000 or
     repr = "(parameter 0 (member end *))" and t = "snk" and result = 0.3125000000 or
     repr = "(parameter 0 (member writeln *))" and t = "snk" and result = 1.0000000000 or
     repr = "(parameter 0 (member exec *))" and t = "snk" and result = 0.2727272727 or
     repr = "(parameter 1 (member render *))" and t = "snk" and result = 0.5000000000 or
     repr = "(member data (parameter 1 (member render *)))" and t = "snk" and result = 0.5000000000 or
     repr = "(parameter 0 (member createContextualFragment *))" and t = "snk" and result = 1.0000000000 or
     repr = "(parameter 0 (member print *))" and t = "snk" and result = 0.4166666667 or
     repr = "(member innerHTML (parameter style *))" and t = "snk" and result = 1.0000000000 or
     repr = "(parameter 0 (member * (parameter element *)))" and t = "snk" and result = 1.0000000000 or
     repr = "(parameter 0 (member * (parameter t *)))" and t = "snk" and result = 1.0000000000 or
     repr = "(member url (parameter 0 (member assign *)))" and t = "snk" and result = 0.2000000000 or
     repr = "(parameter 0 (member $http *))" and t = "snk" and result = 0.2000000000 or
     repr = "(parameter 1 (member insertAdjacentElement *))" and t = "snk" and result = 1.0000000000 or
     repr = "(parameter 0 (member * (parameter a *)))" and t = "snk" and result = 1.0000000000 or
     repr = "(parameter 0 (member existsSync *))" and t = "snk" and result = 0.3333333333 or
     repr = "(member innerHTML (member 0 (return (member getElementsByTagName *))))" and t = "snk" and result = 1.0000000000 or
     repr = "(return (member format *))" and t = "snk" and result = 0.2500000000 or
     repr = "(parameter 0 (member send *))" and t = "snk" and result = 0.5000000000 or
     repr = "(member addresses (parameter 0 (member send *)))" and t = "snk" and result = 0.2500000000 or
     repr = "(parameter 1 (member insertAdjacentHTML *))" and t = "snk" and result = 1.0000000000 or
     repr = "(parameter 0 (parameter $ (root https://www.npmjs.com/package/bootstrap-datetime-picker)))" and t = "snk" and result = 1.0000000000 or
     repr = "(parameter 0 (member * (return (member end *))))" and t = "snk" and result = 1.0000000000 or
     repr = "(member innerHTML (parameter 0 (member get *)))" and t = "snk" and result = 1.0000000000 or
     repr = "(member innerHTML (parameter 1 (member createDom *)))" and t = "snk" and result = 1.0000000000 or
     repr = "(member innerHTML (return (member ieTable *)))" and t = "snk" and result = 1.0000000000 or
     repr = "(parameter 1 (member appendTo *))" and t = "snk" and result = 1.0000000000 or
     repr = "(member innerHTML (member ddel *))" and t = "snk" and result = 1.0000000000 or
     repr = "(member innerHTML (parameter 2 (member call *)))" and t = "snk" and result = 1.0000000000 or
     repr = "(member innerHTML (parameter 0 (member append *)))" and t = "snk" and result = 1.0000000000 or
     repr = "(member name *)" and t = "snk" and result = 0.1250000000 or
     repr = "(member api *)" and t = "snk" and result = 0.1250000000 or
     repr = "(member architecture *)" and t = "snk" and result = 0.1250000000 or
     repr = "(member * (parameter 1 (member writeHead *)))" and t = "snk" and result = 0.1250000000 or
     repr = "(parameter 1 (member writeHead *))" and t = "snk" and result = 0.1250000000 or
     repr = "(member innerHTML (member lastChild *))" and t = "snk" and result = 1.0000000000 or
     repr = "(member * (parameter 2 (member writeHead *)))" and t = "snk" and result = 0.1250000000 or
     repr = "(parameter 0 (member writeHead *))" and t = "snk" and result = 0.1250000000 or
     repr = "(parameter 2 (member writeHead *))" and t = "snk" and result = 0.1250000000 or
     repr = "(parameter 0 (member includes *))" and t = "snk" and result = 0.2500000000 or
     repr = "(return (parameter 0 (member filter *)))" and t = "snk" and result = 0.2500000000 or
     repr = "(member * (parameter obj (member extend *)))" and t = "snk" and result = 0.1785714286 or
     repr = "(parameter 0 (member isPlainObject *))" and t = "snk" and result = 0.1785714286 or
     repr = "(member innerHTML (parameter a *))" and t = "snk" and result = 1.0000000000 or
     repr = "(parameter 0 (member * (return (member attr *))))" and t = "snk" and result = 1.0000000000 or
     repr = "(parameter 0 (member diff *))" and t = "snk" and result = 0.1000000000 or
     repr = "(return (member getEventEnd *))" and t = "snk" and result = 0.1000000000 or
     repr = "(parameter 0 (member duration *))" and t = "snk" and result = 0.1000000000 or
     repr = "(parameter 0 (member * (return (parameter jQuery *))))" and t = "snk" and result = 1.0000000000 or
     repr = "(return (member parse *))" and t = "snk" and result = 0.2000000000 or
     repr = "(parameter 0 (member * (global)))" and t = "snk" and result = 1.0000000000 or
     repr = "(parameter 0 (parameter createElement (member render *)))" and t = "snk" and result = 1.0000000000 or
     repr = "(member Content-Length (member headers *))" and t = "snk" and result = 0.0454545455 or
     repr = "(member hostname (parameter 0 (member request *)))" and t = "snk" and result = 0.0454545455 or
     repr = "(member method (parameter 0 (member request *)))" and t = "snk" and result = 0.0454545455 or
     repr = "(member headers (parameter 0 (member request *)))" and t = "snk" and result = 0.0454545455 or
     repr = "(member outerHTML (return (member querySelector *)))" and t = "snk" and result = 1.0000000000 or
     repr = "(member innerHTML (parameter 0 (member jqxBaseFramework (global))))" and t = "snk" and result = 1.0000000000 or
     repr = "(member path (parameter 0 (member request *)))" and t = "snk" and result = 0.0454545455 or
     repr = "(parameter 0 (member request *))" and t = "snk" and result = 0.0454545455 or
     repr = "(parameter 1 (member setHeader *))" and t = "snk" and result = 0.0454545455 or
     repr = "(parameter 1 (member request *))" and t = "snk" and result = 0.0454545455 or
     repr = "(member port (parameter 0 (member request *)))" and t = "snk" and result = 0.0454545455
     } 
  }
  