<%--

    Copyright 2010-2015 Hippo B.V. (http://www.onehippo.com)

--%>

<%@include file="../../includes/tags.jspf" %>

<hippo-gogreen:title title="${requestScope.document.title}"/>

<!-- body / main -->
<div id="bd">
    <c:set var="style">detail<c:if test="${requestScope.preview}"> editable</c:if></c:set>
    <div id="content" class="${style}">
        <h1><c:out value="${requestScope.document.title}"/></h1>
        <c:if test="${requestScope.preview}">
          <hst:cmseditlink hippobean="${requestScope.document}" />
        </c:if>
        <p id="event-info" class="doc-info">
            <span class="location"><c:out value="${requestScope.document.location.street}"/>&nbsp;<c:out value="${requestScope.document.location.number}"/>,&nbsp;<c:out value="${requestScope.document.location.city}"/>&nbsp;<c:out value="${requestScope.document.location.postalCode}"/>&nbsp;<c:out value="${requestScope.document.location.province}"/></span>
            <span class="date">
                <hst:setBundle basename="messages"/>
                <fmt:message key="standard.date.format" var="dateformat"/>
                <fmt:formatDate value="${requestScope.document.date.time}" pattern="${dateformat}"/>
            </span>
        </p>
        
        <div class="calendar">
            <span class="month"><fmt:formatDate value="${requestScope.document.date.time}" pattern="MMM"/></span>
            <span class="day"><fmt:formatDate value="${requestScope.document.date.time}" pattern="dd"/></span>
        </div>
        
        <p class="summary"><c:out value="${requestScope.document.summary}"/></p>
        <div class="description">
            <hst:html hippohtml="${requestScope.document.description}"/>
        </div>
        <p id="event-extra"><span><fmt:message key="mobile.events.detail.vieweventlabel"/></span>
            <c:url var="url" value="http://maps.google.com/?q=${requestScope.document.location.street} ${requestScope.document.location.number}, ${requestScope.document.location.city} ${requestScope.document.location.postalCode} ${requestScope.document.location.province}"/>
            <a href="${fn:escapeXml(url)}"><img src="<hst:link path="/images/mobile/logo-gmaps.png"/>" alt="<fmt:message key="mobile.events.detail.ingoogle"/>" /></a>
            <%--<a href="#view-json-xml"><img src="<hst:link path="/images/mobile/logo-layar.png"/>" alt="<fmt:message key="mobile.events.detail.inlayar"/>"/></a>--%>
        </p>
    </div>

</div>