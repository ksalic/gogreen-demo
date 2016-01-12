<%--

    Copyright 2010-2015 Hippo B.V. (http://www.onehippo.com)

--%>
<%--@elvariable id="document" type="com.onehippo.gogreen.beans.EventDocument"--%>
<%@include file="../../includes/tags.jspf" %>

<hippo-gogreen:title title="${requestScope.document.title}"/>

<div class="blog-post">

    <div class="blog-post-type">
        <i class="icon-calendar"> </i>
    </div>

    <div class="blog-span">
        <hst:cmseditlink hippobean="${requestScope.document}" />
        <c:set var="image" value="${requestScope.document.firstImage}"/>
        <c:if test="${image != null and image.landscapeImage != null}">
            <div class="blog-post-featured-img img-overlay">
                <hst:link var="src" hippobean="${image.landscapeImage}"/>
                <hst:link var="imgOrig" hippobean="${image.original}"/>
                <img class="img-responsive" src="${src}" alt="${fn:escapeXml(image.alt)}"/>
                <hippo-gogreen:imagecopyright image="${image}"/>

                <div class="item-img-overlay">
                    <a class="portfolio-zoom icon-zoom-in" href="${imgOrig}" data-rel="prettyPhoto[portfolio]" title="${fn:escapeXml(image.alt)}"></a>
                </div>
            </div>
        </c:if>
        <h2>
            <c:out value="${requestScope.document.title}"/>
        </h2>

        <div class="blog-post-body">
            <p><c:out value="${requestScope.document.summary}"/></p>
            <hst:html hippohtml="${requestScope.document.description}"/>
            <hippo-gogreen:copyright document="${requestScope.document}"/>
        </div>

        <div class="blog-post-details">

            <div class="blog-post-details-item blog-post-details-item-left icon-calendar">
                <span class="date">
                    <hst:setBundle basename="messages"/>
                    <fmt:message key="standard.date.format" var="dateformat"/>
                    <fmt:formatDate value="${requestScope.document.date.time}" type="date" pattern="${dateformat}"/>
                </span>
            </div>

            <%--<div class="blog-post-details-item blog-post-details-item-left blog-post-details-tags icon-files">
                <a href="">
                    Business
                </a> ,
                <a href="">
                    Investment
                </a> ,
                <a href="">
                    Freelancing
                </a>
            </div>--%>

            <c:if test="${not empty requestScope.document.location}">
                <input id="address" type="hidden"
                       value="${requestScope.document.location.street}&nbsp;${requestScope.document.location.number},&nbsp;${requestScope.document.location.city}&nbsp;${requestScope.document.location.postalCode}&nbsp;${requestScope.document.location.province}"/>
            </c:if>
        </div>
             <!-- If there are any tags for this document, then display them with links -->
        <div class="tags">
        <c:if test="${!empty requestScope.document.tags}">
            <hst:setBundle basename="general.text"/>

                <c:forEach var="tag" items="${requestScope.document.tags}">
                    <hst:link siteMapItemRefId="search-faceted" var="link"/>
                    <fmt:message key="search.facet.tags" var="tagname" />
                    <a href="${link}/${tagname}/${tag}">${tag}</a>
                </c:forEach>


        </c:if>
            <c:if test="${!empty requestScope.document.categories}">
                <hst:setBundle basename="messages"/>

                <c:forEach var="tag" items="${requestScope.document.categories}">
                    <hst:link siteMapItemRefId="search-faceted" var="link"/>
                    <fmt:message key="search.facet.category" var="tagname" />
                    <a href="${link}/${tagname}/${tag}">${tag}</a>
                </c:forEach>


            </c:if>
        </div>
    </div>
</div>