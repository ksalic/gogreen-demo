<%--

    Copyright 2010-2015 Hippo B.V. (http://www.onehippo.com)

--%>

<%@include file="../includes/tags.jspf" %>
<hst:defineObjects/>

<div class="section-content section-tabs section-px stones-bg white-text">
    <c:choose>
        <c:when test="${requestScope.preview}">
            <c:set var="cssClass">tab-container-preview</c:set>
        </c:when>
        <c:otherwise>
            <c:set var="cssClass">tab-container</c:set>
        </c:otherwise>
    </c:choose>
    <div class="${cssClass}">
        <div class="section-tab-arrow"></div>
        <div class="section-etabs-container">
            <ul class="section-etabs">
                <c:forEach items="${hstResponseChildContentNames}" var="childContentName" varStatus="index">
                    <li class="tab active">
                        <a href="#tabc${index.count}">News</a>
                    </li>
                </c:forEach>
            </ul>
        </div>
        <div class="container">
            <div class="tab-content hst-container">
                <!-- intro -->
                <c:forEach items="${hstResponseChildContentNames}" var="childContentName" varStatus="index">
                    <div id="tabc${index.count}" class="hst-container-item">
                        <hst:include ref="${childContentName}"/>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>
</div>