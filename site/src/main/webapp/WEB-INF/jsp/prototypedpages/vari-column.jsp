<%--

    Copyright 2014 Hippo B.V. (http://www.onehippo.com)

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

<c:set var="pageTitle" value="${hstRequestContext.resolvedSiteMapItem.pageTitle}"/>
<hippo-gogreen:title title="${pageTitle}"/>

<div class="content-wrapper no-container vari-column">
  <c:if test="${not empty pageTitle}">
    <div class="top-title-wrapper">
      <div class="container">
        <div class="row">
          <div class="col-md-12 col-sm-12">
            <div class="page-info">
              <h1 class="h1-page-title">${pageTitle}</h1>

                <%--<h2 class="h2-page-desc"></h2>--%>

              <div class="breadcrumb-container">
                <ol class="breadcrumb">
                  <li>
                    <a href="<hst:link siteMapItemRefId="home"/>">Home</a>
                  </li>
                  <li class="active">${pageTitle}</li>
                </ol>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </c:if>

  <div class="body-wrapper">
    <div class="container">
      <div class="row">
        <div class="col-md-12 col-sm-12">
        <hst:include ref="hero"/>
        </div>
      </div>

      <div class="row">
        <div class="col-md-6 col-sm-6">
          <hst:include ref="left1"/>
        </div>
        <div class="col-md-6 col-sm-6">
          <hst:include ref="right1"/>
        </div>
      </div>

      <div class="row">
        <div class="col-md-9 col-sm-9">
          <hst:include ref="left2"/>
        </div>
        <div class="col-md-3 col-sm-3">
          <hst:include ref="right2"/>
        </div>
      </div>

      <div class="row">
        <div class="col-md-6 col-sm-6">
          <hst:include ref="left3"/>
        </div>
        <div class="col-md-6 col-sm-6">
          <hst:include ref="right3"/>
        </div>
      </div>

      <div class="row">
        <div class="col-md-3 col-sm-3">
          <hst:include ref="left4"/>
        </div>
        <div class="col-md-9 col-sm-9">
          <hst:include ref="right4"/>
        </div>
      </div>

      <div class="row">
        <div class="col-md-3 col-sm-3">
          <hst:include ref="left5"/>
        </div>
        <div class="col-md-6 col-sm-6">
          <hst:include ref="center5"/>
        </div>
        <div class="col-md-3 col-sm-3">
          <hst:include ref="right5"/>
        </div>
      </div>

      <div class="row">
        <div class="col-md-12 col-sm-12">
          <hst:include ref="bottom"/>
        </div>
      </div>
    </div>
  </div>
</div>