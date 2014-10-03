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

<c:if test="${fn:length(items) gt 0}">

    <c:choose>
        <c:when test="${fn:length(items) eq 1}">
            <c:set var="colSize" value="12"/>
        </c:when>
        <c:when test="${fn:length(items) eq 2}">
            <c:set var="colSize" value="6"/>
        </c:when>
        <c:when test="${fn:length(items) eq 3}">
            <c:set var="colSize" value="4"/>
        </c:when>
        <c:when test="${fn:length(items) eq 4}">
            <c:set var="colSize" value="3"/>
        </c:when>
    </c:choose>

    <div class="container">
    <c:if test="${not empty title}">
        <div class="row">
            <div class="col-md-12 col-sm-12">
                <h2 class="h2-section-title"><c:out value="${title}"/></h2>
                <c:if test="${not empty icon}">
                    <div class="i-section-title">
                        <i class="fa <c:out value="${icon}"/>"></i>
                    </div>
                </c:if>
            </div>
        </div>
    </c:if>

            <div class="row latest-items">
                <c:forEach items="${items}" var="item">
                    <div class="col-md-${colSize} col-sm-${colSize}">
                        <hst:cmseditlink hippobean="${item}"/>
                        <div class="feature">
                            <%--<c:if test="${not empty item.firstImage}">
                              <div class="feature-image">
                                  <img src="<hst:link hippobean="${item.firstImage.largeThumbnail}"/>" alt="${item.firstImage.alt}">
                              </div>
                            </c:if>--%>

                            <div class="feature-content">
                                <h3 class="h3-body-title blog-title">
                                    <a href="<hst:link hippobean="${item}"/>"><c:out value="${item.title}"/></a>
                                </h3>
                                <p>
                                    <c:out value="${item.summary}"/>
                                </p>

                            </div>

                            <div class="feature-details">
                                <i class="icon-calendar"></i>
                                <span><fmt:formatDate value="${item.date.time}" pattern="MMMM d, YYY"/></span>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>

    <c:if test="${separatorBorderTop}">
        <c:set var="cssClass"> border-top</c:set>
    </c:if>
    <c:if test="${separatorBorderBottom}">
        <c:set var="cssClass">${cssClass} border-bottom</c:set>
    </c:if>
    <c:if test="${not empty separatorMargin or not empty cssClass}">
        <div class="space-sep<c:out value="${separatorMargin} ${cssClass}"/>"></div>
    </c:if>
</c:if>