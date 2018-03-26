<%--

    Copyright 2010-2018 Hippo B.V. (http://www.onehippo.com)

--%>

<%@include file="../../includes/tags.jspf" %>

<c:set var="mobileeventssearchtitle"><fmt:message key="mobile.events.search.title" var="searchtitle"/> <c:out value="searchtitle"/></c:set>
<hippo-gogreen:title title="${mobileeventssearchtitle}"/>

<!-- body / main -->
<div id="bd">

    <hst:include ref="facets"/>        
    <hst:include ref="results"/>        

</div>