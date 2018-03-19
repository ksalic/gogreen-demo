<%--

    Copyright 2010-2018 Hippo B.V. (http://www.onehippo.com)

--%>
<%@include file="../includes/tags.jspf" %>

<rss version="2.0">
   <channel>
      <title><fmt:message key="rss.news.title" var="newstitle"/> <c:out value="newstitle"/></title>
      <link>http://demo.onehippo.com/</link>
      <description><fmt:message key="rss.news.description" var="newsdescription"/> <c:out value="newsdescription"/></description>
      <language><fmt:message key="rss.news.language" var="newslanguage"/> <c:out value="newslanguage"/></language>
      <generator><fmt:message key="rss.news.generator" var="newsgenerator"/> <c:out value="newsgenerator"/></generator>
      <c:forEach var="item" items="${requestScope.items}">
      <hst:link var="link" hippobean="${item}" fullyQualified="true" />
         <item>
            <title><c:out value="${item.title}" /></title>
            <link><c:out value="${link}"/></link>
            <description><c:out value="${item.summary}" /></description>
            <pubDate><fmt:formatDate value="${item.publicationDate.time}" pattern="EE, dd MMM yyyy HH:mm:ss Z"/></pubDate>
         </item>
      </c:forEach>
   </channel>
</rss>
