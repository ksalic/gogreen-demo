<%--

    Copyright 2010-2015 Hippo B.V. (http://www.onehippo.com)

--%>

<%@include file="../../includes/tags.jspf" %>

<!-- NOTE: Switch on the following variable if you want to eanble Inline Editing feature in this page. -->
<c:set var="inlineEditingEnabled" value="true" />

<c:if test="${requestScope.preview}">
  <c:if test="${inlineEditingEnabled}">
    <jsp:include page="../../inc/inline-editing-head-contributions.jsp"/>
  </c:if>
</c:if>

<hippo-gogreen:title title="${requestScope.document.title}"/>

<hst:headContribution category="jsInternal">
    <hst:link var="rateJs" path="/js/mobile/rate.js"/>
    <script src="${rateJs}" type="text/javascript"></script>
</hst:headContribution>

<ga:trackDocument hippoDocumentBean="${requestScope.document}"/>
    
<!-- body / main -->
<div id="bd">
    <c:set var="style">detail<c:if test="${requestScope.preview}"> editable</c:if></c:set>
    <div id="content" class="${style}">
        <h1><c:out value="${requestScope.document.title}"/></h1>
        <c:if test="${requestScope.preview}">
          <hst:cmseditlink hippobean="${requestScope.document}" />
        </c:if>
        <p id="product-info" class="doc-info">
          <span class="price"><fmt:formatNumber value="${requestScope.document.price}" type="currency"/></span>
          <span class="seperator">|</span>
          <fmt:formatNumber value="${requestScope.document.rating * 10}" var="ratingStyle" pattern="#0"/>
          <span class="rating stars-${ratingStyle}"><c:out value="${requestScope.document.rating}"/></span>
        </p>
        
        <!-- image gallery -->
        <c:if test="${fn:length(requestScope.document.images) > 0}">
          <div id="gallery-container">
            <ul id="gallery">
                <hst:link hippobean="${requestScope.document.images[0].largeThumbnail}" var="imgLink"/>
                <li><img src="${imgLink}" alt="${fn:escapeXml(requestScope.document.images[0].alt)}"/></li>
            </ul>
            <p class="copyright">&lt;<fmt:message key="mobile.products.detail.imgcopyright"/>&gt;</p>
          </div>
        </c:if>
        
        <p class="date"><fmt:message key="mobile.products.detail.sampledate"/></p>
        <p class="summary"><c:out value="${requestScope.document.summary}"/></p>
        <div class="description">
          <hst:html hippohtml="${requestScope.document.description}"/>
        </div>
        <hippo-gogreen:copyright document="${requestScope.document}" truncate="60"/>
        
        <hst:actionURL var="actionUrl"/>
        
        <h3><fmt:message key="products.detail.reviewarticle"/></h3>
        <div id="review">
          <form id="frmRating" action="${actionUrl}" method="post">
            <table>
              <c:if test="${not empty requestScope.success}">
              <tr>
                <td colspan="2">
                  <fmt:message key="products.detail.thanksforreview"/>
                </td>
              </tr>
              </c:if>
              <tr>
                <td class="label"><fmt:message key="products.detail.name"/></td>
                <td class="input"><input type="text" value="${fn:escapeXml(requestScope.name)}" name="name" />
                  <c:if test="${not empty requestScope.errors}">
                    <c:forEach items="${requestScope.errors}" var="error">
                      <c:if test="${error eq 'invalid.name-label'}">
                        <span class="form-error"><fmt:message key="products.detail.name.error"/></span>
                      </c:if>
                    </c:forEach>
                  </c:if>
                </td>
              </tr>
              <tr>
                <td class="label"><fmt:message key="products.detail.email"/></td>
                <td class="input"><input type="text" value="${fn:escapeXml(requestScope.email)}" name="email" />
                  <c:if test="${not empty requestScope.errors}">
                    <c:forEach items="${requestScope.errors}" var="error">
                      <c:if test="${error eq 'invalid.email-label'}">
                        <span class="form-error"><fmt:message key="products.detail.email.error"/></span>
                      </c:if>
                    </c:forEach>
                  </c:if>
                </td>
              </tr>
              <tr>
                <td class="label vmiddle"><fmt:message key="products.detail.score"/></td>
                <td class="input">
                  <ol class="rate">
                    <li><span title="Rate: 1">1</span></li>
                    <li><span title="Rate: 2">2</span></li>
                    <li><span title="Rate: 3">3</span></li>
                    <li><span title="Rate: 4">4</span></li>
                    <li><span title="Rate: 5">5</span></li>
                  </ol>
                <input type="hidden" value="0" name="rating" id="ratingField" />
                </td>
              </tr>
              <tr>
                <td class="label vtop"><fmt:message key="products.detail.review"/></td>
                <td class="input">
                  <textarea name="comment" id="comment" rows="3" cols="24"><c:if test="${not empty requestScope.comment}"><c:out value="${requestScope.comment}"/></c:if></textarea>
                  <c:if test="${not empty requestScope.errors}">
                    <c:forEach items="${requestScope.errors}" var="error">
                      <c:if test="${error eq 'invalid.comment-label'}">
                        <span class="form-error"><fmt:message key="products.detail.review.error"/></span>
                      </c:if>
                    </c:forEach>
                  </c:if>
                </td>
              </tr>

              <c:if test="${not empty requestScope.errors}">
                <c:forEach items="${requestScope.errors}" var="error">
                  <c:if test="${error eq 'invalid.spam-label'}">
                    <span class="form-error"><fmt:message key="common.spam.error"/></span><br/>
                  </c:if>
                </c:forEach>
              </c:if>

              <tr id="confirmation">
                <td><fmt:message key="common.spamfield.label"/></td>
                <td>
                  <input type="text" name="confirmation"/>
                </td>
              </tr>
              <tr id="feedback">
                <td><fmt:message key="common.spamfield.label"/></td>
                <td>
                  <textarea name="feedback" rows="8" cols="50"></textarea>
                </td>
              </tr>

              <tr>
                <td></td>
                <td class="submit"><input type="submit" value="<fmt:message key="products.detail.submit.label"/>" id="review-button" /></td>
              </tr>
            </table>
          </form>
        </div>
      </div>

</div>