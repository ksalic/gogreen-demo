<%--

    Copyright 2010-2013 Hippo B.V. (http://www.onehippo.com)

--%>

<%@include file="../../includes/tags.jspf" %>

<c:set var="hometitle"><fmt:message key="home.title"/></c:set>
<hippo-gogreen:title title="${hometitle}"/>


<div id="main">

    <hst:defineObjects/>
    <div class="hst-container">
      <c:forEach var="childContentName" items="${hstResponseChildContentNames}">
        <div class="hst-container-item">
            <hst:include ref="${childContentName}"/>
        </div>
      </c:forEach>
    </div>

</div>
