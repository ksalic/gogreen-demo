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

<c:if test="${requestScope.documents != null and not empty requestScope.documents}">
    <div class="sidebar-block">
        <h3 class="h3-sidebar-title sidebar-title">
            <c:out value="${requestScope.headline}"/>
        </h3>

        <div class="sidebar-content">
            <ul class="posts-list">
                <hst:setBundle basename="messages"/>
                <fmt:message key="standard.date.format" var="dateformat"/>
                <c:forEach items="${requestScope.documents}" var="doc">
                    <li>
                        <hst:link var="link" hippobean="${doc}"/>
                        <c:if test="${not empty doc.firstImage}">
                            <div class="posts-list-thumbnail">
                                <a href="${link}">
                                    <img src="<hst:link hippobean="${doc.firstImage.smallThumbnail}"/>" alt="${doc.firstImage.alt}" class="img-responsive" width="54"/>
                                </a>
                            </div>
                        </c:if>
                        <div class="posts-list-content">
                            <a href="${link}" class="posts-list-title"><c:out value="${doc.title}"/></a>
                            <c:choose>
                                <c:when test="${doc.getClass().name == 'com.onehippo.gogreen.beans.Product'}">
                                    <span class="posts-list-meta">
                                        <c:choose>
                                            <c:when test="${doc.rating ne 0}">
                                                <hst:headContribution keyHint="rateJs" category="headScripts">
                                                    <hst:link path="/js/jquery.raty.js" var="rateJs"/>
                                                    <script type="text/javascript" src="${rateJs}"></script>
                                                </hst:headContribution>

                                                <hst:headContribution keyHint="rateCss" category="css">
                                                    <hst:link path="/css/jquery.raty.css" var="rateCss"/>
                                                    <link rel="stylesheet" href="${rateCss}"/>
                                                </hst:headContribution>

                                                <span data-score="${doc.rating}" class="product-rating"/>

                                                <script type="text/javascript">
                                                    $('.product-rating').raty({
                                                        score: function() {
                                                            return $(this).attr('data-score');
                                                        },
                                                        readOnly: true,
                                                        half: true,
                                                        starType :  'i'
                                                    });
                                                </script>
                                            </c:when>
                                            <c:otherwise>
                                                <fmt:message key="products.rating.unrated"/>
                                            </c:otherwise>
                                        </c:choose>
                                    </span>
                                </c:when>
                                <c:otherwise>
                                    <span class="posts-list-meta">
                                        <fmt:formatDate value="${doc.date.time}" type="date" pattern="${dateformat}"/>
                                    </span>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </li>
                </c:forEach>
            </ul>
        </div>
    </div>
</c:if>
