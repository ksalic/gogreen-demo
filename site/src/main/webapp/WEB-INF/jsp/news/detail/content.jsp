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
        <h2>
            <c:out value="${document.title}"/>
        </h2>

        <div class="blog-post-body">
            <c:out value="${document.summary}"/>
            <hst:html hippohtml="${document.description}"/>
        </div>

        <div class="blog-post-details">

            <div class="blog-post-details-item blog-post-details-item-left icon-calendar">
                <span class="date"><fmt:formatDate value="${document.date.time}" type="date" pattern="d MMMM, yyyy"/></span>
            </div>

            <div class="blog-post-details-item blog-post-details-item-right">
                <hst:link var="link" siteMapItemRefId="news"/>
                <a href="${link}">
                    <fmt:message key="common.back.overview"/> <i class="fa fa-chevron-right"></i>
                </a>
            </div>

        </div>
    </div>
</div>

<hst:include ref="comments"/>