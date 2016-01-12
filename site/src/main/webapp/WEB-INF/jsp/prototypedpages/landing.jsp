<%--

    Copyright 2014 Hippo B.V. (http://www.onehippo.com)

--%>

<%@include file="../includes/tags.jspf" %>

<hst:defineObjects/>

<c:set var="pageTitle" value="${hstRequestContext.resolvedSiteMapItem.pageTitle}"/>
<hippo-gogreen:title title="${pageTitle}"/>

<div class="content-wrapper no-container">
    <div class="hero-wrapper">
        <hst:include ref="hero"/>
    </div>
    <c:if test="${not empty pageTitle}">
        <div class="top-title-wrapper">
            <div class="container">
                <div class="row">
                    <div class="col-md-12 col-sm-12">
                        <div class="page-info">
                            <h1 class="h1-page-title">${pageTitle}</h1>

                            <%--<h2 class="h2-page-desc"></h2>--%>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </c:if>

    <div class="body-wrapper">
        <div class="container">
            <div class="row">
                <div class="col-md-9 col-sm-9">
                    <hst:include ref="content"/>
                </div>

                <div class="col-md-3 col-sm-3">
                    <hst:include ref="right"/>
                </div>
            </div>
        </div>
    </div>
</div>