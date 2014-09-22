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

<h1 class="h1-page-title">
    <a href="<hst:link siteMapItemRefId="blogs"/>">Blogs</a>
</h1>

<c:if test="${not empty document}">
    <h2 class="h2-page-desc">
        ${document.title}
    </h2>
</c:if>

<div class="breadcrumb-container">
    <ol class="breadcrumb">
        <li>
            <a href="<hst:link siteMapItemRefId="home"/>"><fmt:message key="news.overview.content.location.home"/></a>
        </li>
        <li class="active"><a href="<hst:link siteMapItemRefId="blogs"/>">Blogs</a></li>
    </ol>
</div>