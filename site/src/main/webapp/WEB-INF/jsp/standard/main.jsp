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

<div class="content-wrapper">
    <div class="hero-wrapper">
        <hst:include ref="hero"/>
    </div>
    <div class="top-title-wrapper">
        <div class="container">
            <div class="row">
                <div class="col-md-12 col-sm-12">
                    <div class="page-info">
                        <hst:include ref="top"/>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="body-wrapper">
        <div class="container">
            <div class="row">
                <div class="col-md-9 col-sm-9">
                    <hst:include ref="content"/>
                </div>

                <div class="col-md-3 col-sm-3">
                    <hst:include ref="right"/>
                </div>
            </div>
        </div>
    </div>
</div>
