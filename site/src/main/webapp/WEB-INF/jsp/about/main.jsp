<%--

    Copyright 2010-2013 Hippo B.V. (http://www.onehippo.com)

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
                <div class="col-md-3 col-sm-3">
                    <hst:include ref="left"/>
                </div>
                <div class="col-md-1 col-sm-1"></div>
                <div class="col-md-8 col-sm-8">
                    <hst:include ref="content"/>
                </div>
            </div>
        </div>
    </div>
</div>
