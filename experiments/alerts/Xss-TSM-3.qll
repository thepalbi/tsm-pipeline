module TsmRepr {
  float getReprScore(string repr, string t){
   repr = "(member * (parameter 0 (member concat *)))" and t = "snk" and result = 0.0691489360 or
   repr = "(member * (parameter e (member apply *)))" and t = "snk" and result = 0.2500000000 or
   repr = "(member * (parameter elem (member trigger *)))" and t = "snk" and result = 0.2500000000 or
   repr = "(member * (parameter r (member trigger *)))" and t = "snk" and result = 0.5000000000 or
   repr = "(member * (parameter target (member apply *)))" and t = "snk" and result = 0.2500000000 or
   repr = "(member * (return (member Array (global))))" and t = "snk" and result = 0.2500000000 or
   repr = "(member * (return (member split *)))" and t = "snk" and result = 0.5000000000 or
   repr = "(member * (return (member tokenize *)))" and t = "snk" and result = 0.2916666700 or
   repr = "(member BackgroundColor (member attrib *))" and t = "snk" and result = 0.0232240440 or
   repr = "(member Description (member attrib *))" and t = "snk" and result = 0.0232240440 or
   repr = "(member __html (member dangerouslySetInnerHTML *))" and t = "snk" and result = 1.0000000000 or
   repr = "(member _d (parameter b (member updateOffset *)))" and t = "snk" and result = 0.0142276420 or
   repr = "(member _links (member tz *))" and t = "snk" and result = 0.0142276420 or
   repr = "(member _z (parameter b (member updateOffset *)))" and t = "snk" and result = 0.0142276420 or
   repr = "(member abbrs (instance (member Zone *)))" and t = "snk" and result = 0.0142276420 or
   repr = "(member content-length (member headers *))" and t = "snk" and result = 0.0614801865 or
   repr = "(member data (parameter 0 (member ajax *)))" and t = "snk" and result = 0.2500000000 or
   repr = "(member data (parameter 1 (member render *)))" and t = "snk" and result = 0.5000000000 or
   repr = "(member event (return (member _triggerWithDeprecated *)))" and t = "snk" and result = 0.1071428600 or
   repr = "(member fallbackKey (parameter 1 (member data *)))" and t = "snk" and result = 0.2500000000 or
   repr = "(member handlePosition *)" and t = "snk" and result = 0.0357142860 or
   repr = "(member hash (parameter state (member jump *)))" and t = "snk" and result = 0.3000000000 or
   repr = "(member headers (parameter 0 (member request *)))" and t = "snk" and result = 0.0576923075 or
   repr = "(member headers *)" and t = "snk" and result = 0.0909090910 or
   repr = "(member hostname (return (member parseUrl *)))" and t = "snk" and result = 0.2500000000 or
   repr = "(member hrefNoSearch (return (member parseUrl *)))" and t = "snk" and result = 0.3333333300 or
   repr = "(member innerHTML (member 0 (return (member getElementsByTagName *))))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (member 3 (member cells *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (member _currentBackButton *))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (member body *))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (member currentSlide *))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (member documentElement *))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (member firstChild *))" and t = "snk" and result = 0.8500000000 or
   repr = "(member innerHTML (member form *))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (member h *))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (member head *))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (member lastChild *))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (member profile *))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (member replacedWith *))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (member sourceNode *))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (member template *))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (member version *))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (member widget *))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member TestHelper *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member VimeoPlayer (global))))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member _css (global))))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member _mm_addClass (global))))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member _show (global))))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member addClass *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member addDomListener *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member addImageCommentBadge *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member append *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member appendChild *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member applyStyles *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member bind *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member check_children (global))))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member childNodes *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member close *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member contains *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member createFromNodeContents *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member createMouseEvent (global))))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member data *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member decorate *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member default *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member findInChildren *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member fragmentToTestOutput (global))))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member fromElement *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member generateBadgeFromDiscussionDOM *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member getComputedStyle (global))))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member getNodeAtOffset *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member getOuterHtml *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member haveSameAllChildAttribs *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member hideelem (global))))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member html *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member initImageDiff *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member insertBefore *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member insertNode *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member isEmpty *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member isEmptyBlock *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member isEqualNode *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member jQuery (global))))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member linker *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member nodeToGFM *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member on *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member paintCanvas (global))))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member parse *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member push *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member removeChild *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member removeChildren *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member render *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member renderVisualTokenValue *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member replaceChild *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member selectNode *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member selectNodeContents *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member setDragImage *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member setImagesSrc *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member setStyle *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member shoestring (global))))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member showCommentIndicator *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member showelem (global))))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member style *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member subItemsMouseLeave *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member testInsertNode (global))))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member to *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member touch *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member translate *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member updateDiscussionAvatarBadgeNumber *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member updateDiscussionBadgeNumber *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 1 (member addLineWidget *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 1 (member assertHtmlContentsMatch *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 1 (member bind *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 1 (member call *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 1 (member childrenToNode_ *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 1 (member closure *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 1 (member drawSurveyForm (global))))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 1 (member generateBadgeFromDiscussionDOM *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 1 (member haveSameAllChildAttribs *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 1 (member insertBefore *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 1 (member insertRow *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 1 (member jQuery (global))))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 1 (member log *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 1 (member moveChild *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 1 (member onGet *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 1 (member overlayPage *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 1 (member set *)))" and t = "snk" and result = 1.0000000000 or
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
   repr = "(member innerHTML (parameter elem (member setInnerHtml *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter element (member renderElement *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter element (member setStyles *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter form (member setParameters_ *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter node (member selectNode *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter oldIcon (member createIcon *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter t (member createIcon *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter target (member create *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter v (member useBespin *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (return (member Flash (global))))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (return (member appendChild *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (return (member cloneNode *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (return (member createDocumentFragment *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (return (member createElement *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (return (member createElementNS *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (return (member createFilterVisualToken *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (return (member createScript *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (return (member createSearchVisualToken *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (return (member createShadowRoot *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (return (member createTemplate *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (return (member entry *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (return (member getAsDom *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (return (member getElementById (global))))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (return (member getElementById *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (return (member getElementByName (global))))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (return (member getWebGLErrorMessage *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (return (member insertCell *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (return (member querySelector *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML *)" and t = "snk" and result = 1.0000000000 or
   repr = "(member maxWidth (member style *))" and t = "snk" and result = 0.2500000000 or
   repr = "(member method (parameter 0 (member request *)))" and t = "snk" and result = 0.0833333330 or
   repr = "(member name (instance (member Zone *)))" and t = "snk" and result = 0.0142276420 or
   repr = "(member next (return (member buttonText *)))" and t = "snk" and result = 0.7500000000 or
   repr = "(member offsets (instance (member Zone *)))" and t = "snk" and result = 0.0142276420 or
   repr = "(member outerHTML (member body *))" and t = "snk" and result = 1.0000000000 or
   repr = "(member outerHTML (member documentElement *))" and t = "snk" and result = 1.0000000000 or
   repr = "(member outerHTML (parameter 0 (member appendChild *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member outerHTML (parameter elem (member setOuterHtml *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member outerHTML (return (member getElementById *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member outerHTML *)" and t = "snk" and result = 1.0000000000 or
   repr = "(member pathname (parameter 0 (member format *)))" and t = "snk" and result = 0.1875000000 or
   repr = "(member population (instance (member Zone *)))" and t = "snk" and result = 0.0142276420 or
   repr = "(member query (parameter 0 (member extend *)))" and t = "snk" and result = 0.2500000000 or
   repr = "(member result (parameter t (member trigger *)))" and t = "snk" and result = 0.2500000000 or
   repr = "(member sql (return (member getSQL *)))" and t = "snk" and result = 0.0714285710 or
   repr = "(member store (parameter 0 (member hydrate *)))" and t = "snk" and result = 0.1666666700 or
   repr = "(member target (parameter 0 (member extend *)))" and t = "snk" and result = 0.2500000000 or
   repr = "(member template (parameter 0 (member default *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member template (parameter 0 (member extend *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member template (parameter 1 (member component *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member text (parameter 0 (member remove *)))" and t = "snk" and result = 0.0232240440 or
   repr = "(member tz (parameter a *))" and t = "snk" and result = 0.0142276420 or
   repr = "(member untils (instance (member Zone *)))" and t = "snk" and result = 0.0142276420 or
   repr = "(member url (parameter 0 (member ajax *)))" and t = "snk" and result = 0.3500000000 or
   repr = "(member url (parameter 2 (member streamFrame *)))" and t = "snk" and result = 0.5000000000 or
   repr = "(member url (parameter 3 (member extend *)))" and t = "snk" and result = 0.1071428600 or
   repr = "(member url (parameter settings *))" and t = "snk" and result = 0.1071428600 or
   repr = "(parameter 0 (member $ (global)))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member * (global)))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member * (member $element *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member * (member icon *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member * (member nav *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member * (parameter $element *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member * (parameter e *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member * (parameter input *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member * (return (member append *))))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member * (return (member attr *))))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member * (return (member empty *))))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member * (return (member find *))))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member * (return (member get *))))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member * (return (parameter $ *))))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member * (return (parameter f *))))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member SafeString *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member _getRegExp *))" and t = "snk" and result = 0.0916149085 or
   repr = "(parameter 0 (member _index *))" and t = "snk" and result = 0.0142276420 or
   repr = "(parameter 0 (member _isRegExpOption *))" and t = "snk" and result = 0.1071428600 or
   repr = "(parameter 0 (member _on *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 0 (member _set *))" and t = "snk" and result = 0.0142276420 or
   repr = "(parameter 0 (member add *))" and t = "snk" and result = 0.1321138210 or
   repr = "(parameter 0 (member after *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member ajax *))" and t = "snk" and result = 0.2614285720 or
   repr = "(parameter 0 (member animationComplete *))" and t = "snk" and result = 0.5000000000 or
   repr = "(parameter 0 (member append *))" and t = "snk" and result = 0.9844956197 or
   repr = "(parameter 0 (member appendChild *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member appendTo *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member apply *))" and t = "snk" and result = 0.0357142860 or
   repr = "(parameter 0 (member before *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member createContextualFragment *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member createElement *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member createReadStream *))" and t = "snk" and result = 0.1500000000 or
   repr = "(parameter 0 (member createWriteStream *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 0 (member css *))" and t = "snk" and result = 0.0357142860 or
   repr = "(parameter 0 (member default *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member defaultTransitionHandler *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 0 (member doMove *))" and t = "snk" and result = 0.0357142860 or
   repr = "(parameter 0 (member each *))" and t = "snk" and result = 0.5000000000 or
   repr = "(parameter 0 (member element *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member end *))" and t = "snk" and result = 0.3910256410 or
   repr = "(parameter 0 (member ender (global)))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member exec *))" and t = "snk" and result = 0.0232240440 or
   repr = "(parameter 0 (member exists *))" and t = "snk" and result = 0.1500000000 or
   repr = "(parameter 0 (member find *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 0 (member fn *))" and t = "snk" and result = 0.0714285710 or
   repr = "(parameter 0 (member get *))" and t = "snk" and result = 0.5000000000 or
   repr = "(parameter 0 (member html *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member includes *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 0 (member indexOf *))" and t = "snk" and result = 0.3055555600 or
   repr = "(parameter 0 (member insertAfter *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member insertBefore *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member isArray *))" and t = "snk" and result = 0.3333333300 or
   repr = "(parameter 0 (member isPlainObject *))" and t = "snk" and result = 0.2857142900 or
   repr = "(parameter 0 (member jQuery (global)))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member makeHandlePositionStyle *))" and t = "snk" and result = 0.0357142860 or
   repr = "(parameter 0 (member mapKeys *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 0 (member move *))" and t = "snk" and result = 0.0357142860 or
   repr = "(parameter 0 (member mozGetAsFile *))" and t = "snk" and result = 0.0760869570 or
   repr = "(parameter 0 (member navigate *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 0 (member offset *))" and t = "snk" and result = 0.0142276420 or
   repr = "(parameter 0 (member parse *))" and t = "snk" and result = 0.0142276420 or
   repr = "(parameter 0 (member parseFromString *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member prepend *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member prependTo *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member puts *))" and t = "snk" and result = 0.1875000000 or
   repr = "(parameter 0 (member querySelectorAll *))" and t = "snk" and result = 0.7500000000 or
   repr = "(parameter 0 (member readFileSync *))" and t = "snk" and result = 0.0320512820 or
   repr = "(parameter 0 (member readdirSync *))" and t = "snk" and result = 0.0320512820 or
   repr = "(parameter 0 (member reject *))" and t = "snk" and result = 0.1071428600 or
   repr = "(parameter 0 (member remove *))" and t = "snk" and result = 0.0232240440 or
   repr = "(parameter 0 (member removeClass *))" and t = "snk" and result = 0.0357142860 or
   repr = "(parameter 0 (member replace *))" and t = "snk" and result = 0.4166666700 or
   repr = "(parameter 0 (member replaceWith *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member request *))" and t = "snk" and result = 0.0687645687 or
   repr = "(parameter 0 (member send *))" and t = "snk" and result = 0.5000000000 or
   repr = "(parameter 0 (member setHandlePosition *))" and t = "snk" and result = 0.0357142860 or
   repr = "(parameter 0 (member shoestring (global)))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member splice *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 0 (member stat *))" and t = "snk" and result = 0.2000000000 or
   repr = "(parameter 0 (member statSync *))" and t = "snk" and result = 0.0320512820 or
   repr = "(parameter 0 (member text *))" and t = "snk" and result = 0.3095238100 or
   repr = "(parameter 0 (member trustAsHtml *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member undefined (global)))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member utc *))" and t = "snk" and result = 0.0142276420 or
   repr = "(parameter 0 (member val *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 0 (member window (global)))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member wrap *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member wrapAll *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member wrapInner *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member write *))" and t = "snk" and result = 0.9642008318 or
   repr = "(parameter 0 (member writeFile *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 0 (member writeln *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member zone *))" and t = "snk" and result = 0.0142276420 or
   repr = "(parameter 0 (parameter $ (member exports *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (parameter 0 (member apply *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (parameter 0 (member spyOn (global))))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (parameter 1 (member extend *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (parameter a *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 0 (parameter createComponent (member render *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (parameter createElement (member render *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (parameter h (member render *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (parameter onResolve (parameter 0 (member construct *))))" and t = "snk" and result = 0.4166666700 or
   repr = "(parameter 0 (parameter pred (member find *)))" and t = "snk" and result = 0.1785714300 or
   repr = "(parameter 0 (return (member require (global))))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (root https://www.npmjs.com/package/jquery))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 1 (member add *))" and t = "snk" and result = 0.0714285710 or
   repr = "(parameter 1 (member append *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 1 (member apply *))" and t = "snk" and result = 0.4464285700 or
   repr = "(parameter 1 (member attr *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 1 (member call *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 1 (member css *))" and t = "snk" and result = 0.0691489360 or
   repr = "(parameter 1 (member insertAdjacentElement *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 1 (member insertAdjacentHTML *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 1 (member insertBefore *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 1 (member isPermittedCrossDomainRequest *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 1 (member makeUrlAbsolute *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 1 (member on *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 1 (member pagecontainer *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 1 (member render *))" and t = "snk" and result = 0.5000000000 or
   repr = "(parameter 1 (member setAttribute *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 1 (member setExpression *))" and t = "snk" and result = 0.3055555600 or
   repr = "(parameter 1 (member setInnerHTMLUnsafe *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 1 (member setProperty *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 1 (member spawn *))" and t = "snk" and result = 0.0276376630 or
   repr = "(parameter 1 (member substring *))" and t = "snk" and result = 0.5000000000 or
   repr = "(parameter 1 (member toggleClass *))" and t = "snk" and result = 0.0320512820 or
   repr = "(parameter 1 (member trigger *))" and t = "snk" and result = 0.0357142860 or
   repr = "(parameter 1 (member write *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 1 (member writeFileSync *))" and t = "snk" and result = 0.0232240440 or
   repr = "(parameter 2 (member append *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 2 (member on *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 2 (member resolve *))" and t = "snk" and result = 0.3750000000 or
   repr = "(parameter 2 (member setAttributeNS *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 2 (member streamFrame *))" and t = "snk" and result = 0.5000000000 or
   repr = "(parameter 2 (member write *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 3 (member append *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 3 (member write *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 4 (member append *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 5 (member append *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 6 (member append *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 7 (member append *))" and t = "snk" and result = 1.0000000000 or
   repr = "(return (member * (parameter 1 (member extend *))))" and t = "snk" and result = 0.3541666650 or
   repr = "(return (member _buildURL *))" and t = "snk" and result = 0.5000000000 or
   repr = "(return (member _fnReadCookie *))" and t = "snk" and result = 0.5000000000 or
   repr = "(return (member _getActionUrl *))" and t = "snk" and result = 0.5000000000 or
   repr = "(return (member _getRegExp *))" and t = "snk" and result = 0.0916149085 or
   repr = "(return (member _isRegExpOption *))" and t = "snk" and result = 0.0760869570 or
   repr = "(return (member _resolveCategoryCrumbs *))" and t = "snk" and result = 0.2500000000 or
   repr = "(return (member _resolveWidth *))" and t = "snk" and result = 0.0691489360 or
   repr = "(return (member abbr *))" and t = "snk" and result = 0.0142276420 or
   repr = "(return (member body *))" and t = "snk" and result = 0.1250000000 or
   repr = "(return (member buildUrl *))" and t = "snk" and result = 0.1071428600 or
   repr = "(return (member clean *))" and t = "snk" and result = 0.2500000000 or
   repr = "(return (member cleanHash *))" and t = "snk" and result = 0.2500000000 or
   repr = "(return (member clickHandler *))" and t = "snk" and result = 0.2500000000 or
   repr = "(return (member convertUrlToDataUrl *))" and t = "snk" and result = 0.1428571400 or
   repr = "(return (member cookie *))" and t = "snk" and result = 0.5000000000 or
   repr = "(return (member display *))" and t = "snk" and result = 0.7500000000 or
   repr = "(return (member escapeMarkup *))" and t = "snk" and result = 0.0691489360 or
   repr = "(return (member footer *))" and t = "snk" and result = 0.1250000000 or
   repr = "(return (member format *))" and t = "snk" and result = 0.0669014080 or
   repr = "(return (member formatRange *))" and t = "snk" and result = 0.0669014080 or
   repr = "(return (member get *))" and t = "snk" and result = 0.2500000000 or
   repr = "(return (member getBackgroundColor *))" and t = "snk" and result = 0.0232240440 or
   repr = "(return (member getDescription *))" and t = "snk" and result = 0.0232240440 or
   repr = "(return (member getSQL *))" and t = "snk" and result = 0.0714285710 or
   repr = "(return (member getSplashBackgroundColor *))" and t = "snk" and result = 0.0232240440 or
   repr = "(return (member hashToSelector *))" and t = "snk" and result = 0.7500000000 or
   repr = "(return (member header *))" and t = "snk" and result = 0.1250000000 or
   repr = "(return (member href *))" and t = "snk" and result = 0.7500000000 or
   repr = "(return (member nodeName *))" and t = "snk" and result = 0.2500000000 or
   repr = "(return (member offset *))" and t = "snk" and result = 0.0142276420 or
   repr = "(return (member parse *))" and t = "snk" and result = 0.0142276420 or
   repr = "(return (member prop *))" and t = "snk" and result = 0.2500000000 or
   repr = "(return (member render *))" and t = "snk" and result = 0.7500000000 or
   repr = "(return (member statusCode *))" and t = "snk" and result = 0.2142857100 or
   repr = "(return (member stripHash *))" and t = "snk" and result = 0.1964285700 or
   repr = "(return (member suggestion *))" and t = "snk" and result = 1.0000000000 or
   repr = "(return (member uniqueSort *))" and t = "snk" and result = 0.2500000000 or
   repr = "(return (member url *))" and t = "snk" and result = 0.5000000000 or
   repr = "(return (parameter 0 (member extend *)))" and t = "snk" and result = 0.2500000000 or
   repr = "(return (parameter 0 (member filter *)))" and t = "snk" and result = 0.2500000000 or
   repr = "(return (parameter 0 (member forEach *)))" and t = "snk" and result = 0.0320512820 or
   repr = "(return (parameter 0 (member html *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(return (parameter 1 (member map *)))" and t = "snk" and result = 0.0669014080
   } 
}
