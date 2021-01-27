module TsmRepr {float getReprScore(string repr, string t){
    repr = "(parameter 0 (member createElement *))" and t = "snk" and result = 1.0000000000 or
    repr = "(parameter 0 (member $ (global)))" and t = "snk" and result = 1.0000000000 or
    repr = "(member innerHTML (return (member createElement (member document (global)))))" and t = "snk" and result = 1.0000000000 or
    repr = "(parameter 0 (member appendChild *))" and t = "snk" and result = 1.0000000000 or
    repr = "(parameter 0 (member write *))" and t = "snk" and result = 0.9807692308 or
    repr = "(parameter 0 (member before *))" and t = "snk" and result = 1.0000000000 or
    repr = "(parameter 0 (member appendTo *))" and t = "snk" and result = 1.0000000000 or
    repr = "(parameter 0 (member insertAfter *))" and t = "snk" and result = 1.0000000000 or
    repr = "(parameter 0 (member * (member $element *)))" and t = "snk" and result = 1.0000000000 or
    repr = "(parameter 0 (parameter 0 (parameter 1 (member define (global)))))" and t = "snk" and result = 1.0000000000 or
    repr = "(member innerHTML (parameter 0 (member removeChild *)))" and t = "snk" and result = 0.9527777778 or
    repr = "(parameter 0 (member jQuery (global)))" and t = "snk" and result = 1.0000000000 or
    repr = "(parameter 0 (member prepend *))" and t = "snk" and result = 1.0000000000 or
    repr = "(parameter 0 (member * (return (member find *))))" and t = "snk" and result = 1.0000000000 or
    repr = "(member innerHTML (return (member createElement (member document (parameter window *)))))" and t = "snk" and result = 1.0000000000 or
    repr = "(parameter 0 (parameter pred (member find *)))" and t = "snk" and result = 0.2500000000 or
    repr = "(parameter 1 (member setAttribute *))" and t = "snk" and result = 1.0000000000 or
    repr = "(parameter 0 (member html *))" and t = "snk" and result = 1.0000000000 or
    repr = "(parameter 0 (member element *))" and t = "snk" and result = 1.0000000000 or
    repr = "(parameter 0 (member prependTo *))" and t = "snk" and result = 1.0000000000 or
    repr = "(parameter 0 (member undefined (global)))" and t = "snk" and result = 1.0000000000 or
    repr = "(parameter 0 (member text *))" and t = "snk" and result = 0.2500000000 or
    repr = "(parameter 0 (member insertBefore *))" and t = "snk" and result = 1.0000000000 or
    repr = "(parameter 0 (member parseFromString *))" and t = "snk" and result = 1.0000000000 or
    repr = "(member innerHTML (return (member createElement (parameter c *))))" and t = "snk" and result = 1.0000000000 or
    repr = "(parameter 0 (member after *))" and t = "snk" and result = 1.0000000000 or
    repr = "(parameter 0 (member append *))" and t = "snk" and result = 1.0000000000 or
    repr = "(member innerHTML (parameter 0 (member insertBefore *)))" and t = "snk" and result = 1.0000000000 or
    repr = "(member innerHTML (parameter 0 (member appendChild *)))" and t = "snk" and result = 1.0000000000 or
    repr = "(member innerHTML (return (member getElementById (member document (global)))))" and t = "snk" and result = 1.0000000000 or
    repr = "(parameter 0 (member wrap *))" and t = "snk" and result = 1.0000000000 or
    repr = "(member innerHTML (return (member createElement (parameter b *))))" and t = "snk" and result = 1.0000000000 or
    repr = "(parameter 0 (return (return (member nonComputedMember *))))" and t = "snk" and result = 1.0000000000 or
    repr = "(member innerHTML (return (member querySelector (member document (global)))))" and t = "snk" and result = 1.0000000000 or
    repr = "(member innerHTML (return (member createElementNS (member document (global)))))" and t = "snk" and result = 1.0000000000 or
    repr = "(parameter 0 (member send *))" and t = "snk" and result = 0.3000000000 or
    repr = "(member innerHTML (member * (return (member querySelectorAll *))))" and t = "snk" and result = 1.0000000000 or
    repr = "(member outerHTML (member * (return (member querySelectorAll *))))" and t = "snk" and result = 1.0000000000 or
    repr = "(member socketId (parameter 0 (member send *)))" and t = "snk" and result = 0.2500000000 or
    repr = "(return (parameter 0 (member computed *)))" and t = "snk" and result = 0.2500000000 or
    repr = "(member outerHTML (parameter 0 (member appendChild *)))" and t = "snk" and result = 1.0000000000 or
    repr = "(member table (member files (parameter viewModel *)))" and t = "snk" and result = 0.2500000000 or
    repr = "(parameter 2 (member getAccountUrl *))" and t = "snk" and result = 0.7500000000 or
    repr = "(parameter 0 (member indexOf *))" and t = "snk" and result = 0.2500000000 or
    repr = "(parameter 0 (member arrayForEach *))" and t = "snk" and result = 0.2500000000 or
    repr = "(parameter 0 (member navigate *))" and t = "snk" and result = 0.2500000000 or
    repr = "(return (member static (member view_model (parameter 1 (member subscribe *)))))" and t = "snk" and result = 0.2500000000 or
    repr = "(parameter 0 (member formatNumber *))" and t = "snk" and result = 0.2500000000 or
    repr = "(parameter 0 (member param *))" and t = "snk" and result = 0.2500000000 or
    repr = "(parameter 0 (member ajax *))" and t = "snk" and result = 0.5000000000 or
    repr = "(parameter 0 (member default *))" and t = "snk" and result = 0.8750000000 or
    repr = "(return (parameter 0 (member pureComputed *)))" and t = "snk" and result = 0.2500000000 or
    repr = "(member upload_location_uri (parameter 1 (member get *)))" and t = "snk" and result = 0.2500000000 or
    repr = "(parameter 0 (member active *))" and t = "snk" and result = 0.2500000000 or
    repr = "(member innerHTML (parameter 0 (parameter $ *)))" and t = "snk" and result = 1.0000000000 or
    repr = "(member innerHTML (parameter 0 (member addDomListener *)))" and t = "snk" and result = 1.0000000000 or
    repr = "(parameter 0 (member reject *))" and t = "snk" and result = 0.0416666667 or
    repr = "(member requestUri (parameter 0 (member read *)))" and t = "snk" and result = 0.0416666667 or
    repr = "(parameter 0 (member replace *))" and t = "snk" and result = 0.2500000000 or
    repr = "(parameter 1 (member indexOf *))" and t = "snk" and result = 0.0500000000 or
    repr = "(parameter 1 (member substring *))" and t = "snk" and result = 0.3250000000 or
    repr = "(return (parameter 2 (member read *)))" and t = "snk" and result = 0.0416666667 or
    repr = "(member url (parameter 0 (member _catchNoConnectionError *)))" and t = "snk" and result = 0.0416666667 or
    repr = "(return (parameter 1 (member rewriteTemplate *)))" and t = "snk" and result = 0.2500000000 or
    repr = "(return (parameter 1 (member replace *)))" and t = "snk" and result = 0.0500000000 or
    repr = "(return (parameter 1 (member request *)))" and t = "snk" and result = 0.2500000000 or
    repr = "(member route (parameter 0 (member unshift *)))" and t = "snk" and result = 0.0700000000 or
    repr = "(member innerHTML (return (member createElement (parameter document *))))" and t = "snk" and result = 1.0000000000 or
    repr = "(parameter 0 (member read *))" and t = "snk" and result = 0.0416666667 or
    repr = "(parameter 1 (member extend *))" and t = "snk" and result = 0.0034722222 or
    repr = "(return (member _routeToRegExp (parameter 2 (member extend *))))" and t = "snk" and result = 0.0700000000 or
    repr = "(parameter 1 (member apply *))" and t = "snk" and result = 0.0700000000 or
    repr = "(parameter 1 (member saveUtf8File *))" and t = "snk" and result = 0.0500000000 or
    repr = "(parameter 0 (member warn *))" and t = "snk" and result = 0.0500000000 or
    repr = "(parameter 0 (member trace *))" and t = "snk" and result = 0.0500000000 or
    repr = "(return (parameter 2 (member request *)))" and t = "snk" and result = 0.1666666667 or
    repr = "(parameter 0 (member callback *))" and t = "snk" and result = 0.2500000000 or
    repr = "(return (member memoizeBindingAttributeSyntax (member templateRewriting (parameter koExports *))))" and t = "snk" and result = 0.2500000000 or
    repr = "(return (member _extractParameters (parameter 2 (member extend *))))" and t = "snk" and result = 0.0700000000 or
    repr = "(member data (parameter 0 (member request *)))" and t = "snk" and result = 0.5000000000 or
    repr = "(parameter 0 (member _extractParameters *))" and t = "snk" and result = 0.0700000000 or
    repr = "(member innerHTML (parameter 0 (member getComputedStyle (global))))" and t = "snk" and result = 1.0000000000 or
    repr = "(parameter 0 (member substring *))" and t = "snk" and result = 0.1500000000 or
    repr = "(return (member start (parameter 2 (member extend *))))" and t = "snk" and result = 0.2500000000 or
    repr = "(return (member url (parameter 2 (member extend *))))" and t = "snk" and result = 0.0416666667 or
    repr = "(parameter 0 (member readFile *))" and t = "snk" and result = 0.1083333334 or
    repr = "(return (parameter 1 (member read *)))" and t = "snk" and result = 0.0416666667 or
    repr = "(parameter 0 (member jsonp *))" and t = "snk" and result = 0.2500000000 or
    repr = "(member innerHTML (parameter 0 (member transition *)))" and t = "snk" and result = 1.0000000000 or
    repr = "(parameter 1 (member writeHead *))" and t = "snk" and result = 0.5000000000 or
    repr = "(member template (parameter 1 (member component *)))" and t = "snk" and result = 1.0000000000 or
    repr = "(member template (parameter 0 (member Vue (global))))" and t = "snk" and result = 1.0000000000 or
    repr = "(member template (parameter 0 (member extend *)))" and t = "snk" and result = 1.0000000000 or
    repr = "(parameter 0 (return (parameter 1 (member define (global)))))" and t = "snk" and result = 1.0000000000 or
    repr = "(parameter 0 (member wrapAll *))" and t = "snk" and result = 1.0000000000 or
    repr = "(member template (parameter 0 (member default *)))" and t = "snk" and result = 1.0000000000 or
    repr = "(member Content-Type (parameter 1 (member writeHead *)))" and t = "snk" and result = 0.5000000000 or
    repr = "(parameter 0 (member replaceWith *))" and t = "snk" and result = 1.0000000000 or
    repr = "(parameter 0 (member wrapInner *))" and t = "snk" and result = 1.0000000000 or
    repr = "(member innerHTML (member body (member document (global))))" and t = "snk" and result = 1.0000000000 or
    repr = "(member innerHTML (parameter 0 (member contains *)))" and t = "snk" and result = 1.0000000000 or
    repr = "(parameter 1 (member wrapInner *))" and t = "snk" and result = 1.0000000000 or
    repr = "(member innerHTML (return (member createElement (parameter 1 (member find *)))))" and t = "snk" and result = 1.0000000000 or
    repr = "(member innerHTML (return (member createElement (parameter a *))))" and t = "snk" and result = 1.0000000000 or
    repr = "(parameter 1 (member wrapAll *))" and t = "snk" and result = 1.0000000000 or
    repr = "(member innerHTML (member span (parameter 0 (member push (member HTML *)))))" and t = "snk" and result = 1.0000000000 or
    repr = "(member innerHTML (parameter 3 (member createElement *)))" and t = "snk" and result = 1.0000000000 or
    repr = "(member innerHTML (parameter 0 (member setStyle *)))" and t = "snk" and result = 1.0000000000 or
    repr = "(member innerHTML (parameter 0 (member prepend *)))" and t = "snk" and result = 1.0000000000 or
    repr = "(parameter 0 (member * (parameter $element *)))" and t = "snk" and result = 1.0000000000 or
    repr = "(parameter 0 (member find *))" and t = "snk" and result = 0.0568181818 or
    repr = "(parameter 0 (member parseJSON *))" and t = "snk" and result = 0.0568181818 or
    repr = "(parameter 0 (member each *))" and t = "snk" and result = 0.1534090909 or
    repr = "(parameter 0 (member filter *))" and t = "snk" and result = 0.0568181818 or
    repr = "(member * (member rules (parameter options *)))" and t = "snk" and result = 0.0568181818 or
    repr = "(return (parameter 1 (member addMethod *)))" and t = "snk" and result = 0.5000000000 or
    repr = "(parameter 1 (member append *))" and t = "snk" and result = 1.0000000000 or
    repr = "(return (member treeSelectorLazyLoadData *))" and t = "snk" and result = 0.2000000000 or
    repr = "(return (member treeSelectorLoadData *))" and t = "snk" and result = 0.2000000000 or
    repr = "(member innerHTML (return (member createElement (parameter r *))))" and t = "snk" and result = 1.0000000000 or
    repr = "(member left (parameter 0 (member velocity *)))" and t = "snk" and result = 0.2500000000 or
    repr = "(parameter 0 (member window (global)))" and t = "snk" and result = 1.0000000000 or
    repr = "(member innerHTML (parameter 0 (member Velocity (global))))" and t = "snk" and result = 1.0000000000 or
    repr = "(parameter 1 (member connect *))" and t = "snk" and result = 0.1250000000 or
    repr = "(member arrivalDelayedAverageTime (parameter 0 (parameter resolve *)))" and t = "snk" and result = 0.2500000000 or
    repr = "(parameter 0 (parameter 0 (parameter 2 (member define (global)))))" and t = "snk" and result = 1.0000000000 or
    repr = "(parameter 0 (member connect *))" and t = "snk" and result = 0.1250000000 or
    repr = "(member innerHTML (parameter 0 (member Vel (global))))" and t = "snk" and result = 1.0000000000 or
    repr = "(parameter 0 (member writeln *))" and t = "snk" and result = 1.0000000000 or
    repr = "(parameter 0 (member exec *))" and t = "snk" and result = 0.7500000000 or
    repr = "(parameter 0 (member stat *))" and t = "snk" and result = 0.1666666667 or
    repr = "(parameter 0 (member end *))" and t = "snk" and result = 0.5000000000 or
    repr = "(member innerHTML (return (member createElement (parameter context *))))" and t = "snk" and result = 1.0000000000 or
    repr = "(member html (parameter 0 (member sendMail *)))" and t = "snk" and result = 1.0000000000 or
    repr = "(member innerHTML (return (parameter 2 (member make2DArray *))))" and t = "snk" and result = 1.0000000000 or
    repr = "(parameter 0 (member createReadStream *))" and t = "snk" and result = 0.1666666667 or
    repr = "(parameter 1 (member setHeader *))" and t = "snk" and result = 0.2500000000 or
    repr = "(member innerHTML (parameter 0 (member element *)))" and t = "snk" and result = 1.0000000000 or
    repr = "(member outerHTML (return (member createElement (parameter b *))))" and t = "snk" and result = 1.0000000000 or
    repr = "(member innerHTML (parameter 0 (member create_element *)))" and t = "snk" and result = 1.0000000000 or
    repr = "(member innerHTML (parameter _20 *))" and t = "snk" and result = 1.0000000000 or
    repr = "(parameter 0 (member * (return (parameter $ *))))" and t = "snk" and result = 1.0000000000 or
    repr = "(member innerHTML (parameter 0 (member get_xhtml (global))))" and t = "snk" and result = 1.0000000000 or
    repr = "(parameter 0 (member * (parameter input *)))" and t = "snk" and result = 1.0000000000 or
    repr = "(parameter 0 (member * (return (member prev *))))" and t = "snk" and result = 1.0000000000 or
    repr = "(member innerHTML (return (member createElement (parameter m *))))" and t = "snk" and result = 1.0000000000 or
    repr = "(parameter 0 (member * (return (parameter b *))))" and t = "snk" and result = 1.0000000000 or
    repr = "(member data (parameter 1 (member render *)))" and t = "snk" and result = 0.5000000000 or
    repr = "(parameter 1 (member render *))" and t = "snk" and result = 0.5000000000 or
    repr = "(parameter 2 (member setAttributeNS *))" and t = "snk" and result = 1.0000000000 or
    repr = "(member * (parameter destination *))" and t = "snk" and result = 0.4166666667 or
    repr = "(member id (member * (parameter 0 (member forEach *))))" and t = "snk" and result = 0.2500000000 or
    repr = "(parameter 1 (member attr *))" and t = "snk" and result = 0.3750000000 or
    repr = "(member innerHTML (member firstChild (return (member createDocumentFragment (parameter context *)))))" and t = "snk" and result = 0.5500000000 or
    repr = "(member * (parameter 0 (parameter childLinkFn *)))" and t = "snk" and result = 0.2500000000 or
    repr = "(return (member injector (parameter 0 (member forEach *))))" and t = "snk" and result = 0.2916666667 or
    repr = "(member * (return (member tokenize (member Sizzle (parameter window *)))))" and t = "snk" and result = 0.7500000000 or
    repr = "(return (member extend (member fn (member constructor (member prototype *)))))" and t = "snk" and result = 0.5000000000 or
    repr = "(return (return (member parseAs (return (member copy *)))))" and t = "snk" and result = 0.2500000000 or
    repr = "(parameter 1 (parameter fn (parameter 1 (member forEach *))))" and t = "snk" and result = 0.4166666667 or
    repr = "(return (member ajax (parameter 0 (member extend *))))" and t = "snk" and result = 0.3750000000 or
    repr = "(parameter 0 (parameter fn (parameter 1 (member forEach *))))" and t = "snk" and result = 0.4166666667 or
    repr = "(return (member parseTwoDigitYear (member moment (parameter global *))))" and t = "snk" and result = 0.0650406504 or
    repr = "(member * (return (member tokenize (member find (member jQuery *)))))" and t = "snk" and result = 0.6250000000 or
    repr = "(member align (parameter 0 (member push *)))" and t = "snk" and result = 0.5000000000 or
    repr = "(member innerHTML (return (member createElement (parameter doc *))))" and t = "snk" and result = 1.0000000000 or
    repr = "(parameter 0 (member removeChild *))" and t = "snk" and result = 0.1500000000 or
    repr = "(parameter 0 (member monthsParse *))" and t = "snk" and result = 0.0650406504 or
    repr = "(member type (parameter event *))" and t = "snk" and result = 0.2500000000 or
    repr = "(parameter 1 (member Function (global)))" and t = "snk" and result = 0.1250000000 or
    repr = "(parameter 2 (member monthsParse *))" and t = "snk" and result = 0.0650406504 or
    repr = "(parameter 0 (member weekdaysParse *))" and t = "snk" and result = 0.0650406504 or
    repr = "(return (member template (return (parameter 0 (member test *)))))" and t = "snk" and result = 0.1250000000 or
    repr = "(member source (return (return (member Function (parameter global *)))))" and t = "snk" and result = 0.1250000000 or
    repr = "(member data (parameter 0 (member json *)))" and t = "snk" and result = 0.2500000000 or
    repr = "(member viewCount (parameter 1 (member update *)))" and t = "snk" and result = 0.2500000000 or
    repr = "(parameter 0 (member json *))" and t = "snk" and result = 0.3750000000 or
    repr = "(return (member * (member transformRequest (parameter 2 (member post *)))))" and t = "snk" and result = 0.7500000000 or
    repr = "(parameter 0 (member createContextualFragment *))" and t = "snk" and result = 1.0000000000 or
    repr = "(parameter 0 (member setStartAndEnd *))" and t = "snk" and result = 0.1000000000 or
    repr = "(parameter 1 (member setStartAndEnd *))" and t = "snk" and result = 0.1000000000 or
    repr = "(parameter 1 (member DomPosition *))" and t = "snk" and result = 0.1000000000 or
    repr = "(parameter 3 (member setStartAndEnd *))" and t = "snk" and result = 0.1000000000 or
    repr = "(member innerHTML (return (member createElement (parameter t *))))" and t = "snk" and result = 1.0000000000 or
    repr = "(parameter 2 (member setStartAndEnd *))" and t = "snk" and result = 0.1000000000 or
    repr = "(member innerHTML (member 1 (return (member getElementsByClassName *))))" and t = "snk" and result = 1.0000000000 or
    repr = "(parameter 0 (parameter 0 (member isFunction *)))" and t = "snk" and result = 0.1785714286 or
    repr = "(return (member cookie (parameter $ *)))" and t = "snk" and result = 0.1785714286 or
    repr = "(member innerHTML (member 0 (return (member getElementsByClassName *))))" and t = "snk" and result = 1.0000000000 or
    repr = "(member innerHTML (member 2 (return (member getElementsByClassName *))))" and t = "snk" and result = 1.0000000000 or
    repr = "(member innerHTML (return (member createElement (member document (parameter t *)))))" and t = "snk" and result = 1.0000000000 or
    repr = "(return (member number (parameter 1 (member extend *))))" and t = "snk" and result = 0.1250000000 or
    repr = "(parameter 0 (parameter 0 (member exports *)))" and t = "snk" and result = 1.0000000000 or
    repr = "(return (parameter 1 (member grep *)))" and t = "snk" and result = 0.1250000000 or
    repr = "(return (member date (parameter 1 (member extend *))))" and t = "snk" and result = 0.1250000000 or
    repr = "(member innerHTML (parameter elem *))" and t = "snk" and result = 1.0000000000 or
    repr = "(return (member suggestion (member templates (parameter 1 (member typeahead *)))))" and t = "snk" and result = 1.0000000000 or
    repr = "(return (parameter 1 (member register *)))" and t = "snk" and result = 0.2833333333 or
    repr = "(member innerHTML (member documentElement (member document (global))))" and t = "snk" and result = 1.0000000000 or
    repr = "(parameter 0 (member minify *))" and t = "snk" and result = 0.2500000000 or
    repr = "(member innerHTML (parameter 0 (member fromElement *)))" and t = "snk" and result = 1.0000000000 or
    repr = "(member innerHTML (member * (return (member getElementsByTagName *))))" and t = "snk" and result = 1.0000000000 or
    repr = "(parameter 0 (member Anonymous *))" and t = "snk" and result = 0.7500000000 or
    repr = "(parameter 0 (member cssmin *))" and t = "snk" and result = 0.2500000000 or
    repr = "(parameter 0 (member * (parameter element *)))" and t = "snk" and result = 1.0000000000 or
    repr = "(member innerHTML (parameter 0 (member replaceChild *)))" and t = "snk" and result = 1.0000000000 or
    repr = "(parameter 0 (member * (parameter t *)))" and t = "snk" and result = 1.0000000000 or
    repr = "(member innerHTML (parameter style *))" and t = "snk" and result = 1.0000000000 or
    repr = "(member innerHTML (return (member createElement (parameter f *))))" and t = "snk" and result = 1.0000000000 or
    repr = "(return (member isArcGISOnlineHosted *))" and t = "snk" and result = 0.2500000000 or
    repr = "(member portalUrl (parameter 0 (parameter ArcGISOAuthInfo *)))" and t = "snk" and result = 0.0937500000 or
    repr = "(parameter 0 (member _applyPopupConfiguration *))" and t = "snk" and result = 0.1250000000 or
    repr = "(parameter 0 (parameter ArcGISOAuthInfo (parameter 1 (member define (global)))))" and t = "snk" and result = 0.0937500000 or
    repr = "(member __html (member dangerouslySetInnerHTML *))" and t = "snk" and result = 1.0000000000 or
    repr = "(member innerHTML (return (member createElement (parameter ownerDocument *))))" and t = "snk" and result = 1.0000000000 or
    repr = "(return (member jsEscape *))" and t = "snk" and result = 0.2000000000 or
    repr = "(parameter 0 (member focus *))" and t = "snk" and result = 0.5000000000 or
    repr = "(member innerHTML (parameter 0 (member push *)))" and t = "snk" and result = 1.0000000000 or
    repr = "(parameter 0 (member render *))" and t = "snk" and result = 0.2500000000 or
    repr = "(parameter 0 (member setVisibility *))" and t = "snk" and result = 0.1250000000 or
    repr = "(parameter 0 (member Portal *))" and t = "snk" and result = 0.1458333333 or
    repr = "(parameter 0 (member present *))" and t = "snk" and result = 0.2500000000 or
    repr = "(member innerHTML (parameter 0 (member Sortable (global))))" and t = "snk" and result = 1.0000000000 or
    repr = "(parameter 0 (member checkSignInStatus *))" and t = "snk" and result = 0.0625000000 or
    repr = "(parameter 1 (member asModule *))" and t = "snk" and result = 0.2000000000 or
    repr = "(member layerMixins (parameter 2 (member createMap *)))" and t = "snk" and result = 0.1562500000 or
    repr = "(return (member needsClick (member prototype (member FastClick (member exports *)))))" and t = "snk" and result = 0.7500000000 or
    repr = "(parameter 0 (parameter viewEntryTpl (parameter 1 (member define (global)))))" and t = "snk" and result = 0.0330188679 or
    repr = "(parameter 4 (member append *))" and t = "snk" and result = 1.0000000000 or
    repr = "(return (member convertURLHTTP *))" and t = "snk" and result = 0.1363636364 or
    repr = "(member isInBuilder (parameter 0 (parameter viewEntryTpl *)))" and t = "snk" and result = 0.0330188679 or
    repr = "(parameter 0 (member urlToObject *))" and t = "snk" and result = 0.2500000000 or
    repr = "(member innerHTML (parameter 0 (member _extendSwiperSlide *)))" and t = "snk" and result = 1.0000000000 or
    repr = "(parameter 0 (member sanitize *))" and t = "snk" and result = 0.1250000000 or
    repr = "(member isBuilder (parameter 0 (parameter EmbedBar *)))" and t = "snk" and result = 0.0330188679 or
    repr = "(return (member getUploadBaseName *))" and t = "snk" and result = 0.0028409091 or
    repr = "(parameter 1 (parameter Geocoder (parameter 1 (member define (global)))))" and t = "snk" and result = 0.0330188679 or
    repr = "(parameter 0 (member uploadFile *))" and t = "snk" and result = 0.1590909091 or
    repr = "(parameter 2 (member append *))" and t = "snk" and result = 1.0000000000 or
    repr = "(member frameTag (parameter 0 (member mixin *)))" and t = "snk" and result = 0.0909090909 or
    repr = "(return (member prependURLHTTP *))" and t = "snk" and result = 0.0909090909 or
    repr = "(parameter 1 (parameter Legend (parameter 1 (member define (global)))))" and t = "snk" and result = 0.0330188679 or
    repr = "(parameter 0 (member mixin *))" and t = "snk" and result = 0.0909090909 or
    repr = "(member thumb_url (parameter 0 (member mixin *)))" and t = "snk" and result = 0.0909090909 or
    repr = "(parameter 2 (parameter Overview (parameter 1 (member define (global)))))" and t = "snk" and result = 0.0330188679 or
    repr = "(parameter 0 (parameter viewTpl (parameter 1 (member define (global)))))" and t = "snk" and result = 0.0330188679 or
    repr = "(parameter 3 (member append *))" and t = "snk" and result = 1.0000000000 or
    repr = "(parameter 1 (member publish *))" and t = "snk" and result = 0.5000000000 or
    repr = "(parameter 0 (member map *))" and t = "snk" and result = 0.1250000000 or
    repr = "(parameter 0 (parameter EmbedBar (parameter 1 (member define (global)))))" and t = "snk" and result = 0.0330188679 or
    repr = "(member isInBuilder (parameter 0 (parameter viewTpl *)))" and t = "snk" and result = 0.0330188679 or
    repr = "(parameter 5 (member append *))" and t = "snk" and result = 1.0000000000 or
    repr = "(parameter 0 (member resolve *))" and t = "snk" and result = 0.2045454546 or
    repr = "(parameter 0 (member applySecurityAuthentication *))" and t = "snk" and result = 0.0384615385 or
    repr = "(parameter 0 (member makeRequestContext *))" and t = "snk" and result = 0.0384615385 or
    repr = "(parameter 0 (root https://www.npmjs.com/package/url-parse))" and t = "snk" and result = 0.5000000000 or
    repr = "(member uri (parameter 0 (member applyToRequest *)))" and t = "snk" and result = 0.0384615385 or
    repr = "(parameter 0 (member delete *))" and t = "snk" and result = 0.0384615385 or
    repr = "(parameter 0 (member expect *))" and t = "snk" and result = 0.0384615385 or
    repr = "(parameter 0 (root https://www.npmjs.com/package/request))" and t = "snk" and result = 0.0384615385 or
    repr = "(parameter 0 (member get *))" and t = "snk" and result = 0.1442307693 or
    repr = "(parameter 0 (member addLayer *))" and t = "snk" and result = 0.2500000000 or
    repr = "(parameter 0 (parameter esriRequest (parameter 1 (member define (global)))))" and t = "snk" and result = 0.2500000000 or
    repr = "(parameter 0 (member setAppProxies *))" and t = "snk" and result = 0.2500000000 or
    repr = "(return (member isArcGISHosted *))" and t = "snk" and result = 0.2500000000 or
    repr = "(parameter 7 (member updatePicture *))" and t = "snk" and result = 0.2500000000 or
    repr = "(member basemapsGroup (parameter 0 (parameter BasemapGallery *)))" and t = "snk" and result = 0.7500000000 or
    repr = "(return (member getItemURL *))" and t = "snk" and result = 0.2500000000 or
    repr = "(return (member validateURL *))" and t = "snk" and result = 0.2500000000 or
    repr = "(return (member getIDField *))" and t = "snk" and result = 0.2500000000 or
    repr = "(parameter 1 (member centerAndZoom *))" and t = "snk" and result = 0.2500000000 or
    repr = "(parameter 0 (parameter PictureMarkerSymbol (parameter 1 (member define (global)))))" and t = "snk" and result = 0.2500000000 or
    repr = "(return (member getFieldsConfig *))" and t = "snk" and result = 0.2500000000 or
    repr = "(parameter 6 (member init *))" and t = "snk" and result = 0.2500000000 or
    repr = "(return (member hasBeenUpdated *))" and t = "snk" and result = 0.2500000000 or
    repr = "(member left (parameter 1 (member set *)))" and t = "snk" and result = 0.2500000000 or
    repr = "(member zoom (parameter 1 (parameter Map *)))" and t = "snk" and result = 0.2500000000 or
    repr = "(member title (member basemapsGroup (parameter 0 (parameter BasemapGallery *))))" and t = "snk" and result = 0.5000000000 or
    repr = "(parameter 0 (parameter Point (parameter 1 (member define (global)))))" and t = "snk" and result = 0.2500000000 or
    repr = "(parameter 1 (member process *))" and t = "snk" and result = 0.2500000000 or
    repr = "(parameter 0 (member getCustomColor *))" and t = "snk" and result = 0.2500000000 or
    repr = "(parameter 0 (parameter Graphic (parameter 1 (member define (global)))))" and t = "snk" and result = 0.2500000000 or
    repr = "(return (member hexToRgb *))" and t = "snk" and result = 0.2500000000 or
    repr = "(return (member decodeText *))" and t = "snk" and result = 0.5000000000 or
    repr = "(parameter 0 (member importTourPoints *))" and t = "snk" and result = 0.2500000000 or
    repr = "(parameter 1 (member updatePicture *))" and t = "snk" and result = 0.2500000000 or
    repr = "(parameter 0 (member forEach *))" and t = "snk" and result = 0.2500000000 or
    repr = "(parameter 1 (member present *))" and t = "snk" and result = 0.2500000000 or
    repr = "(parameter 0 (member setExtent *))" and t = "snk" and result = 0.2500000000 or
    repr = "(parameter 2 (member updatePicture *))" and t = "snk" and result = 0.2500000000 or
    repr = "(return (member getThumbURL *))" and t = "snk" and result = 0.2500000000 or
    repr = "(return (member resample *))" and t = "snk" and result = 0.2500000000 or
    repr = "(member title (member values (parameter data *)))" and t = "snk" and result = 0.2500000000 or
    repr = "(parameter 0 (member addValue *))" and t = "snk" and result = 0.2500000000 or
    repr = "(parameter 0 (member mediaIsSupportedImg *))" and t = "snk" and result = 0.2500000000 or
    repr = "(parameter 0 (member createMap *))" and t = "snk" and result = 0.2500000000 or
    repr = "(parameter 3 (member updatePicture *))" and t = "snk" and result = 0.2500000000 or
    repr = "(parameter 3 (member fsApplyEdits *))" and t = "snk" and result = 0.2500000000 or
    repr = "(return (member userIsAppOwner *))" and t = "snk" and result = 0.2500000000 or
    repr = "(parameter 0 (member centerAndZoom *))" and t = "snk" and result = 0.2500000000 or
    repr = "(return (member getCurrentId *))" and t = "snk" and result = 0.2500000000 or
    repr = "(parameter 0 (member init *))" and t = "snk" and result = 0.5000000000 or
    repr = "(member url (parameter 0 (parameter esriRequest *)))" and t = "snk" and result = 0.2500000000 or
    repr = "(return (member getOrder *))" and t = "snk" and result = 0.2500000000 or
    repr = "(parameter 1 (parameter UniqueValueRenderer (parameter 1 (member define (global)))))" and t = "snk" and result = 0.2500000000 or
    repr = "(parameter 2 (parameter callback (member uploadThumbnailUsingData *)))" and t = "snk" and result = 0.2500000000 or
    repr = "(parameter 1 (member fsApplyEdits *))" and t = "snk" and result = 0.2500000000 or
    repr = "(parameter 1 (member insertBefore *))" and t = "snk" and result = 1.0000000000 or
    repr = "(member innerHTML (return (member createElement (parameter i *))))" and t = "snk" and result = 1.0000000000 or
    repr = "(parameter 0 (member * (parameter a *)))" and t = "snk" and result = 1.0000000000 or
    repr = "(parameter 1 (member insertAdjacentElement *))" and t = "snk" and result = 1.0000000000 or
    repr = "(member innerHTML (member 0 (return (member getElementsByTagName (member document *)))))" and t = "snk" and result = 1.0000000000 or
    repr = "(parameter 0 (member unlink *))" and t = "snk" and result = 0.2500000000 or
    repr = "(parameter 0 (parameter 0 (member apply *)))" and t = "snk" and result = 1.0000000000 or
    repr = "(member innerHTML (return (member createElement (member document (parameter a *)))))" and t = "snk" and result = 1.0000000000 or
    repr = "(parameter 0 (member existsSync *))" and t = "snk" and result = 0.6250000000 or
    repr = "(member Content-Disposition (parameter _headers *))" and t = "snk" and result = 0.6250000000 or
    repr = "(member user (parameter req *))" and t = "snk" and result = 0.2500000000 or
    repr = "(parameter 1 (member header *))" and t = "snk" and result = 0.5000000000 or
    repr = "(return (parameter 1 (member post *)))" and t = "snk" and result = 0.5000000000 or
    repr = "(parameter 0 (member findByToken *))" and t = "snk" and result = 0.2500000000 or
    repr = "(parameter 0 (member upload *))" and t = "snk" and result = 0.2500000000 or
    repr = "(member token (parameter req *))" and t = "snk" and result = 0.2500000000 or
    repr = "(member innerHTML (return (member createElement (parameter V *))))" and t = "snk" and result = 1.0000000000 or
    repr = "(parameter 2 (member forEach *))" and t = "snk" and result = 0.7500000000 or
    repr = "(return (member scope (parameter 0 (member forEach *))))" and t = "snk" and result = 0.0833333333 or
    repr = "(parameter 0 (member inheritedData *))" and t = "snk" and result = 0.2500000000 or
    repr = "(member $$path (parameter locationObj *))" and t = "snk" and result = 0.2500000000 or
    repr = "(return (member controller (parameter 0 (member forEach *))))" and t = "snk" and result = 0.0833333333 or
    repr = "(parameter 0 (member val *))" and t = "snk" and result = 0.2500000000 or
    repr = "(parameter 1 (member data *))" and t = "snk" and result = 0.2500000000 or
    repr = "(parameter 0 (member hasAttribute *))" and t = "snk" and result = 0.2500000000 or
    repr = "(parameter 0 (member splice *))" and t = "snk" and result = 0.2500000000 or
    repr = "(parameter 0 (parameter listener (parameter 1 (member forEach *))))" and t = "snk" and result = 0.2500000000 or
    repr = "(member $$url *)" and t = "snk" and result = 0.5000000000 or
    repr = "(member url (return (parameter 0 (member then *))))" and t = "snk" and result = 0.2500000000 or
    repr = "(parameter 1 (member insertAdjacentHTML *))" and t = "snk" and result = 1.0000000000 or
    repr = "(member innerHTML (parameter 0 (member observe *)))" and t = "snk" and result = 1.0000000000 or
    repr = "(parameter 0 (member child *))" and t = "snk" and result = 0.2500000000 or
    repr = "(parameter 0 (member set *))" and t = "snk" and result = 0.2500000000 or
    repr = "(member innerHTML (parameter e *))" and t = "snk" and result = 1.0000000000 or
    repr = "(parameter 0 (member setStudent *))" and t = "snk" and result = 0.5000000000 or
    repr = "(parameter 0 (member querySelectorAll *))" and t = "snk" and result = 0.0147058824 or
    repr = "(parameter 4 (return (member compile *)))" and t = "snk" and result = 0.0147058824 or
    repr = "(parameter 0 (member getElementById *))" and t = "snk" and result = 0.0147058824 or
    repr = "(parameter 0 (member contains *))" and t = "snk" and result = 0.0147058824 or
    repr = "(parameter 0 (member getElementsByClassName *))" and t = "snk" and result = 0.0147058824 or
    repr = "(parameter 3 (return (member compile *)))" and t = "snk" and result = 0.0147058824 or
    repr = "(member * (parameter target *))" and t = "snk" and result = 0.0147058824 or
    repr = "(parameter 0 (member compareDocumentPosition *))" and t = "snk" and result = 0.0147058824 or
    repr = "(parameter 0 (return (member compile *)))" and t = "snk" and result = 0.0147058824 or
    repr = "(return (member matchesSelector (member find (member jQuery (parameter window *)))))" and t = "snk" and result = 0.0147058824 or
    repr = "(parameter 1 (member call *))" and t = "snk" and result = 0.0147058824 or
    repr = "(return (member filter (parameter 0 (member extend *))))" and t = "snk" and result = 0.0147058824 or
    repr = "(parameter 2 (parameter postFinder *))" and t = "snk" and result = 0.0147058824 or
    repr = "(member success (parameter 1 (member call *)))" and t = "snk" and result = 0.5000000000 or
    repr = "(parameter 1 (member splice *))" and t = "snk" and result = 0.0147058824 or
    repr = "(member * (parameter seed *))" and t = "snk" and result = 0.0147058824 or
    repr = "(return (member compile (member find (member jQuery (parameter window *)))))" and t = "snk" and result = 0.0147058824 or
    repr = "(member * (parameter results *))" and t = "snk" and result = 0.0147058824 or
    repr = "(parameter 0 (parameter postFilter *))" and t = "snk" and result = 0.0147058824 or
    repr = "(return (member find (member jQuery (parameter window *))))" and t = "snk" and result = 0.0147058824 or
    repr = "(parameter 0 (parameter filter *))" and t = "snk" and result = 0.0147058824 or
    repr = "(parameter 0 (member slice *))" and t = "snk" and result = 0.0147058824 or
    repr = "(parameter 1 (return (member compile *)))" and t = "snk" and result = 0.0147058824 or
    repr = "(parameter 0 (member getElementsByTagName *))" and t = "snk" and result = 0.0147058824 or
    repr = "(return (member _encodeParams (parameter 0 (member Polymer *))))" and t = "snk" and result = 0.2000000000 or
    repr = "(parameter 0 (member _encodeParams *))" and t = "snk" and result = 0.2000000000 or
    repr = "(return (member value (member path (member properties *))))" and t = "snk" and result = 0.2500000000 or
    repr = "(return (member value (member hash (member properties *))))" and t = "snk" and result = 0.5000000000 or
    repr = "(parameter 0 (member * (return (member end *))))" and t = "snk" and result = 1.0000000000 or
    repr = "(parameter 1 (member write *))" and t = "snk" and result = 0.7500000000 or
    repr = "(parameter 0 (member trustAsHtml *))" and t = "snk" and result = 1.0000000000 or
    repr = "(member innerHTML (parameter 0 (member append *)))" and t = "snk" and result = 1.0000000000 or
    repr = "(member innerHTML (return (member getElementById (parameter document *))))" and t = "snk" and result = 1.0000000000 or
    repr = "(parameter 0 (member * (member handlers_ *)))" and t = "snk" and result = 0.2500000000 or
    repr = "(parameter 0 (member call *))" and t = "snk" and result = 0.2500000000 or
    repr = "(member privateDoNotAccessOrElseSafeStyleSheetWrappedValue_ (return (member initSecurityPrivateDoNotAccessOrElse_ (member prototype (member SafeStyleSheet *)))))" and t = "snk" and result = 0.2500000000 or
    repr = "(member timer_ (instance (member Timer (member goog (global)))))" and t = "snk" and result = 0.2500000000 or
    repr = "(member domain_ (return (member setDomain (member prototype (member Uri *)))))" and t = "snk" and result = 0.2500000000 or
    repr = "(member innerHTML (parameter 0 (member render *)))" and t = "snk" and result = 1.0000000000 or
    repr = "(member innerHTML (parameter node *))" and t = "snk" and result = 0.2500000000 or
    repr = "(member href (parameter anchor *))" and t = "snk" and result = 0.2500000000 or
    repr = "(parameter 0 (parameter resolve (parameter 0 (return (member require *)))))" and t = "snk" and result = 0.2500000000 or
    repr = "(member outerHTML (parameter elem *))" and t = "snk" and result = 1.0000000000 or
    repr = "(parameter 0 (member detachEvent *))" and t = "snk" and result = 0.2500000000 or
    repr = "(member innerHTML (parameter 0 (member createFromNodeContents *)))" and t = "snk" and result = 1.0000000000 or
    repr = "(member innerHTML (parameter 0 (member removeChildren *)))" and t = "snk" and result = 1.0000000000 or
    repr = "(member innerHTML (parameter 0 (return (member require *))))" and t = "snk" and result = 1.0000000000 or
    repr = "(member search (member location (return (member getWindow (member domHelper_ *)))))" and t = "snk" and result = 0.7500000000 or
    repr = "(member privateDoNotAccessOrElseSafeUrlWrappedValue_ (instance (member SafeUrl (member html *))))" and t = "snk" and result = 0.5000000000 or
    repr = "(member * (parameter cfg *))" and t = "snk" and result = 0.2500000000 or
    repr = "(return (member testWindowWontReceiveFromWrongOrigin (parameter 0 (return (member require *)))))" and t = "snk" and result = 0.0833333333 or
    repr = "(member innerHTML (parameter 1 (member assertHtmlContentsMatch *)))" and t = "snk" and result = 1.0000000000 or
    repr = "(member * (member map_ (instance (member Map (member structs *)))))" and t = "snk" and result = 0.2500000000 or
    repr = "(return (member * (parameter listener *)))" and t = "snk" and result = 0.2500000000 or
    repr = "(member innerHTML (parameter 0 (member decorate *)))" and t = "snk" and result = 1.0000000000 or
    repr = "(member innerHTML (parameter 1 (member fireMouseOverEvent *)))" and t = "snk" and result = 1.0000000000 or
    repr = "(return (member testWindowCanceled (parameter 0 (return (member require *)))))" and t = "snk" and result = 0.0833333333 or
    repr = "(member innerHTML (parameter 0 (member setTextContent *)))" and t = "snk" and result = 1.0000000000 or
    repr = "(member innerHTML (parameter element *))" and t = "snk" and result = 1.0000000000 or
    repr = "(return (member testWindowWontSendToWrongOrigin (parameter 0 (return (member require *)))))" and t = "snk" and result = 0.0833333333 or
    repr = "(parameter 0 (member onFulfilled *))" and t = "snk" and result = 0.2500000000 or
    repr = "(member channelName (instance (member Message_ (member DirectTransport (member xpc *)))))" and t = "snk" and result = 0.2500000000 or
    repr = "(member type (instance (member Listener (member events *))))" and t = "snk" and result = 0.2500000000 or
    repr = "(member privateDoNotAccessOrElseSafeHtmlWrappedValue_ (return (member initSecurityPrivateDoNotAccessOrElse_ (member prototype (member SafeHtml *)))))" and t = "snk" and result = 0.7500000000 or
    repr = "(member innerHTML (member body (member document (member contentWindow *))))" and t = "snk" and result = 1.0000000000 or
    repr = "(member deltaY (parameter 0 (member call *)))" and t = "snk" and result = 0.2500000000 or
    repr = "(parameter 0 (member dispatchEvent *))" and t = "snk" and result = 0.3750000000 or
    repr = "(return (parameter 0 (member info *)))" and t = "snk" and result = 0.2500000000 or
    repr = "(return (member error (member on (parameter obj *))))" and t = "snk" and result = 0.0568181818 or
    repr = "(parameter 0 (member SafeString *))" and t = "snk" and result = 1.0000000000 or
    repr = "(member body (parameter obj *))" and t = "snk" and result = 0.0568181818 or
    repr = "(return (member response (member on (parameter obj *))))" and t = "snk" and result = 0.0568181818 or
    repr = "(parameter 0 (member request *))" and t = "snk" and result = 0.0568181818 or
    repr = "(return (member request_error (member on (parameter obj *))))" and t = "snk" and result = 0.0568181818 or
    repr = "(return (parameter 0 (member filter *)))" and t = "snk" and result = 0.2500000000 or
    repr = "(parameter 0 (member includes *))" and t = "snk" and result = 0.1666666667 or
    repr = "(member expression (member arguments (parameter 0 (member req (member client *)))))" and t = "snk" and result = 0.7500000000 or
    repr = "(member innerHTML (parameter el *))" and t = "snk" and result = 1.0000000000 or
    repr = "(return (parameter 1 (member registerHelper *)))" and t = "snk" and result = 0.7500000000 or
    repr = "(parameter 1 (member spawn *))" and t = "snk" and result = 0.3750000000 or
    repr = "(member arguments (parameter 0 (member req *)))" and t = "snk" and result = 0.5000000000 or
    repr = "(member innerHTML (parameter 1 (member overlayPage *)))" and t = "snk" and result = 1.0000000000 or
    repr = "(member innerHTML (member parentNode (member * (return (member getElementsByTagName *)))))" and t = "snk" and result = 1.0000000000 or
    repr = "(member innerHTML (member csimanagerdivdelayed (member all (member document (global)))))" and t = "snk" and result = 1.0000000000 or
    repr = "(member innerHTML (parameter 0 (member setAttrs *)))" and t = "snk" and result = 1.0000000000 or
    repr = "(member innerHTML (return (member createElement (parameter e *))))" and t = "snk" and result = 1.0000000000
}}