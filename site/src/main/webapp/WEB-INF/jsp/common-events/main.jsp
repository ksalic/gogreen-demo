<%--

    Copyright 2010-2015 Hippo B.V. (http://www.onehippo.com)

--%>

<%@include file="../includes/tags.jspf" %>

<c:set var="abouttitle"><fmt:message key="about.title"/></c:set>
<hippo-gogreen:title title="${abouttitle}"/>

<div class="yui-main">
  <div id="content" class="yui-b left-and-right">

    <c:choose>
      <c:when test="${requestScope.documents ne null}">
        <div id="about">
          <h2 class="title"><c:out value="${requestScope.folderName}"/></h2>
          <c:forEach items="${requestScope.documents}" var="document">
            <ul class="about-item <c:if test="${requestScope.preview}">editable</c:if>">
              <hst:cmseditlink hippobean="${document}" />
              <hst:link var="link" hippobean="${document}"/>
              <li class="title"><a href="${link}"><c:out value="${document.title}"/></a></li>
              <li class="description"><c:out value="${document.summary}"/></li>
            </ul>
          </c:forEach>
        </div>
      </c:when>
      <c:when test="${requestScope.document ne null}">
        <div id="article" class="about <c:if test="${requestScope.preview}">editable</c:if>">
          <hst:cmseditlink hippobean="${requestScope.document}" />
          <h2 class="title"><c:out value="${requestScope.document.title}"/></h2>

          <p class="intro"><c:out value="${requestScope.document.summary}"/></p>

          <div class="yui-cssbase body">
            <hst:html hippohtml="${requestScope.document.description}"/>
          </div>
        </div>
      </c:when>
    </c:choose>
  </div>
</div>
