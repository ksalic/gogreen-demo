<%--

    Copyright 2010-2013 Hippo B.V. (http://www.onehippo.com)

--%>

<%@include file="../includes/tags.jspf" %>

<c:set var="abouttitle"><fmt:message key="about.title"/></c:set>
<hippo-gogreen:title title="${abouttitle}"/>

<c:choose>
    <c:when test="${documents ne null}">
        <h2 class="h2-section-title"><c:out value="${folderName}"/></h2>
        <div class="i-section-title"></div>
        <c:forEach items="${documents}" var="document">
            <hst:link var="link" hippobean="${document}"/>
                <hst:cmseditlink hippobean="${document}" />
                <h3>
                    <a href="${link}"><c:out value="${document.title}"/></a>
                </h3>

                <p><c:out value="${document.summary}"/></p>
                <div class="divider divider-shadow"></div>
        </c:forEach>
    </c:when>
    <c:when test="${document ne null}">
        <hst:cmseditlink hippobean="${document}" />
        <h2 ><c:out value="${document.title}"/></h2>

        <p><c:out value="${document.summary}"/></p>
        <p><hst:html hippohtml="${document.description}"/></p>
    </c:when>
</c:choose>