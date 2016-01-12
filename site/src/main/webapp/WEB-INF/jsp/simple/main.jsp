<%--

    Copyright 2010-2015 Hippo B.V. (http://www.onehippo.com)

--%>

<%@include file="../includes/tags.jspf" %>

<div class="content-wrapper">
  <div class="hero-wrapper">
    <hst:include ref="hero"/>
  </div>
  <div class="top-title-wrapper">
    <div class="container">
      <div class="row">
        <div class="col-md-12 col-sm-12">
          <div class="page-info">

          </div>
        </div>
      </div>
    </div>
  </div>

  <div class="body-wrapper">
    <div class="container">
      <div class="row">
        <div class="col-md-9 col-sm-9">
          <c:if test="${requestScope.document ne null}">
            <hst:cmseditlink hippobean="${requestScope.document}" />
            <h2 ><c:out value="${requestScope.document.title}"/></h2>

            <p><c:out value="${requestScope.document.summary}"/></p>
            <p><hst:html hippohtml="${requestScope.document.description}"/></p>

            <hippo-gogreen:title title="${requestScope.document.title}"/>
          </c:if>
        </div>
        <div class="col-md-3 col-sm-3">
          <hst:include ref="right"/>
        </div>
      </div>

      <hst:include ref="bottom"/>
  </div>
</div>




