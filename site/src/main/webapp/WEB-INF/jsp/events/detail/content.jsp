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
<%--@elvariable id="document" type="com.onehippo.gogreen.beans.EventDocument"--%>
<%@include file="../../includes/tags.jspf" %>

<hippo-gogreen:title title="${document.title}"/>

<div class="blog-post">

    <div class="blog-post-type">
        <i class="icon-calendar"> </i>
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
            <p><c:out value="${document.summary}"/></p>
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

            <c:if test="${not empty document.location}">
                <input id="address" type="hidden"
                       value="${document.location.street}&nbsp;${document.location.number},&nbsp;${document.location.city}&nbsp;${document.location.postalCode}&nbsp;${document.location.province}"/>
            </c:if>
        </div>
    </div>
</div>