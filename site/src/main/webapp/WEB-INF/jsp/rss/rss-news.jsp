<%--

    Copyright 2010-2015 Hippo B.V. (http://www.onehippo.com)

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

            http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.

--%>
<%@include file="../includes/tags.jspf" %>

<rss version="2.0">
   <channel>
      <title><fmt:message key="rss.news.title"/></title>
      <link>http://demo.onehippo.com/</link>
      <description><fmt:message key="rss.news.description"/></description>
      <language><fmt:message key="rss.news.language"/></language>
      <generator><fmt:message key="rss.news.generator"/></generator>
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
