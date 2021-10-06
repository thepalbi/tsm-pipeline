module TsmRepr {
  float getReprScore(string repr, string t){
   repr = "(member * (instance (member constructor *)))" and t = "snk" and result = 0.2500000000 or
   repr = "(member * (member style *))" and t = "snk" and result = 0.2500000000 or
   repr = "(member * (parameter 1 (member data *)))" and t = "snk" and result = 0.2500000000 or
   repr = "(member * (parameter a (member apply *)))" and t = "snk" and result = 0.2500000000 or
   repr = "(member * (parameter elem (member trigger *)))" and t = "snk" and result = 0.2500000000 or
   repr = "(member * (parameter target (member apply *)))" and t = "snk" and result = 0.2500000000 or
   repr = "(member * (return (member clone *)))" and t = "snk" and result = 0.2500000000 or
   repr = "(member * (return (member match *)))" and t = "snk" and result = 0.2727272700 or
   repr = "(member * (return (member set *)))" and t = "snk" and result = 0.2500000000 or
   repr = "(member * (return (member tokenize *)))" and t = "snk" and result = 0.3958333333 or
   repr = "(member __html (member dangerouslySetInnerHTML *))" and t = "snk" and result = 1.0000000000 or
   repr = "(member _d (parameter b (member updateOffset *)))" and t = "snk" and result = 0.0142276420 or
   repr = "(member _links (member tz *))" and t = "snk" and result = 0.0142276420 or
   repr = "(member _loadMsg (parameter 1 (member proxy *)))" and t = "snk" and result = 0.5000000000 or
   repr = "(member _z (parameter b (member updateOffset *)))" and t = "snk" and result = 0.0142276420 or
   repr = "(member abbrs (instance (member Zone *)))" and t = "snk" and result = 0.0142276420 or
   repr = "(member createdAt (parameter 0 (member send *)))" and t = "snk" and result = 0.1250000000 or
   repr = "(member currentTarget (parameter 0 (member extend *)))" and t = "snk" and result = 0.2500000000 or
   repr = "(member deps (parameter 0 (member requirejs (global))))" and t = "snk" and result = 0.2500000000 or
   repr = "(member engine (parameter 1 (member render *)))" and t = "snk" and result = 0.2500000000 or
   repr = "(member event (return (member _triggerWithDeprecated *)))" and t = "snk" and result = 0.1785714300 or
   repr = "(member hostname (return (member parseUrl *)))" and t = "snk" and result = 0.2500000000 or
   repr = "(member html (parameter 0 (member sendMail *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (instance (member Element *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (member 0 (return (member getElementsByTagName *))))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (member 1 (member rows *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (member _element *))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (member _paginationContainer *))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (member body *))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (member button *))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (member documentElement *))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (member element *))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (member firstChild *))" and t = "snk" and result = 0.5000000000 or
   repr = "(member innerHTML (member getElementById *))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (member h *))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (member head *))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (member hint *))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (member lastChild *))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (member replacedWith *))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (member target *))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (member widget *))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member AnnotatedTimeLine *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member ColumnChart *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member LineChart *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member MergeView *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member _setContentMargin *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member addDomListener *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member append *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member appendChild *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member appendNonWebKitResults (global))))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member applyStyles *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member arrayCopyChildNodes *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member before *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member check_children (global))))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member childNodes *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member contains *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member createGroupSelectButtons_ *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member executeInlineScripts *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member expect (global))))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member forward *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member fragmentToTestOutput (global))))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member getComputedStyle (global))))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member get_xhtml (global))))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member highlightElement (global))))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member html *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member insertBefore *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member insertNode *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member instanceTemplate *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member isEqualNode *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member jQuery (global))))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member nodeStream *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member on *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member outerHTML *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member parseElement *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member prepareTemplate_ *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member push *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member removeChild *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member replaceChild *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member replaceWith *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member selectNode *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member selectNodeContents *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member setAttribs *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member setDragImage *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member setElementShown *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member setStyle *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member testInsertNode (global))))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member w (global))))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 1 (member addLineWidget *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 1 (member bind *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 1 (member buildMenu *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 1 (member call *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 1 (member childrenToNode_ *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 1 (member insertBefore *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 1 (member jstProcess (global))))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 1 (member overlayPage *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 3 (member _cleanupHTML *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 3 (member createElement *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter a (member write *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter a *))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter b (member edit *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter e (member edit *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter el (member button *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter el (member edit *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter elem (member setInnerHtml *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter element (member localizeElementFromTag *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter element (member setStyles *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter node (member selectNode *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter t (member createIcon *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (return (member appendChild *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (return (member cloneNode *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (return (member createElement *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (return (member createElementNS *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (return (member getAsDom *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (return (member getElementById *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (return (member makeZeroWidthSpan *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (return (member querySelector *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (return (member showProgressIndicatorInTouchDevice *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML *)" and t = "snk" and result = 1.0000000000 or
   repr = "(member instanceKey (member options *))" and t = "snk" and result = 0.5000000000 or
   repr = "(member items (return (parameter 0 (member map *))))" and t = "snk" and result = 0.1666666700 or
   repr = "(member maxWidth (member style *))" and t = "snk" and result = 0.2500000000 or
   repr = "(member messageCreated (parameter 0 (member json *)))" and t = "snk" and result = 0.5000000000 or
   repr = "(member messageRetrieved (parameter 0 (member json *)))" and t = "snk" and result = 0.5000000000 or
   repr = "(member name (instance (member Zone *)))" and t = "snk" and result = 0.0142276420 or
   repr = "(member namespace (parameter event (member trigger *)))" and t = "snk" and result = 0.5000000000 or
   repr = "(member next (return (member defaultButtonText *)))" and t = "snk" and result = 0.2500000000 or
   repr = "(member number (parameter 0 (member Phone *)))" and t = "snk" and result = 0.1785714300 or
   repr = "(member offsets (instance (member Zone *)))" and t = "snk" and result = 0.0142276420 or
   repr = "(member os (parameter 1 (member render *)))" and t = "snk" and result = 0.2500000000 or
   repr = "(member outerHTML (member body *))" and t = "snk" and result = 1.0000000000 or
   repr = "(member outerHTML (member documentElement *))" and t = "snk" and result = 1.0000000000 or
   repr = "(member outerHTML (parameter 0 (member appendChild *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member outerHTML (parameter elem (member setOuterHtml *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member outerHTML (return (member getElementById *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member outerHTML *)" and t = "snk" and result = 1.0000000000 or
   repr = "(member password (return (member parseUrl *)))" and t = "snk" and result = 0.2500000000 or
   repr = "(member population (instance (member Zone *)))" and t = "snk" and result = 0.0142276420 or
   repr = "(member query (parameter 0 (member extend *)))" and t = "snk" and result = 0.2500000000 or
   repr = "(member selector (parameter 1 (member makeArray *)))" and t = "snk" and result = 0.2500000000 or
   repr = "(member shareContent (parameter 0 (member setState *)))" and t = "snk" and result = 0.5000000000 or
   repr = "(member state (parameter 0 (member send *)))" and t = "snk" and result = 0.2500000000 or
   repr = "(member statusText (parameter 1 (member call *)))" and t = "snk" and result = 0.2500000000 or
   repr = "(member template (parameter 0 (member default *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member today (return (member defaultButtonText *)))" and t = "snk" and result = 0.2500000000 or
   repr = "(member token (parameter 0 (member send *)))" and t = "snk" and result = 0.2500000000 or
   repr = "(member tz (parameter a *))" and t = "snk" and result = 0.0142276420 or
   repr = "(member untils (instance (member Zone *)))" and t = "snk" and result = 0.0142276420 or
   repr = "(member url (parameter 2 (member streamFrame *)))" and t = "snk" and result = 0.5000000000 or
   repr = "(member userInfo (parameter 0 (member json *)))" and t = "snk" and result = 0.2500000000 or
   repr = "(member username (member userInfo *))" and t = "snk" and result = 0.2500000000 or
   repr = "(member value (member value *))" and t = "snk" and result = 0.1666666700 or
   repr = "(member value (parameter 2 (member set *)))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 0 (member $ (global)))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member * (global)))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member * (member $element *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member * (member icon *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member * (member length *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member * (member nav *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member * (member ul *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member * (parameter $element *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member * (parameter a *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member * (parameter e *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member * (parameter input *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member * (return (member attr *))))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member * (return (member empty *))))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member * (return (member end *))))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member * (return (member find *))))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member * (return (member get *))))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member * (return (parameter $ *))))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member * (return (parameter a *))))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member * (return (parameter b *))))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member * (return (parameter e *))))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member * (return (parameter f *))))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member * (return (parameter jQuery *))))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member Phone *))" and t = "snk" and result = 0.1785714300 or
   repr = "(parameter 0 (member SafeString *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member _enhance *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 0 (member _getRegExp *))" and t = "snk" and result = 0.0775171625 or
   repr = "(parameter 0 (member _index *))" and t = "snk" and result = 0.0142276420 or
   repr = "(parameter 0 (member _set *))" and t = "snk" and result = 0.0142276420 or
   repr = "(parameter 0 (member add *))" and t = "snk" and result = 0.1714092140 or
   repr = "(parameter 0 (member addClass *))" and t = "snk" and result = 0.5000000000 or
   repr = "(parameter 0 (member after *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member ajax *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 0 (member animationComplete *))" and t = "snk" and result = 0.5000000000 or
   repr = "(parameter 0 (member append *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member appendChild *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member appendTo *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member apply *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 0 (member before *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member bypassSecurityTrustHtml *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member call *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 0 (member createContextualFragment *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member createElement *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member default *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member each *))" and t = "snk" and result = 0.3125000000 or
   repr = "(parameter 0 (member element *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member end *))" and t = "snk" and result = 0.1250000000 or
   repr = "(parameter 0 (member extend *))" and t = "snk" and result = 0.1250000000 or
   repr = "(parameter 0 (member format *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 0 (member get *))" and t = "snk" and result = 0.3273809500 or
   repr = "(parameter 0 (member getElementsByTagName *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 0 (member go *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 0 (member html *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member indexOf *))" and t = "snk" and result = 0.4027777800 or
   repr = "(parameter 0 (member insertAfter *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member insertBefore *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member jQuery (global)))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member json *))" and t = "snk" and result = 0.5000000000 or
   repr = "(parameter 0 (member monthsParse *))" and t = "snk" and result = 0.0681818180 or
   repr = "(parameter 0 (member mozGetAsFile *))" and t = "snk" and result = 0.0775171625 or
   repr = "(parameter 0 (member navigate *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 0 (member offset *))" and t = "snk" and result = 0.0142276420 or
   repr = "(parameter 0 (member parse *))" and t = "snk" and result = 0.0142276420 or
   repr = "(parameter 0 (member parseFromString *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member prepend *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member prependTo *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member querySelectorAll *))" and t = "snk" and result = 0.4583333350 or
   repr = "(parameter 0 (member reject *))" and t = "snk" and result = 0.1785714300 or
   repr = "(parameter 0 (member replaceWith *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member send *))" and t = "snk" and result = 0.5000000000 or
   repr = "(parameter 0 (member setState *))" and t = "snk" and result = 0.5000000000 or
   repr = "(parameter 0 (member substring *))" and t = "snk" and result = 0.3125000000 or
   repr = "(parameter 0 (member text *))" and t = "snk" and result = 0.3500000000 or
   repr = "(parameter 0 (member trustAsHtml *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member undefined (global)))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member update *))" and t = "snk" and result = 0.7500000000 or
   repr = "(parameter 0 (member utc *))" and t = "snk" and result = 0.0142276420 or
   repr = "(parameter 0 (member window (global)))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member wrap *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member wrapAll *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member wrapInner *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member write *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member writeHead *))" and t = "snk" and result = 0.1250000000 or
   repr = "(parameter 0 (member writeln *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member zone *))" and t = "snk" and result = 0.0142276420 or
   repr = "(parameter 0 (parameter 0 (member apply *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (parameter 0 (member isFunction *)))" and t = "snk" and result = 0.2095238100 or
   repr = "(parameter 0 (parameter 0 (member spyOn (global))))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (parameter 1 (member Sanitize (global))))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (parameter 1 (member extend *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (parameter filter *))" and t = "snk" and result = 0.5625000000 or
   repr = "(parameter 0 (parameter fn (parameter 1 (member forEach *))))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 0 (parameter h (member render *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (return (member require (global))))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (root https://www.npmjs.com/package/jquery))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (root https://www.npmjs.com/package/moment))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 1 (member * (member sparkline *)))" and t = "snk" and result = 0.5000000000 or
   repr = "(parameter 1 (member append *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 1 (member apply *))" and t = "snk" and result = 0.3214285700 or
   repr = "(parameter 1 (member call *))" and t = "snk" and result = 0.2916666667 or
   repr = "(parameter 1 (member css *))" and t = "snk" and result = 0.1500000000 or
   repr = "(parameter 1 (member data *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 1 (member insertAdjacentElement *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 1 (member insertAdjacentHTML *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 1 (member insertBefore *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 1 (member isPermittedCrossDomainRequest *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 1 (member listenTo *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 1 (member pagecontainer *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 1 (member prepend *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 1 (member render *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 1 (member setAttribute *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 1 (member substring *))" and t = "snk" and result = 0.5000000000 or
   repr = "(parameter 1 (member trigger *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 1 (member write *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 1 (member writeFileSync *))" and t = "snk" and result = 0.4416666667 or
   repr = "(parameter 2 (member append *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 2 (member forEach *))" and t = "snk" and result = 0.5000000000 or
   repr = "(parameter 2 (member resolve *))" and t = "snk" and result = 0.3750000000 or
   repr = "(parameter 2 (member setAttributeNS *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 2 (member streamFrame *))" and t = "snk" and result = 0.5000000000 or
   repr = "(parameter 2 (member write *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 2 (member writeHead *))" and t = "snk" and result = 0.1250000000 or
   repr = "(parameter 3 (member append *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 4 (member append *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 5 (member append *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 6 (member append *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 7 (member append *))" and t = "snk" and result = 1.0000000000 or
   repr = "(return (member * (parameter 1 (member extend *))))" and t = "snk" and result = 0.3482142850 or
   repr = "(return (member _buildURL *))" and t = "snk" and result = 0.5000000000 or
   repr = "(return (member _getActionUrl *))" and t = "snk" and result = 0.5000000000 or
   repr = "(return (member _getRegExp *))" and t = "snk" and result = 0.0775171625 or
   repr = "(return (member _isRegExpOption *))" and t = "snk" and result = 0.0775171625 or
   repr = "(return (member abbr *))" and t = "snk" and result = 0.0142276420 or
   repr = "(return (member convertUrlToDataUrl *))" and t = "snk" and result = 0.1428571400 or
   repr = "(return (member cookie *))" and t = "snk" and result = 0.3357142860 or
   repr = "(return (member css *))" and t = "snk" and result = 0.3750000000 or
   repr = "(return (member get *))" and t = "snk" and result = 0.2500000000 or
   repr = "(return (member handle *))" and t = "snk" and result = 0.2500000000 or
   repr = "(return (member hashToSelector *))" and t = "snk" and result = 0.7500000000 or
   repr = "(return (member offset *))" and t = "snk" and result = 0.0142276420 or
   repr = "(return (member offsetParent *))" and t = "snk" and result = 0.3750000000 or
   repr = "(return (member parse *))" and t = "snk" and result = 0.0821138210 or
   repr = "(return (member parseTwoDigitYear *))" and t = "snk" and result = 0.2045454500 or
   repr = "(return (member prop *))" and t = "snk" and result = 0.2500000000 or
   repr = "(return (member send *))" and t = "snk" and result = 0.5000000000 or
   repr = "(return (member statusCode *))" and t = "snk" and result = 0.2500000000 or
   repr = "(return (member stripHash *))" and t = "snk" and result = 0.1428571400 or
   repr = "(return (member suggestion *))" and t = "snk" and result = 1.0000000000 or
   repr = "(return (member trigger *))" and t = "snk" and result = 0.5000000000 or
   repr = "(return (member type *))" and t = "snk" and result = 0.2500000000 or
   repr = "(return (member uniqueSort *))" and t = "snk" and result = 0.2500000000 or
   repr = "(return (parameter 0 (member extend *)))" and t = "snk" and result = 0.2500000000 or
   repr = "(return (parameter 1 (member addMethod *)))" and t = "snk" and result = 0.5000000000 or
   repr = "(return (parameter 1 (member all *)))" and t = "snk" and result = 0.7500000000 or
   repr = "(return (parameter 1 (member replace *)))" and t = "snk" and result = 0.2250000000 or
   repr = "(return (parameter 2 (member readFile *)))" and t = "snk" and result = 0.2500000000 or
   repr = "(return (return (member proxy *)))" and t = "snk" and result = 0.2500000000
   } 
}
