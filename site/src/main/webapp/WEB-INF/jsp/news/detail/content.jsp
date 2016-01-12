<%--

    Copyright 2010-2015 Hippo B.V. (http://www.onehippo.com)

--%>

<%@include file="../../includes/tags.jspf" %>

<hippo-gogreen:title title="${requestScope.document.title}"/>

<div class="blog-post">

    <div class="blog-post-type">
        <i class="icon-news"> </i>
    </div>

    <div class="blog-span">
        <hst:cmseditlink hippobean="${requestScope.document}" />
        <h2>
            <c:out value="${requestScope.document.title}"/>
        </h2>

        <div class="blog-post-body">
            <c:out value="${requestScope.document.summary}"/>
            <hst:html hippohtml="${requestScope.document.description}"/>
        </div>

        <div class="blog-post-details">

            <div class="blog-post-details-item blog-post-details-item-left icon-calendar">
                <span class="date">
                    <hst:setBundle basename="messages"/>
                    <fmt:message key="standard.date.format" var="dateformat"/>
                    <fmt:formatDate value="${requestScope.document.date.time}" type="date" pattern="${dateformat}"/>
                </span>
            </div>

            <div class="blog-post-details-item blog-post-details-item-right">
                <hst:link var="link" siteMapItemRefId="news"/>
                <a href="${link}">
                  <i class="fa fa-chevron-left"></i> <fmt:message key="common.back.overview"/>
                </a>
            </div>

        </div>
    </div>
</div>

<hst:include ref="comments"/>