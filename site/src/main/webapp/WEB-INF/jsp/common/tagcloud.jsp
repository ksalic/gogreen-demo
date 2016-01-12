<%--

    Copyright 2010-2015 Hippo B.V. (http://www.onehippo.com)

--%>

<%@include file="../includes/tags.jspf" %>
<div class="sidebar-block">
    <h3 class="h3-sidebar-title sidebar-title">
        <c:out value="${requestScope.tagcloud.title}"/>
    </h3>
    <div class="sidebar-content tags tagcloud">
        <c:forEach var="tag" items="${requestScope.tagcloud.tags}">
            <c:choose>
                <c:when test="${tag.type eq 'TCMP_CUSTOMTAG'}">
                    <c:choose>
                        <c:when test="${tag.external}">
                            <a href="${tag.url}" style="${tag.style}"><c:out value="${tag.label}"/></a>
                        </c:when>
                        <c:when test="${not empty tag.oneBean}">
                            <a href="<hst:link hippobean="${tag.oneBean}" />" style="${tag.style}"><c:out value="${tag.label}"/></a>
                        </c:when>
                        <c:otherwise>
                            <a href="<hst:link hippobean="${tag.bean}" />" style="${tag.style}"><c:out value="${tag.label}"/></a>
                        </c:otherwise>
                    </c:choose>
                </c:when>
                <c:otherwise>
                    <a href="<hst:link hippobean="${tag.bean}" />" style="${tag.style}"><c:out value="${tag.label}"/></a>
                </c:otherwise>
            </c:choose>
        </c:forEach>
    </div>
</div>
