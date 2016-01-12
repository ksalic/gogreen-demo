<%--

    Copyright 2010-2013 Hippo B.V. (http://www.onehippo.com)

--%>

<%@include file="../../includes/tags.jspf" %>

<c:set var="mobileeventssearchtitle"><fmt:message key="mobile.events.search.title"/></c:set>
<hippo-gogreen:title title="${mobileeventssearchtitle}"/>

<!-- body / main -->
<div id="bd">

    <hst:include ref="facets"/>        
    <hst:include ref="results"/>        

</div>