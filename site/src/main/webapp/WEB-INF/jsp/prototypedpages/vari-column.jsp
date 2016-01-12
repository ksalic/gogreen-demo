<%--

    Copyright 2014 Hippo B.V. (http://www.onehippo.com)

--%>

<%@include file="../includes/tags.jspf" %>

<hst:defineObjects/>

<c:set var="pageTitle" value="${hstRequestContext.resolvedSiteMapItem.pageTitle}"/>
<hippo-gogreen:title title="${pageTitle}"/>

<div class="content-wrapper no-container vari-column">
  <c:if test="${not empty pageTitle}">
    <div class="top-title-wrapper">
      <div class="container">
        <div class="row">
          <div class="col-md-12 col-sm-12">
            <div class="page-info">
              <h1 class="h1-page-title">${pageTitle}</h1>

                <%--<h2 class="h2-page-desc"></h2>--%>

              <div class="breadcrumb-container">
                <ol class="breadcrumb">
                  <li>
                    <a href="<hst:link siteMapItemRefId="home"/>">Home</a>
                  </li>
                  <li class="active">${pageTitle}</li>
                </ol>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </c:if>

  <div class="body-wrapper">
    <div class="container">
      <div class="row">
        <div class="col-md-12 col-sm-12">
        <hst:include ref="top"/>
        </div>
      </div>

      <div class="row">
        <div class="col-md-9 col-sm-9">
          <hst:include ref="left1"/>
        </div>
        <div class="col-md-3 col-sm-3">
          <hst:include ref="right1"/>
        </div>
      </div>

      <div class="row">
        <div class="col-md-3 col-sm-3">
          <hst:include ref="left2"/>
        </div>
        <div class="col-md-9 col-sm-9">
          <hst:include ref="right2"/>
        </div>
      </div>

      <div class="row">
        <div class="col-md-12 col-sm-12">
          <hst:include ref="bottom"/>
        </div>
      </div>
    </div>
  </div>
</div>