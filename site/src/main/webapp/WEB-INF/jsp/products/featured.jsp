<%--

    Copyright 2010-2015 Hippo B.V. (http://www.onehippo.com)

--%>

<%@include file="../includes/tags.jspf" %>

<c:if test="${not empty requestScope.products}">

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

<c:choose>
  <c:when test="${fn:length(products) eq 1}">
      <c:set var="colSize" value="12"/>
  </c:when>
  <c:when test="${fn:length(products) eq 2}">
      <c:set var="colSize" value="6"/>
  </c:when>
  <c:when test="${fn:length(products) eq 3}">
      <c:set var="colSize" value="4"/>
  </c:when>
  <c:when test="${fn:length(products) ge 4}">
      <c:set var="colSize" value="3"/>
  </c:when>
</c:choose>

<div class="container">
	<div class="row">
      <%--@elvariable id="products" type="java.util.List<com.onehippo.gogreen.beans.Product>"--%>
      <c:forEach items="${products}" var="prd" varStatus="index">
        <hst:link var="prdLink" hippobean="${prd}"/>
        <hst:link var="prdImgLink" hippobean="${prd.firstImage.largeThumbnail}"/>
        <div class="col-md-${colSize} col-sm-${colSize}">
          <div class="feature product-category">
            <div class="feature-image">
              <hst:cmseditlink hippobean="${prd}" />
              <a href="${fn:escapeXml(prdLink)}"><img src="${fn:escapeXml(prdImgLink)}" alt="${fn:escapeXml(prd.firstImage.alt)}"/></a>
            </div>
            <div class="feature-content">
              <h3 class="h3-body-title"><a href="${fn:escapeXml(prdLink)}">
                <c:out value="${prd.title}"/></a>
              </h3>
            </div>
          </div>
        </div>
      </c:forEach>
  </div>
</div>
</c:if>

<c:if test="${empty requestScope.products and requestScope.preview}">
  <h2 class="not-configured">Click to configure featured products</h2>
</c:if>