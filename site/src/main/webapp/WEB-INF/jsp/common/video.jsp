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


<div class="container">
  <div class="row video">
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

  <c:choose>
    <c:when test="${preview && empty videoURL}">
      <h2 class="not-configured">Click to configure Video component</h2>
    </c:when>
    <c:otherwise>
      <iframe width="560" height="315" src="https://www.youtube.com/embed/${videoURL}" frameborder="0" allowfullscreen></iframe>
    </c:otherwise>
  </c:choose>
  </div>
</div>