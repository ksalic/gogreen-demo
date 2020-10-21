<%--
    Copyright 2020 Hippo B.V. (http://www.onehippo.com)
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
                <div class="col-md-12 col-sm-12">
                    <hst:include ref="content"/>
                </div>
            </div>
        </div>
    </div>
</div>