module TsmRepr {
  float getReprScore(string repr, string t){
   repr = "(member * (instance (member constructor *)))" and t = "snk" and result = 0.2500000000 or
   repr = "(member * (member style *))" and t = "snk" and result = 0.2500000000 or
   repr = "(member * (parameter 0 (member apply *)))" and t = "snk" and result = 0.0166666670 or
   repr = "(member * (parameter 0 (member call *)))" and t = "snk" and result = 0.0166666670 or
   repr = "(member * (parameter 0 (member concat *)))" and t = "snk" and result = 0.0691489360 or
   repr = "(member * (parameter 0 (member extend *)))" and t = "snk" and result = 0.1250000000 or
   repr = "(member * (parameter 0 (member map *)))" and t = "snk" and result = 0.5000000000 or
   repr = "(member * (parameter a (member apply *)))" and t = "snk" and result = 0.1333333335 or
   repr = "(member * (parameter data (member addQuery *)))" and t = "snk" and result = 0.2500000000 or
   repr = "(member * (parameter e (member apply *)))" and t = "snk" and result = 0.2500000000 or
   repr = "(member * (parameter elem (member trigger *)))" and t = "snk" and result = 0.3750000000 or
   repr = "(member * (parameter r (member trigger *)))" and t = "snk" and result = 0.5000000000 or
   repr = "(member * (parameter target (member apply *)))" and t = "snk" and result = 0.2500000000 or
   repr = "(member * (return (member Array (global))))" and t = "snk" and result = 0.2500000000 or
   repr = "(member * (return (member clone *)))" and t = "snk" and result = 0.2500000000 or
   repr = "(member * (return (member exec *)))" and t = "snk" and result = 0.2500000000 or
   repr = "(member * (return (member set *)))" and t = "snk" and result = 0.2500000000 or
   repr = "(member * (return (member tokenize *)))" and t = "snk" and result = 0.3593750025 or
   repr = "(member 0 (parameter 1 (member compile *)))" and t = "snk" and result = 0.0166666670 or
   repr = "(member __html (member dangerouslySetInnerHTML *))" and t = "snk" and result = 1.0000000000 or
   repr = "(member attendenceData (parameter 0 (member json *)))" and t = "snk" and result = 0.1250000000 or
   repr = "(member content-length (member headers *))" and t = "snk" and result = 0.0614801865 or
   repr = "(member data (member data *))" and t = "snk" and result = 0.1250000000 or
   repr = "(member data (parameter 0 (member default *)))" and t = "snk" and result = 0.1250000000 or
   repr = "(member event (return (member _triggerWithDeprecated *)))" and t = "snk" and result = 0.1071428600 or
   repr = "(member handlePosition *)" and t = "snk" and result = 0.0357142860 or
   repr = "(member headers (parameter 0 (member request *)))" and t = "snk" and result = 0.0576923075 or
   repr = "(member headers *)" and t = "snk" and result = 0.0909090910 or
   repr = "(member hostname (return (member parseUrl *)))" and t = "snk" and result = 0.2500000000 or
   repr = "(member html (parameter 0 (member sendMail *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (member 0 (return (member getElementsByTagName *))))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (member 3 (member cells *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (member body *))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (member button *))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (member documentElement *))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (member firstChild *))" and t = "snk" and result = 0.7857142857 or
   repr = "(member innerHTML (member h *))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (member head *))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (member lastChild *))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (member parentNode *))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (member template *))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member TestHelper *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member _css (global))))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member _mm_addClass (global))))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member _show (global))))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member addDomListener *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member append *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member appendChild *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member arrayCopyChildNodes *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member check_children (global))))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member close *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member contains *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member createFromNodeContents *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member createMouseEvent (global))))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member decorate *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member destroyNode *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member disableSelection *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member embed *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member findInChildren *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member fragmentToTestOutput (global))))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member fromElement *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member getComputedStyle (global))))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member getElementById *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member getNodeAtOffset *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member getOuterHtml *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member haveSameAllChildAttribs *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member hideelem (global))))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member html *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member insertAfter (global))))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member insertBefore *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member insertNode *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member isEmpty *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member isEmptyBlock *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member isEqualNode *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member jQuery (global))))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member observe *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member on *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member parseElement *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member push *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member removeChild *)))" and t = "snk" and result = 0.9772727273 or
   repr = "(member innerHTML (parameter 0 (member removeChildren *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member render *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member replaceChild *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member selectNode *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member selectNodeContents *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member setDragImage *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member setStyle *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member shoestring (global))))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member showelem (global))))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member style *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member testInsertNode (global))))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member touch *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 1 (member addLineWidget *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 1 (member assertHtmlContentsMatch *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 1 (member bind *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 1 (member call *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 1 (member childrenToNode_ *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 1 (member drawSurveyForm (global))))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 1 (member haveSameAllChildAttribs *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 1 (member insertBefore *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 1 (member insertRow *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 1 (member log *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 1 (member moveChild *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 1 (member overlayPage *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 1 (member previewRender *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 2 (member bind *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 2 (member log *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 2 (member splitDom_ *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 3 (member call *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 3 (member createElement *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 3 (member render *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 4 (member call *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 5 (member showHideFile (global))))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter a (member __init__ *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter a (member write *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter b (member edit *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter e (member edit *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter el (member button *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter el (member edit *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter elSpan (member _switchFontInnerToSpan *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter elem (member setInnerHtml *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter element (member renderElement *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter element (member setStyles *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter form (member setParameters_ *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter m (member edit *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter node (member selectNode *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter oldIcon (member createIcon *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter t (member createIcon *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter target (member create *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter v (member useBespin *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (return (member appendChild *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (return (member cloneNode *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (return (member createDocumentFragment *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (return (member createElement *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (return (member createElementNS *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (return (member createScript *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (return (member createTitleSpan *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (return (member entry *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (return (member getAsDom *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (return (member getContainer *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (return (member getElementById (global))))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (return (member getElementById *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (return (member getElementByName (global))))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (return (member insertCell *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (return (member querySelector *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML *)" and t = "snk" and result = 1.0000000000 or
   repr = "(member lastIndex (member start *))" and t = "snk" and result = 0.0300000000 or
   repr = "(member maxWidth (member style *))" and t = "snk" and result = 0.2500000000 or
   repr = "(member method (parameter 0 (member request *)))" and t = "snk" and result = 0.0833333330 or
   repr = "(member minWidth (member style *))" and t = "snk" and result = 0.2500000000 or
   repr = "(member name *)" and t = "snk" and result = 0.0909090910 or
   repr = "(member next (return (member buttonText *)))" and t = "snk" and result = 0.7500000000 or
   repr = "(member originalEvent (parameter 0 (member extend *)))" and t = "snk" and result = 0.2500000000 or
   repr = "(member outerHTML (member body *))" and t = "snk" and result = 1.0000000000 or
   repr = "(member outerHTML (member documentElement *))" and t = "snk" and result = 1.0000000000 or
   repr = "(member outerHTML (parameter 0 (member appendChild *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member outerHTML (parameter elem (member setOuterHtml *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member outerHTML (return (member getElementById *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member outerHTML *)" and t = "snk" and result = 1.0000000000 or
   repr = "(member path (member _parts *))" and t = "snk" and result = 0.2500000000 or
   repr = "(member protocol (member _parts *))" and t = "snk" and result = 0.2500000000 or
   repr = "(member reactionName (member data *))" and t = "snk" and result = 0.1250000000 or
   repr = "(member result (parameter t (member trigger *)))" and t = "snk" and result = 0.2500000000 or
   repr = "(member sql (return (member getSQL *)))" and t = "snk" and result = 0.0714285710 or
   repr = "(member target (parameter 0 (member extend *)))" and t = "snk" and result = 0.2500000000 or
   repr = "(member template (parameter 0 (member default *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member template (parameter 1 (member component *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member token (member user *))" and t = "snk" and result = 0.1875000000 or
   repr = "(member type (parameter b (member trigger *)))" and t = "snk" and result = 0.2500000000 or
   repr = "(member url (parameter 0 (member ajax *)))" and t = "snk" and result = 0.2000000000 or
   repr = "(member url (parameter 2 (member streamFrame *)))" and t = "snk" and result = 0.5000000000 or
   repr = "(member url (parameter 3 (member extend *)))" and t = "snk" and result = 0.1071428600 or
   repr = "(member url (parameter settings *))" and t = "snk" and result = 0.1071428600 or
   repr = "(member user (parameter 0 (member json *)))" and t = "snk" and result = 0.1875000000 or
   repr = "(member username (parameter parts (member parseUserinfo *)))" and t = "snk" and result = 0.2500000000 or
   repr = "(member value (return (parameter 1 (member map *))))" and t = "snk" and result = 0.0166666670 or
   repr = "(member voteOption (member data *))" and t = "snk" and result = 0.1250000000 or
   repr = "(parameter 0 (member $ (global)))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member * (global)))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member * (member $dragshadow *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member * (member $element *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member * (member icon *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member * (member nav *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member * (member ul *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member * (parameter $element *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member * (parameter e *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member * (parameter input *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member * (parameter t *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member * (return (member append *))))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member * (return (member attr *))))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member * (return (member empty *))))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member * (return (member find *))))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member * (return (member get *))))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member * (return (parameter $ *))))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member * (return (parameter f *))))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member SafeString *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member _getRegExp *))" and t = "snk" and result = 0.0916149085 or
   repr = "(parameter 0 (member _isRegExpOption *))" and t = "snk" and result = 0.1071428600 or
   repr = "(parameter 0 (member add *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 0 (member after *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member ajax *))" and t = "snk" and result = 0.1857142867 or
   repr = "(parameter 0 (member animationComplete *))" and t = "snk" and result = 0.5000000000 or
   repr = "(parameter 0 (member append *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member appendChild *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member appendText *))" and t = "snk" and result = 0.1008403400 or
   repr = "(parameter 0 (member appendTo *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member apply *))" and t = "snk" and result = 0.1249999980 or
   repr = "(parameter 0 (member arrayForEach *))" and t = "snk" and result = 0.0263157890 or
   repr = "(parameter 0 (member arrayMap *))" and t = "snk" and result = 0.0263157890 or
   repr = "(parameter 0 (member arrayRemoveItem *))" and t = "snk" and result = 0.0263157890 or
   repr = "(parameter 0 (member before *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member clearInterval *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 0 (member clearTimeout *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 0 (member compareArrays *))" and t = "snk" and result = 0.0263157890 or
   repr = "(parameter 0 (member compareDocumentPosition *))" and t = "snk" and result = 0.0166666670 or
   repr = "(parameter 0 (member contains *))" and t = "snk" and result = 0.0166666670 or
   repr = "(parameter 0 (member createContextualFragment *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member createElement *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member createReadStream *))" and t = "snk" and result = 0.1500000000 or
   repr = "(parameter 0 (member createWriteStream *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 0 (member css *))" and t = "snk" and result = 0.0357142860 or
   repr = "(parameter 0 (member default *))" and t = "snk" and result = 0.5625000000 or
   repr = "(parameter 0 (member doMove *))" and t = "snk" and result = 0.0357142860 or
   repr = "(parameter 0 (member element *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member end *))" and t = "snk" and result = 0.3910256410 or
   repr = "(parameter 0 (member evaluate *))" and t = "snk" and result = 0.5000000000 or
   repr = "(parameter 0 (member execSync *))" and t = "snk" and result = 0.7500000000 or
   repr = "(parameter 0 (member exists *))" and t = "snk" and result = 0.1500000000 or
   repr = "(parameter 0 (member extend *))" and t = "snk" and result = 0.0263157890 or
   repr = "(parameter 0 (member filter *))" and t = "snk" and result = 0.1538461500 or
   repr = "(parameter 0 (member find *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 0 (member fixUpContinuousNodeArray *))" and t = "snk" and result = 0.0263157890 or
   repr = "(parameter 0 (member fn *))" and t = "snk" and result = 0.0714285710 or
   repr = "(parameter 0 (member getElementById *))" and t = "snk" and result = 0.0166666670 or
   repr = "(parameter 0 (member getElementsByClassName *))" and t = "snk" and result = 0.0166666670 or
   repr = "(parameter 0 (member getElementsByTagName *))" and t = "snk" and result = 0.1333333335 or
   repr = "(parameter 0 (member html *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member indexOf *))" and t = "snk" and result = 0.3090277800 or
   repr = "(parameter 0 (member insertAfter *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member insertBefore *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member isArray *))" and t = "snk" and result = 0.3333333300 or
   repr = "(parameter 0 (member jQuery (global)))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member json *))" and t = "snk" and result = 0.1250000000 or
   repr = "(parameter 0 (member lstatSync *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 0 (member makeHandlePositionStyle *))" and t = "snk" and result = 0.0357142860 or
   repr = "(parameter 0 (member map *))" and t = "snk" and result = 0.0909090910 or
   repr = "(parameter 0 (member move *))" and t = "snk" and result = 0.0357142860 or
   repr = "(parameter 0 (member mozGetAsFile *))" and t = "snk" and result = 0.0760869570 or
   repr = "(parameter 0 (member navigate *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 0 (member parseFromString *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member prepend *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member prependTo *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member querySelectorAll *))" and t = "snk" and result = 0.1333333335 or
   repr = "(parameter 0 (member readFileSync *))" and t = "snk" and result = 0.2243589760 or
   repr = "(parameter 0 (member readdirSync *))" and t = "snk" and result = 0.0320512820 or
   repr = "(parameter 0 (member registerEventHandler *))" and t = "snk" and result = 0.0263157890 or
   repr = "(parameter 0 (member reject *))" and t = "snk" and result = 0.1071428600 or
   repr = "(parameter 0 (member removeChild *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 0 (member removeClass *))" and t = "snk" and result = 0.0357142860 or
   repr = "(parameter 0 (member replaceWith *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member request *))" and t = "snk" and result = 0.0687645687 or
   repr = "(parameter 0 (member send *))" and t = "snk" and result = 0.7500000000 or
   repr = "(parameter 0 (member set *))" and t = "snk" and result = 0.0263157890 or
   repr = "(parameter 0 (member setFileName *))" and t = "snk" and result = 0.1008403400 or
   repr = "(parameter 0 (member setHandlePosition *))" and t = "snk" and result = 0.0357142860 or
   repr = "(parameter 0 (member shoestring (global)))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member slice *))" and t = "snk" and result = 0.0233333335 or
   repr = "(parameter 0 (member stat *))" and t = "snk" and result = 0.2000000000 or
   repr = "(parameter 0 (member statSync *))" and t = "snk" and result = 0.0320512820 or
   repr = "(parameter 0 (member test *))" and t = "snk" and result = 0.0300000000 or
   repr = "(parameter 0 (member text *))" and t = "snk" and result = 0.1785714300 or
   repr = "(parameter 0 (member trim *))" and t = "snk" and result = 0.1008403400 or
   repr = "(parameter 0 (member trustAsHtml *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member undefined (global)))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member unlink *))" and t = "snk" and result = 0.5000000000 or
   repr = "(parameter 0 (member update *))" and t = "snk" and result = 0.7500000000 or
   repr = "(parameter 0 (member window (global)))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member wrap *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member wrapAll *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member wrapInner *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member write *))" and t = "snk" and result = 0.9642008318 or
   repr = "(parameter 0 (member writeFile *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 0 (member writeln *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (parameter $ (member exports *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (parameter 0 (member apply *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (parameter 0 (member isFunction *)))" and t = "snk" and result = 0.1688311700 or
   repr = "(parameter 0 (parameter a *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 0 (parameter c *))" and t = "snk" and result = 0.0166666670 or
   repr = "(parameter 0 (parameter callback (member withinString *)))" and t = "snk" and result = 0.0300000000 or
   repr = "(parameter 0 (parameter d *))" and t = "snk" and result = 0.0166666670 or
   repr = "(parameter 0 (parameter h (member render *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (parameter onResolve (parameter 0 (member construct *))))" and t = "snk" and result = 0.4166666700 or
   repr = "(parameter 0 (parameter pred (member find *)))" and t = "snk" and result = 0.1785714300 or
   repr = "(parameter 0 (return (member compile *)))" and t = "snk" and result = 0.0166666670 or
   repr = "(parameter 0 (return (member require (global))))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (root https://www.npmjs.com/package/jquery))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 1 (member add *))" and t = "snk" and result = 0.0714285710 or
   repr = "(parameter 1 (member append *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 1 (member apply *))" and t = "snk" and result = 0.2261904753 or
   repr = "(parameter 1 (member arrayPushAll *))" and t = "snk" and result = 0.0263157890 or
   repr = "(parameter 1 (member call *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 1 (member createElement *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 1 (member css *))" and t = "snk" and result = 0.2421502280 or
   repr = "(parameter 1 (member extend *))" and t = "snk" and result = 0.0263157890 or
   repr = "(parameter 1 (member insertAdjacentHTML *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 1 (member insertAfter *))" and t = "snk" and result = 0.0263157890 or
   repr = "(parameter 1 (member insertBefore *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 1 (member isPermittedCrossDomainRequest *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 1 (member off *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 1 (member pagecontainer *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 1 (member replaceDomNodes *))" and t = "snk" and result = 0.0263157890 or
   repr = "(parameter 1 (member set *))" and t = "snk" and result = 0.0263157890 or
   repr = "(parameter 1 (member setAttribute *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 1 (member setExpression *))" and t = "snk" and result = 0.3055555600 or
   repr = "(parameter 1 (member setProperty *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 1 (member setSelectionRange *))" and t = "snk" and result = 0.0909090910 or
   repr = "(parameter 1 (member slice *))" and t = "snk" and result = 0.0300000000 or
   repr = "(parameter 1 (member spawn *))" and t = "snk" and result = 0.0320512820 or
   repr = "(parameter 1 (member splice *))" and t = "snk" and result = 0.0166666670 or
   repr = "(parameter 1 (member toggleClass *))" and t = "snk" and result = 0.0320512820 or
   repr = "(parameter 1 (member trigger *))" and t = "snk" and result = 0.1428571430 or
   repr = "(parameter 1 (member write *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 1 (member writeFileSync *))" and t = "snk" and result = 0.2727272750 or
   repr = "(parameter 1 (parameter callback (member withinString *)))" and t = "snk" and result = 0.0300000000 or
   repr = "(parameter 1 (return (member compile *)))" and t = "snk" and result = 0.0166666670 or
   repr = "(parameter 10 (member append *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 11 (member append *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 2 (member append *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 2 (member call *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 2 (member forEach *))" and t = "snk" and result = 0.5000000000 or
   repr = "(parameter 2 (member ignore *))" and t = "snk" and result = 0.0263157890 or
   repr = "(parameter 2 (member insertAfter *))" and t = "snk" and result = 0.0263157890 or
   repr = "(parameter 2 (member resolve *))" and t = "snk" and result = 0.5000000000 or
   repr = "(parameter 2 (member set *))" and t = "snk" and result = 0.0263157890 or
   repr = "(parameter 2 (member setAttributeNS *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 2 (member streamFrame *))" and t = "snk" and result = 0.5000000000 or
   repr = "(parameter 2 (member write *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 2 (parameter callback (member withinString *)))" and t = "snk" and result = 0.0300000000 or
   repr = "(parameter 2 (parameter e *))" and t = "snk" and result = 0.0166666670 or
   repr = "(parameter 2 (parameter t (parameter 1 (member each *))))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 3 (member append *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 3 (member trigger *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 3 (member write *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 3 (parameter callback (member withinString *)))" and t = "snk" and result = 0.0300000000 or
   repr = "(parameter 3 (return (member compile *)))" and t = "snk" and result = 0.0166666670 or
   repr = "(parameter 4 (member append *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 4 (return (member compile *)))" and t = "snk" and result = 0.0166666670 or
   repr = "(parameter 5 (member append *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 6 (member append *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 7 (member append *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 8 (member append *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 9 (member append *))" and t = "snk" and result = 1.0000000000 or
   repr = "(return (member * (instance (member Collection *))))" and t = "snk" and result = 0.1250000000 or
   repr = "(return (member * (instance (member model *))))" and t = "snk" and result = 0.1250000000 or
   repr = "(return (member * (parameter 1 (member extend *))))" and t = "snk" and result = 0.3333333300 or
   repr = "(return (member _getRegExp *))" and t = "snk" and result = 0.0916149085 or
   repr = "(return (member _isRegExpOption *))" and t = "snk" and result = 0.0760869570 or
   repr = "(return (member _resolveWidth *))" and t = "snk" and result = 0.0691489360 or
   repr = "(return (member ajax *))" and t = "snk" and result = 0.0357142860 or
   repr = "(return (member body *))" and t = "snk" and result = 0.1250000000 or
   repr = "(return (member buildUrl *))" and t = "snk" and result = 0.1071428600 or
   repr = "(return (member camelCase *))" and t = "snk" and result = 0.2797619050 or
   repr = "(return (member compile *))" and t = "snk" and result = 0.0166666670 or
   repr = "(return (member contextFor *))" and t = "snk" and result = 0.0263157890 or
   repr = "(return (member convertUrlToDataUrl *))" and t = "snk" and result = 0.1428571400 or
   repr = "(return (member cookie *))" and t = "snk" and result = 0.1688311700 or
   repr = "(return (member css *))" and t = "snk" and result = 0.2500000000 or
   repr = "(return (member dataFor *))" and t = "snk" and result = 0.0263157890 or
   repr = "(return (member display *))" and t = "snk" and result = 0.7500000000 or
   repr = "(return (member escapeMarkup *))" and t = "snk" and result = 0.0691489360 or
   repr = "(return (member extend *))" and t = "snk" and result = 0.5000000000 or
   repr = "(return (member find *))" and t = "snk" and result = 0.0166666670 or
   repr = "(return (member footer *))" and t = "snk" and result = 0.1250000000 or
   repr = "(return (member format *))" and t = "snk" and result = 0.0669014080 or
   repr = "(return (member formatRange *))" and t = "snk" and result = 0.0669014080 or
   repr = "(return (member get *))" and t = "snk" and result = 0.4166666667 or
   repr = "(return (member getSQL *))" and t = "snk" and result = 0.0714285710 or
   repr = "(return (member handle *))" and t = "snk" and result = 0.2500000000 or
   repr = "(return (member hasQuery *))" and t = "snk" and result = 0.2500000000 or
   repr = "(return (member hashToSelector *))" and t = "snk" and result = 0.7500000000 or
   repr = "(return (member header *))" and t = "snk" and result = 0.1250000000 or
   repr = "(return (member hostname *))" and t = "snk" and result = 0.2500000000 or
   repr = "(return (member href *))" and t = "snk" and result = 0.2500000000 or
   repr = "(return (member is *))" and t = "snk" and result = 0.2500000000 or
   repr = "(return (member makeHtml *))" and t = "snk" and result = 0.1538461500 or
   repr = "(return (member nodeName *))" and t = "snk" and result = 0.2500000000 or
   repr = "(return (member offsetParent *))" and t = "snk" and result = 0.3333333333 or
   repr = "(return (member pathname *))" and t = "snk" and result = 0.2500000000 or
   repr = "(return (member prop *))" and t = "snk" and result = 0.2500000000 or
   repr = "(return (member readValue *))" and t = "snk" and result = 0.0263157890 or
   repr = "(return (member readable *))" and t = "snk" and result = 0.2500000000 or
   repr = "(return (member search *))" and t = "snk" and result = 0.2500000000 or
   repr = "(return (member statusCode *))" and t = "snk" and result = 0.2142857100 or
   repr = "(return (member storedBindingContextForNode *))" and t = "snk" and result = 0.0263157890 or
   repr = "(return (member stripHash *))" and t = "snk" and result = 0.1428571400 or
   repr = "(return (member suggestion *))" and t = "snk" and result = 1.0000000000 or
   repr = "(return (member uniqueSort *))" and t = "snk" and result = 0.2500000000 or
   repr = "(return (member userinfo *))" and t = "snk" and result = 0.2500000000 or
   repr = "(return (member val *))" and t = "snk" and result = 0.0909090910 or
   repr = "(return (member withinString *))" and t = "snk" and result = 0.0300000000 or
   repr = "(return (parameter 0 (member extend *)))" and t = "snk" and result = 0.2500000000 or
   repr = "(return (parameter 0 (member forEach *)))" and t = "snk" and result = 0.0320512820 or
   repr = "(return (parameter 1 (member map *)))" and t = "snk" and result = 0.0417840375 or
   repr = "(return (parameter 1 (member replace *)))" and t = "snk" and result = 0.5000000000
   } 
}
