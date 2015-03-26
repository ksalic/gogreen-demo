<%--

    Copyright 2010-2013 Hippo B.V. (http://www.onehippo.com)

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

<%@include file="../../includes/tags.jspf" %>

<div class="blog-post">

    <div class="blog-post-type">
        <i class="icon-news"> </i>
    </div>

    <div class="blog-span">
        <hst:cmseditlink hippobean="${document}" />
        <c:set var="image" value="${document.firstImage}"/>
        <c:if test="${image != null and image.landscapeImage != null}">
            <div class="blog-post-featured-img img-overlay">
                <hst:link var="src" hippobean="${image.landscapeImage}"/>
                <hst:link var="imgOrig" hippobean="${image.original}"/>
                <img class="img-responsive" src="${src}" alt="${fn:escapeXml(image.alt)}"/>
                <hippo-gogreen:imagecopyright image="${image}"/>

                <div class="item-img-overlay">
                    <a class="portfolio-zoom icon-zoom-in" href="${imgOrig}" data-rel="prettyPhoto[portfolio]" title="${fn:escapeXml(image.alt)}"></a>
                </div>
            </div>
        </c:if>

        <h2>
            <c:out value="${document.title}"/>
        </h2>

        <div class="blog-post-body">
            <c:out value="${document.summary}"/>
            <hst:html hippohtml="${document.description}"/>
            <hippo-gogreen:copyright document="${document}"/>
        </div>

        <div class="blog-post-details">

            <div class="blog-post-details-item blog-post-details-item-left icon-calendar">
                <span class="date"><fmt:formatDate value="${document.date.time}" type="date" pattern="d MMMM, yyyy"/></span>
            </div>

            <%--<div class="blog-post-details-item blog-post-details-item-left blog-post-details-tags icon-files">
                <a href="">
                    Business
                </a> ,
                <a href="">
                    Investment
                </a> ,
                <a href="">
                    Freelancing
                </a>
            </div>--%>

            <div class="blog-post-details-item blog-post-details-item-left blog-post-details-item-last icon-comment">
                <c:choose>
                    <c:when test="${commentCount gt 0}">
                        <c:out value="${commentCount}"/>&nbsp;<fmt:message key="news.detail.content.commentsfound"/>
                        <c:if test="${commentCount gt 1}"><fmt:message key="news.detail.content.commentsplural"/></c:if>
                    </c:when>
                    <c:otherwise>
                        <fmt:message key="news.detail.content.nocomments"/>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
        <!-- If there are any tags for this document, then display them with links -->
        <c:if test="${!empty document.tags}">
            <hst:setBundle basename="general.text"/>
            
            <div class="tags">

                <c:forEach var="tag" items="${document.tags}"> 
                    <hst:link siteMapItemRefId="search-faceted" var="link"/>
                    <fmt:message key="search.facet.tags" var="tagname" />
                    <a href="${link}/${tagname}/${tag}">${tag}</a>
                </c:forEach>

            </div>
        </c:if>
    </div>
</div>
<hst:include ref="comments"/>