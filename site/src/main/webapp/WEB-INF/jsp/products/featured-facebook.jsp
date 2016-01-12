<%--

    Copyright 2010-2015 Hippo B.V. (http://www.onehippo.com)

--%>

<%@include file="../includes/tags.jspf" %>
<div class="products container">
  <div class="row">
    <h2 class="h2-section-title"><fmt:message key="home.products.label"/></h2>
  </div>
  <div class="row">
    <%--@elvariable id="products" type="java.util.List<com.onehippo.gogreen.beans.Product>"--%>
    <c:forEach items="${requestScope.products}" var="prd" varStatus="index">
      <hst:link var="prdLink" hippobean="${prd}"/>
      <hst:link var="externalprdLink" hippobean="${prd}" fullyQualified="true"/>
      <hst:link var="prdImgLink" hippobean="${prd.firstImage.largeThumbnail}"/>
      <div class="col-md-4 col-sm-4">
        <div class="feature product-category">
          <div class="feature-image">
            <hst:cmseditlink hippobean="${prd}" />
            <img src="${fn:escapeXml(prdImgLink)}" alt="${fn:escapeXml(prd.firstImage.alt)}"/>
            <div class="feature-content">
              <h3 class="h3-body-title"><a href="${fn:escapeXml(prdLink)}">
                <c:out value="${prd.title}"/></a>
              </h3>
              <p><fb:like href="${fn:escapeXml(externalprdLink)}" send="false" layout="button_count" width="450" show_faces="false"></fb:like></p>
            </div>
          </div>
        </div>
      </div>
    </c:forEach>
  </div>
</div>
