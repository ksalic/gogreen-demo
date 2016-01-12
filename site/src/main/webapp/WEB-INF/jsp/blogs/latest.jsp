<%--

    Copyright 2010-2015 Hippo B.V. (http://www.onehippo.com)

--%>

<%@include file="../includes/tags.jspf" %>

<c:if test="${fn:length(requestScope.items) gt 0}">

    <c:choose>
        <c:when test="${fn:length(requestScope.items) eq 1}">
            <c:set var="colSize" value="12"/>
        </c:when>
        <c:when test="${fn:length(requestScope.items) eq 2}">
            <c:set var="colSize" value="6"/>
        </c:when>
        <c:when test="${fn:length(requestScope.items) eq 3}">
            <c:set var="colSize" value="4"/>
        </c:when>
        <c:when test="${fn:length(requestScope.items) eq 4}">
            <c:set var="colSize" value="3"/>
        </c:when>
    </c:choose>

    <div class="container">
    <c:if test="${not empty requestScope.title}">
        <div class="row">
            <div class="col-md-12 col-sm-12">
                <h2 class="h2-section-title"><c:out value="${requestScope.title}"/></h2>
                <c:if test="${not empty requestScope.icon}">
                    <div class="i-section-title">
                        <i class="fa <c:out value="${requestScope.icon}"/>"></i>
                    </div>
                </c:if>
            </div>
        </div>
    </c:if>

            <div class="row latest-items">
                <c:forEach items="${requestScope.items}" var="item">
                    <div class="col-md-${colSize} col-sm-${colSize}">
                        <hst:cmseditlink hippobean="${item}"/>
                        <div class="feature">
                              <div class="feature-image">
                                  <a href="<hst:link hippobean="${item}"/>"><img src="<hst:link hippobean="${item.firstImage.largeThumbnail}"/>" alt="${item.firstImage.alt}"></a>
                              </div>

                            <div class="feature-content">
                                <h3 class="h3-body-title blog-title">
                                    <a href="<hst:link hippobean="${item}"/>"><c:out value="${item.title}"/></a>
                                </h3>
                                <p>
                                    <c:out value="${item.summary}"/>
                                </p>

                            </div>

                            <div class="feature-details">
                                <i class="icon-calendar"></i>
                                <span>
                                  <hst:setBundle basename="messages"/>
                                  <fmt:message key="standard.date.format" var="dateformat"/>
                                  <fmt:formatDate value="${item.date.time}" pattern="${dateformat}"/>
                                </span>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>

    <c:if test="${requestScope.separatorBorderTop}">
        <c:set var="cssClass"> border-top</c:set>
    </c:if>
    <c:if test="${requestScope.separatorBorderBottom}">
        <c:set var="cssClass">${cssClass} border-bottom</c:set>
    </c:if>
    <c:if test="${not empty requestScope.separatorMargin or not empty cssClass}">
        <div class="space-sep<c:out value="${requestScope.separatorMargin} ${cssClass}"/>"></div>
    </c:if>
</c:if>