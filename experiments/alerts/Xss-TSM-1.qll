module TsmRepr {
  float getReprScore(string repr, string t){
   repr = "(member * (member elem *))" and t = "snk" and result = 0.2328571400 or
   repr = "(member * (member style *))" and t = "snk" and result = 0.2500000000 or
   repr = "(member * (parameter 0 (member call *)))" and t = "snk" and result = 0.0603448280 or
   repr = "(member * (parameter 0 (member concat *)))" and t = "snk" and result = 0.0691489360 or
   repr = "(member * (parameter 0 (member defineProperties *)))" and t = "snk" and result = 0.0171428570 or
   repr = "(member * (parameter 0 (member f *)))" and t = "snk" and result = 0.0171428570 or
   repr = "(member * (parameter O (member f *)))" and t = "snk" and result = 0.0171428570 or
   repr = "(member * (parameter a (member apply *)))" and t = "snk" and result = 0.2500000000 or
   repr = "(member * (parameter data (member addQuery *)))" and t = "snk" and result = 0.2500000000 or
   repr = "(member * (parameter destination (member copy *)))" and t = "snk" and result = 0.2500000000 or
   repr = "(member * (parameter e (member apply *)))" and t = "snk" and result = 0.2500000000 or
   repr = "(member * (parameter elem (member trigger *)))" and t = "snk" and result = 0.2500000000 or
   repr = "(member * (parameter r (member trigger *)))" and t = "snk" and result = 0.5000000000 or
   repr = "(member * (parameter target (member apply *)))" and t = "snk" and result = 0.2500000000 or
   repr = "(member * (parameter target (member f *)))" and t = "snk" and result = 0.0171428570 or
   repr = "(member * (return (member Array (global))))" and t = "snk" and result = 0.2500000000 or
   repr = "(member * (return (member exec *)))" and t = "snk" and result = 0.1875000000 or
   repr = "(member * (return (member set *)))" and t = "snk" and result = 0.1250000000 or
   repr = "(member * (return (member tokenize *)))" and t = "snk" and result = 0.4062500025 or
   repr = "(member 3 (parameter match (member PSEUDO *)))" and t = "snk" and result = 0.0416666670 or
   repr = "(member BackgroundColor (member attrib *))" and t = "snk" and result = 0.0232240440 or
   repr = "(member Description (member attrib *))" and t = "snk" and result = 0.0232240440 or
   repr = "(member MultiFile (parameter 0 (member jQuery (global))))" and t = "snk" and result = 0.0441176470 or
   repr = "(member STRING (parameter 2 (member trigger *)))" and t = "snk" and result = 0.0441176470 or
   repr = "(member __html (member dangerouslySetInnerHTML *))" and t = "snk" and result = 1.0000000000 or
   repr = "(member accept (parameter 2 (member trigger *)))" and t = "snk" and result = 0.0441176470 or
   repr = "(member angular (parameter 0 (member element *)))" and t = "snk" and result = 0.1666666700 or
   repr = "(member checksum (instance (member fromUtf8 *)))" and t = "snk" and result = 0.0171428570 or
   repr = "(member col *)" and t = "snk" and result = 0.0137614680 or
   repr = "(member combined (return (member reparsedParameters *)))" and t = "snk" and result = 0.1250000000 or
   repr = "(member comments_before *)" and t = "snk" and result = 0.0137614680 or
   repr = "(member content-length (member headers *))" and t = "snk" and result = 0.0614801865 or
   repr = "(member current (parameter 2 (member trigger *)))" and t = "snk" and result = 0.0441176470 or
   repr = "(member data (parameter 1 (member render *)))" and t = "snk" and result = 0.5000000000 or
   repr = "(member dataTypes (parameter 0 (member jQuery (global))))" and t = "snk" and result = 0.5000000000 or
   repr = "(member directory (return (member parseUrl *)))" and t = "snk" and result = 0.2500000000 or
   repr = "(member element (member angular (global)))" and t = "snk" and result = 0.1666666700 or
   repr = "(member error (parameter 1 (member call *)))" and t = "snk" and result = 0.2500000000 or
   repr = "(member fallbackKey (parameter 1 (member data *)))" and t = "snk" and result = 0.2500000000 or
   repr = "(member handlePosition *)" and t = "snk" and result = 0.0357142860 or
   repr = "(member headers (parameter 0 (member request *)))" and t = "snk" and result = 0.0320512820 or
   repr = "(member headers *)" and t = "snk" and result = 0.0909090910 or
   repr = "(member host (parameter url *))" and t = "snk" and result = 0.0171428570 or
   repr = "(member hrefNoSearch (return (member parseUrl *)))" and t = "snk" and result = 0.3333333300 or
   repr = "(member html (parameter 0 (member sendMail *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member id (member require (global)))" and t = "snk" and result = 0.2500000000 or
   repr = "(member innerHTML (member 0 (return (member getElementsByTagName *))))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (member 3 (member cells *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (member aRoot *))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (member bRoot *))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (member body *))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (member button *))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (member div *))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (member documentElement *))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (member firstChild *))" and t = "snk" and result = 0.8928571429 or
   repr = "(member innerHTML (member form *))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (member h *))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (member head *))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (member labelContent *))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (member lastChild *))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (member menuButton *))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (member menuButtonSr *))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (member menuSr *))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (member nextSibling *))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (member parentNode *))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (member selectorSr *))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (member sourceNode *))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (member sr *))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (member sr2 *))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (member sr3 *))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member Dom7 (global))))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member TestHelper *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member VimeoPlayer (global))))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member _css (global))))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member _mm_addClass (global))))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member _show (global))))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member addDomListener *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member addImageCommentBadge *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member append *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member appendChild *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member bootstrap *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member check_children (global))))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member close *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member compareDocumentPosition *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member createFromNodeContents *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member createMouseEvent (global))))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member data *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member decorate *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member default *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member deleteEl (global))))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member each *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member element *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member expectStructure (global))))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member findInChildren *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member forAllTemplatesFrom_ *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member fragmentToTestOutput (global))))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member fromElement *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member generateBadgeFromDiscussionDOM *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member getComputedStyle (global))))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member getElementById *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member getNodeAtOffset *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member getOuterHtml *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member haveSameAllChildAttribs *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member hideelem (global))))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member html *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member initImageDiff *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member insertAfter (global))))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member insertBefore *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member insertNode *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member insertNodeAtSelection *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member isEmpty *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member isEmptyBlock *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member isEqualNode *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member jQuery (global))))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member jqLite (global))))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member linker *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member nodeToGFM *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member observe *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member on *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member paintCanvas (global))))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member parse *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member push *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member removeChild *)))" and t = "snk" and result = 0.9779411765 or
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
   repr = "(member innerHTML (parameter 0 (member show *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member showCommentIndicator *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member showelem (global))))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member style *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member subItemsMouseLeave *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member testInsertNode (global))))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member to *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member touch *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member unwrap *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member unwrapAndExpectStructure (global))))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member updateDiscussionAvatarBadgeNumber *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member updateDiscussionBadgeNumber *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member upgradeAll *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 0 (member watchShadow *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 1 (member assertHtmlContentsMatch *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 1 (member bind *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 1 (member call *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 1 (member childrenToNode_ *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 1 (member closure *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 1 (member drawSurveyForm (global))))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 1 (member equal *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 1 (member evaluate *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 1 (member generateBadgeFromDiscussionDOM *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 1 (member haveSameAllChildAttribs *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 1 (member insertBefore *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 1 (member insertRow *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 1 (member log *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 1 (member moveChild *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 1 (member overlayPage *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 1 (member set *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 2 (member bind *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 2 (member splitDom_ *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 3 (member call *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 3 (member createElement *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 4 (member call *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter 5 (member showHideFile (global))))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter _20 (member write *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter a *))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter e (member edit *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter el (member edit *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter elem (member setInnerHtml *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter element (member renderElement *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter element (member setStyles *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (parameter m (member edit *)))" and t = "snk" and result = 1.0000000000 or
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
   repr = "(member innerHTML (return (member createSearchVisualToken *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (return (member createShadowRoot *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (return (member createTemplate *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (return (member entry *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (return (member generateElement *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (return (member generateEmbed *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (return (member get *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (return (member getAsDom *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (return (member getContainer *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (return (member getElementById (global))))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (return (member getElementById *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (return (member getElementByName (global))))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (return (member getWebGLErrorMessage *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (return (member insertCell *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (return (member querySelector *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML (return (member webkitCreateShadowRoot *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member innerHTML *)" and t = "snk" and result = 1.0000000000 or
   repr = "(member lastIndex (member start *))" and t = "snk" and result = 0.0300000000 or
   repr = "(member line *)" and t = "snk" and result = 0.0137614680 or
   repr = "(member list (parameter 2 (member trigger *)))" and t = "snk" and result = 0.0441176470 or
   repr = "(member maxWidth (member style *))" and t = "snk" and result = 0.2500000000 or
   repr = "(member model *)" and t = "snk" and result = 0.2500000000 or
   repr = "(member name (parameter 0 (member element *)))" and t = "snk" and result = 0.1666666700 or
   repr = "(member name (parameter 0 (member jQuery (global))))" and t = "snk" and result = 0.0441176470 or
   repr = "(member next (return (member buttonText *)))" and t = "snk" and result = 0.7500000000 or
   repr = "(member nlb *)" and t = "snk" and result = 0.0137614680 or
   repr = "(member originalEvent (parameter 0 (member extend *)))" and t = "snk" and result = 0.2500000000 or
   repr = "(member outerHTML (member body *))" and t = "snk" and result = 1.0000000000 or
   repr = "(member outerHTML (member documentElement *))" and t = "snk" and result = 1.0000000000 or
   repr = "(member outerHTML (parameter 0 (member appendChild *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member outerHTML (parameter elem (member setOuterHtml *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member outerHTML (return (member getElementById *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member outerHTML *)" and t = "snk" and result = 1.0000000000 or
   repr = "(member page (parameter 1 (member trigger *)))" and t = "snk" and result = 0.2500000000 or
   repr = "(member path (member _parts *))" and t = "snk" and result = 0.2500000000 or
   repr = "(member pathname (parameter 0 (member format *)))" and t = "snk" and result = 0.1875000000 or
   repr = "(member port (parameter url *))" and t = "snk" and result = 0.0171428570 or
   repr = "(member pos (parameter nc (member context *)))" and t = "snk" and result = 0.0137614680 or
   repr = "(member pos *)" and t = "snk" and result = 0.0137614680 or
   repr = "(member protocol (member _parts *))" and t = "snk" and result = 0.2500000000 or
   repr = "(member regex_allowed (parameter nc (member context *)))" and t = "snk" and result = 0.0137614680 or
   repr = "(member result (parameter t (member trigger *)))" and t = "snk" and result = 0.2500000000 or
   repr = "(member rxAccept (parameter 2 (member trigger *)))" and t = "snk" and result = 0.0441176470 or
   repr = "(member scheme (parameter url *))" and t = "snk" and result = 0.0171428570 or
   repr = "(member sid (parameter 1 (member default *)))" and t = "snk" and result = 0.1250000000 or
   repr = "(member source (parameter 0 (member isError *)))" and t = "snk" and result = 0.0603448280 or
   repr = "(member source (return (member template *)))" and t = "snk" and result = 0.1194581290 or
   repr = "(member statusText (parameter 1 (member call *)))" and t = "snk" and result = 0.2500000000 or
   repr = "(member store (parameter 0 (member hydrate *)))" and t = "snk" and result = 0.1666666700 or
   repr = "(member target (parameter 0 (member extend *)))" and t = "snk" and result = 0.2500000000 or
   repr = "(member template (parameter 0 (member default *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member template (parameter 0 (member extend *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member template (parameter 1 (member component *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(member text (parameter 0 (member remove *)))" and t = "snk" and result = 0.0232240440 or
   repr = "(member text (return (member context *)))" and t = "snk" and result = 0.0137614680 or
   repr = "(member textContent (return (member querySelector *)))" and t = "snk" and result = 0.5000000000 or
   repr = "(member title *)" and t = "snk" and result = 0.2500000000 or
   repr = "(member tokcol (parameter nc (member context *)))" and t = "snk" and result = 0.0137614680 or
   repr = "(member tokline (parameter nc (member context *)))" and t = "snk" and result = 0.0137614680 or
   repr = "(member tokpos (parameter nc (member context *)))" and t = "snk" and result = 0.0137614680 or
   repr = "(member url (parameter 0 (member ajax *)))" and t = "snk" and result = 0.2000000000 or
   repr = "(member url (parameter 0 (member jQuery (global))))" and t = "snk" and result = 0.2500000000 or
   repr = "(member url (parameter 2 (member streamFrame *)))" and t = "snk" and result = 0.5000000000 or
   repr = "(member url (parameter 3 (member extend *)))" and t = "snk" and result = 0.1071428600 or
   repr = "(member url (parameter settings *))" and t = "snk" and result = 0.1071428600 or
   repr = "(member username (parameter parts (member parseUserinfo *)))" and t = "snk" and result = 0.2500000000 or
   repr = "(member value *)" and t = "snk" and result = 0.0154521625 or
   repr = "(member windowLS (return (member debug *)))" and t = "snk" and result = 0.1250000000 or
   repr = "(member wrapID (parameter 2 (member trigger *)))" and t = "snk" and result = 0.0441176470 or
   repr = "(member wrapper (parameter 2 (member trigger *)))" and t = "snk" and result = 0.0441176470 or
   repr = "(parameter 0 (member $ (global)))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member * (global)))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member * (member $dragshadow *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member * (member $element *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member * (member element *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member * (member icon *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member * (member ul *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member * (parameter $element *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member * (parameter e *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member * (parameter input *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member * (return (member append *))))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member * (return (member attr *))))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member * (return (member end *))))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member * (return (member find *))))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member * (return (parameter $ *))))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member SafeString *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member _getRegExp *))" and t = "snk" and result = 0.0930451140 or
   repr = "(parameter 0 (member _isRegExpOption *))" and t = "snk" and result = 0.1071428600 or
   repr = "(parameter 0 (member _on *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 0 (member addClass *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 0 (member after *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member ajax *))" and t = "snk" and result = 0.1535714300 or
   repr = "(parameter 0 (member append *))" and t = "snk" and result = 0.9847378757 or
   repr = "(parameter 0 (member appendChild *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member appendTo *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member apply *))" and t = "snk" and result = 0.1428571430 or
   repr = "(parameter 0 (member before *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member call *))" and t = "snk" and result = 0.0171428570 or
   repr = "(parameter 0 (member charAt *))" and t = "snk" and result = 0.0137614680 or
   repr = "(parameter 0 (member compareDocumentPosition *))" and t = "snk" and result = 0.0833333330 or
   repr = "(parameter 0 (member contains *))" and t = "snk" and result = 0.0833333330 or
   repr = "(parameter 0 (member createContextualFragment *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member createElement *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member createReadStream *))" and t = "snk" and result = 0.1500000000 or
   repr = "(parameter 0 (member css *))" and t = "snk" and result = 0.0357142860 or
   repr = "(parameter 0 (member default *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member defaultTransitionHandler *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 0 (member doMove *))" and t = "snk" and result = 0.0357142860 or
   repr = "(parameter 0 (member element *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member end *))" and t = "snk" and result = 0.0320512820 or
   repr = "(parameter 0 (member exec *))" and t = "snk" and result = 0.1991120220 or
   repr = "(parameter 0 (member execSync *))" and t = "snk" and result = 0.7500000000 or
   repr = "(parameter 0 (member exists *))" and t = "snk" and result = 0.1500000000 or
   repr = "(parameter 0 (member find *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 0 (member get *))" and t = "snk" and result = 0.5000000000 or
   repr = "(parameter 0 (member getElementById *))" and t = "snk" and result = 0.0416666670 or
   repr = "(parameter 0 (member getElementsByTagName *))" and t = "snk" and result = 0.1666666665 or
   repr = "(parameter 0 (member getJSON *))" and t = "snk" and result = 0.1071428600 or
   repr = "(parameter 0 (member html *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member indexOf *))" and t = "snk" and result = 0.3513888900 or
   repr = "(parameter 0 (member insertAfter *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member insertBefore *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member isArray *))" and t = "snk" and result = 0.2202380950 or
   repr = "(parameter 0 (member isPlainObject *))" and t = "snk" and result = 0.2857142900 or
   repr = "(parameter 0 (member jQuery (global)))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member localeCompare *))" and t = "snk" and result = 0.7500000000 or
   repr = "(parameter 0 (member lstatSync *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 0 (member makeCode *))" and t = "snk" and result = 0.0997536950 or
   repr = "(parameter 0 (member makeHandlePositionStyle *))" and t = "snk" and result = 0.0357142860 or
   repr = "(parameter 0 (member mapKeys *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 0 (member move *))" and t = "snk" and result = 0.0357142860 or
   repr = "(parameter 0 (member mozGetAsFile *))" and t = "snk" and result = 0.0789473680 or
   repr = "(parameter 0 (member parseFromString *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member prepend *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member prependTo *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member push *))" and t = "snk" and result = 0.0154521625 or
   repr = "(parameter 0 (member puts *))" and t = "snk" and result = 0.1875000000 or
   repr = "(parameter 0 (member querySelectorAll *))" and t = "snk" and result = 0.1944444443 or
   repr = "(parameter 0 (member readFileSync *))" and t = "snk" and result = 0.3162393173 or
   repr = "(parameter 0 (member readdirSync *))" and t = "snk" and result = 0.0320512820 or
   repr = "(parameter 0 (member remove *))" and t = "snk" and result = 0.0232240440 or
   repr = "(parameter 0 (member removeChild *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 0 (member removeClass *))" and t = "snk" and result = 0.0357142860 or
   repr = "(parameter 0 (member replace *))" and t = "snk" and result = 0.4166666700 or
   repr = "(parameter 0 (member replaceWith *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member request *))" and t = "snk" and result = 0.0614801865 or
   repr = "(parameter 0 (member send *))" and t = "snk" and result = 0.5000000000 or
   repr = "(parameter 0 (member setHandlePosition *))" and t = "snk" and result = 0.0357142860 or
   repr = "(parameter 0 (member shoestring (global)))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member slice *))" and t = "snk" and result = 0.0775000000 or
   repr = "(parameter 0 (member stat *))" and t = "snk" and result = 0.1500000000 or
   repr = "(parameter 0 (member statSync *))" and t = "snk" and result = 0.0320512820 or
   repr = "(parameter 0 (member substr *))" and t = "snk" and result = 0.0137614680 or
   repr = "(parameter 0 (member substring *))" and t = "snk" and result = 0.0137614680 or
   repr = "(parameter 0 (member test *))" and t = "snk" and result = 0.0300000000 or
   repr = "(parameter 0 (member text *))" and t = "snk" and result = 0.3511904767 or
   repr = "(parameter 0 (member trustAsHtml *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member undefined (global)))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member unlink *))" and t = "snk" and result = 0.5000000000 or
   repr = "(parameter 0 (member wrap *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member wrapAll *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member wrapInner *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (member write *))" and t = "snk" and result = 0.9511157257 or
   repr = "(parameter 0 (member writeln *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (parameter $ (member exports *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (parameter 0 (member apply *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (parameter 0 (member isFunction *)))" and t = "snk" and result = 0.1785714300 or
   repr = "(parameter 0 (parameter a *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 0 (parameter callback (member withinString *)))" and t = "snk" and result = 0.0300000000 or
   repr = "(parameter 0 (parameter createComponent (member render *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (parameter createElement (member render *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (parameter h (member render *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (parameter interceptor (parameter 1 (member forEach *))))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 0 (parameter onResolve (parameter 0 (member construct *))))" and t = "snk" and result = 0.4166666700 or
   repr = "(parameter 0 (parameter pred (member find *)))" and t = "snk" and result = 0.1785714300 or
   repr = "(parameter 0 (parameter setErrors *))" and t = "snk" and result = 0.5000000000 or
   repr = "(parameter 0 (return (member require (global))))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (return (parameter require *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 0 (root https://www.npmjs.com/package/jquery))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 1 (member * (member sparkline *)))" and t = "snk" and result = 0.5000000000 or
   repr = "(parameter 1 (member append *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 1 (member apply *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 1 (member attr *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 1 (member call *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 1 (member createElement *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 1 (member css *))" and t = "snk" and result = 0.0691489360 or
   repr = "(parameter 1 (member emit *))" and t = "snk" and result = 0.5000000000 or
   repr = "(parameter 1 (member indexOf *))" and t = "snk" and result = 0.0137614680 or
   repr = "(parameter 1 (member insertAdjacentHTML *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 1 (member insertBefore *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 1 (member isPermittedCrossDomainRequest *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 1 (member makeUrlAbsolute *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 1 (member on *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 1 (member prepend *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 1 (member render *))" and t = "snk" and result = 0.5000000000 or
   repr = "(parameter 1 (member setAttribute *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 1 (member setExpression *))" and t = "snk" and result = 0.3055555600 or
   repr = "(parameter 1 (member setInnerHTMLUnsafe *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 1 (member setProperty *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 1 (member slice *))" and t = "snk" and result = 0.0300000000 or
   repr = "(parameter 1 (member spawn *))" and t = "snk" and result = 0.0276376630 or
   repr = "(parameter 1 (member substring *))" and t = "snk" and result = 0.0137614680 or
   repr = "(parameter 1 (member toggleClass *))" and t = "snk" and result = 0.0320512820 or
   repr = "(parameter 1 (member trigger *))" and t = "snk" and result = 0.0357142860 or
   repr = "(parameter 1 (member write *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 1 (member writeFileSync *))" and t = "snk" and result = 0.2044275660 or
   repr = "(parameter 1 (parameter callback (member withinString *)))" and t = "snk" and result = 0.0300000000 or
   repr = "(parameter 2 (member append *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 2 (member applyAll *))" and t = "snk" and result = 0.1071428600 or
   repr = "(parameter 2 (member call *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 2 (member forEach *))" and t = "snk" and result = 0.5000000000 or
   repr = "(parameter 2 (member on *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 2 (member resolve *))" and t = "snk" and result = 0.2500000000 or
   repr = "(parameter 2 (member setAttributeNS *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 2 (member streamFrame *))" and t = "snk" and result = 0.5000000000 or
   repr = "(parameter 2 (member write *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 2 (parameter callback (member withinString *)))" and t = "snk" and result = 0.0300000000 or
   repr = "(parameter 3 (member append *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 3 (member write *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 3 (parameter callback (member withinString *)))" and t = "snk" and result = 0.0300000000 or
   repr = "(parameter 4 (member append *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 4 (member write *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 5 (member append *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 6 (member append *))" and t = "snk" and result = 1.0000000000 or
   repr = "(parameter 7 (member append *))" and t = "snk" and result = 1.0000000000 or
   repr = "(return (member * (instance (member Collection *))))" and t = "snk" and result = 0.2500000000 or
   repr = "(return (member * (parameter 1 (member extend *))))" and t = "snk" and result = 0.3437499975 or
   repr = "(return (member _getRegExp *))" and t = "snk" and result = 0.0930451140 or
   repr = "(return (member _isRegExpOption *))" and t = "snk" and result = 0.0789473680 or
   repr = "(return (member _resolveWidth *))" and t = "snk" and result = 0.0691489360 or
   repr = "(return (member body *))" and t = "snk" and result = 0.1250000000 or
   repr = "(return (member buildUrl *))" and t = "snk" and result = 0.1071428600 or
   repr = "(return (member camelCase *))" and t = "snk" and result = 0.2797619050 or
   repr = "(return (member clean *))" and t = "snk" and result = 0.2500000000 or
   repr = "(return (member cleanHash *))" and t = "snk" and result = 0.2500000000 or
   repr = "(return (member clickHandler *))" and t = "snk" and result = 0.2500000000 or
   repr = "(return (member cloneObject *))" and t = "snk" and result = 0.2500000000 or
   repr = "(return (member compileNode *))" and t = "snk" and result = 0.0997536950 or
   repr = "(return (member contains *))" and t = "snk" and result = 0.0833333330 or
   repr = "(return (member context *))" and t = "snk" and result = 0.0137614680 or
   repr = "(return (member cookie *))" and t = "snk" and result = 0.1785714300 or
   repr = "(return (member createScript *))" and t = "snk" and result = 0.5000000000 or
   repr = "(return (member css *))" and t = "snk" and result = 0.2500000000 or
   repr = "(return (member debug *))" and t = "snk" and result = 0.1250000000 or
   repr = "(return (member destroy *))" and t = "snk" and result = 0.2500000000 or
   repr = "(return (member display *))" and t = "snk" and result = 0.4214285715 or
   repr = "(return (member element *))" and t = "snk" and result = 0.1666666700 or
   repr = "(return (member encode *))" and t = "snk" and result = 0.3750000000 or
   repr = "(return (member escapeHash *))" and t = "snk" and result = 0.5000000000 or
   repr = "(return (member escapeMarkup *))" and t = "snk" and result = 0.0691489360 or
   repr = "(return (member extend *))" and t = "snk" and result = 0.3125000000 or
   repr = "(return (member f *))" and t = "snk" and result = 0.0171428570 or
   repr = "(return (member fireQueueItem *))" and t = "snk" and result = 0.2500000000 or
   repr = "(return (member fnFormatNumber *))" and t = "snk" and result = 0.0928571430 or
   repr = "(return (member footer *))" and t = "snk" and result = 0.1250000000 or
   repr = "(return (member format *))" and t = "snk" and result = 0.1584507040 or
   repr = "(return (member formatRange *))" and t = "snk" and result = 0.0669014080 or
   repr = "(return (member formatResults *))" and t = "snk" and result = 0.1248768475 or
   repr = "(return (member fromUtf8 *))" and t = "snk" and result = 0.0171428570 or
   repr = "(return (member get *))" and t = "snk" and result = 0.4166666667 or
   repr = "(return (member getBackgroundColor *))" and t = "snk" and result = 0.0232240440 or
   repr = "(return (member getDescription *))" and t = "snk" and result = 0.0232240440 or
   repr = "(return (member getSplashBackgroundColor *))" and t = "snk" and result = 0.0232240440 or
   repr = "(return (member handle *))" and t = "snk" and result = 0.2500000000 or
   repr = "(return (member hasQuery *))" and t = "snk" and result = 0.2500000000 or
   repr = "(return (member header *))" and t = "snk" and result = 0.1250000000 or
   repr = "(return (member hostname *))" and t = "snk" and result = 0.2500000000 or
   repr = "(return (member href *))" and t = "snk" and result = 0.2500000000 or
   repr = "(return (member is *))" and t = "snk" and result = 0.2500000000 or
   repr = "(return (member isError *))" and t = "snk" and result = 0.0603448280 or
   repr = "(return (member navigate *))" and t = "snk" and result = 0.2500000000 or
   repr = "(return (member nodeName *))" and t = "snk" and result = 0.2500000000 or
   repr = "(return (member offsetParent *))" and t = "snk" and result = 0.2500000000 or
   repr = "(return (member pathname *))" and t = "snk" and result = 0.2500000000 or
   repr = "(return (member prop *))" and t = "snk" and result = 0.2500000000 or
   repr = "(return (member readError *))" and t = "snk" and result = 0.1248768475 or
   repr = "(return (member readable *))" and t = "snk" and result = 0.2500000000 or
   repr = "(return (member save *))" and t = "snk" and result = 0.2500000000 or
   repr = "(return (member search *))" and t = "snk" and result = 0.2500000000 or
   repr = "(return (member start *))" and t = "snk" and result = 0.2500000000 or
   repr = "(return (member statusCode *))" and t = "snk" and result = 0.2142857100 or
   repr = "(return (member stop *))" and t = "snk" and result = 0.2500000000 or
   repr = "(return (member stripHash *))" and t = "snk" and result = 0.2500000000 or
   repr = "(return (member success *))" and t = "snk" and result = 0.1071428600 or
   repr = "(return (member suggestion *))" and t = "snk" and result = 1.0000000000 or
   repr = "(return (member template *))" and t = "snk" and result = 0.1194581290 or
   repr = "(return (member triggerHandler *))" and t = "snk" and result = 0.1250000000 or
   repr = "(return (member trim *))" and t = "snk" and result = 0.0928571430 or
   repr = "(return (member uniqueSort *))" and t = "snk" and result = 0.2166666666 or
   repr = "(return (member update *))" and t = "snk" and result = 0.0171428570 or
   repr = "(return (member updateBuffer *))" and t = "snk" and result = 0.0171428570 or
   repr = "(return (member updateUtf8 *))" and t = "snk" and result = 0.0171428570 or
   repr = "(return (member url *))" and t = "snk" and result = 0.5000000000 or
   repr = "(return (member userinfo *))" and t = "snk" and result = 0.2500000000 or
   repr = "(return (member withinString *))" and t = "snk" and result = 0.0300000000 or
   repr = "(return (parameter 0 (member extend *)))" and t = "snk" and result = 0.2500000000 or
   repr = "(return (parameter 0 (member forEach *)))" and t = "snk" and result = 0.0320512820 or
   repr = "(return (parameter 0 (member html *)))" and t = "snk" and result = 1.0000000000 or
   repr = "(return (parameter 0 (member map *)))" and t = "snk" and result = 0.2500000000 or
   repr = "(return (parameter 0 (member parse *)))" and t = "snk" and result = 0.0137614680 or
   repr = "(return (parameter 1 (member map *)))" and t = "snk" and result = 0.0669014080 or
   repr = "(return (return (member tokenizer *)))" and t = "snk" and result = 0.0137614680
   } 
}
