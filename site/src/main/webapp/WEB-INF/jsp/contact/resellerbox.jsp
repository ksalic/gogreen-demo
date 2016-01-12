<%--

    Copyright 2011-2013 Hippo B.V. (http://www.onehippo.com)

--%>

<%@include file="../includes/tags.jspf" %>
<% request.setAttribute("user", request.getSession().getAttribute("user")); %>
<% if (request.isUserInRole("reseller")) { %>
  <ul class="box-general reseller-contact">
    <li class="pic"><img src="<hst:link path="/images/johnny.png"/>"/></li>
    <li class="message">
      <c:choose>
        <c:when  test="${not empty user.firstname}">
          <fmt:message key="contact.reseller.welcome">
            <fmt:param value="${user.firstname}"/>
          </fmt:message>
        </c:when>
        <c:otherwise>
          <fmt:message key="contact.reseller.welcome.no.reseller" />
        </c:otherwise>
      </c:choose>
    </li>
    <li class="action contact">
      <a onclick="window.open(this.href, 'chatbox', 'width=355,height=350,scrollbars=0,location=0'); return false;" href="<hst:link path="/images/chat.png"/>"><fmt:message key="contact.reseller.contact"/></a>
    </li>
    <li class="action faq">
      <a href="<hst:link path="/resellerfaq"/>"><fmt:message key="contact.reseller.gotofaq"/></a>
    </li>
  </ul>
<% } %>
