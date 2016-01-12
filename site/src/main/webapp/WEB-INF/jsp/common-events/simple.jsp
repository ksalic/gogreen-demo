<%--

    Copyright 2010-2015 Hippo B.V. (http://www.onehippo.com)

--%>

<%@include file="../includes/tags.jspf" %>

<hippo-gogreen:title title="${requestScope.document.title}"/>

<div class="yui-main">
  <div id="content" class="yui-b left-and-right">
    <div id="event-simple" class="about <c:if test="${requestScope.preview}">editable</c:if>">

      <hst:cmseditlink hippobean="${requestScope.document}" />
      <h2 class="title"><c:out value="${requestScope.document.title}" /></h2>
      <p class="introduction">
        <c:out value="${requestScope.document.summary}" />
      </p>

      <div class="yui-cssbase body">
        <hst:html hippohtml="${requestScope.document.description}" />

        <hst:include ref="form"/>
      </div>

    </div>
  </div>
</div>