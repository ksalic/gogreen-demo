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

<%@include file="../includes/tags.jspf" %>
<hst:defineObjects/>

<div class="section-content section-tabs section-px stones-bg white-text">
    <c:choose>
        <c:when test="${preview}">
            <c:set var="cssClass">tab-container-preview</c:set>
        </c:when>
        <c:otherwise>
            <c:set var="cssClass">tab-container</c:set>
        </c:otherwise>
    </c:choose>
    <div class="${cssClass}">
        <div class="section-tab-arrow"></div>
        <div class="section-etabs-container">
            <ul class="section-etabs">
                <c:forEach items="${hstResponseChildContentNames}" var="childContentName" varStatus="index">
                    <li class="tab active">
                        <a href="#tabc${index.count}">News</a>
                    </li>
                </c:forEach>
            </ul>
        </div>
        <div class="container">
            <div class="tab-content hst-container">
                <!-- intro -->
                <c:forEach items="${hstResponseChildContentNames}" var="childContentName" varStatus="index">
                    <div id="tabc${index.count}" class="hst-container-item">
                        <hst:include ref="${childContentName}"/>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>
</div>