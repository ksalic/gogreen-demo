<!DOCTYPE html>
<#--
  Copyright 2016 Hippo B.V. (http://www.onehippo.com)
-->

<!--[if lt IE 7]>
<html class="no-js lt-ie9 lt-ie8 lt-ie7"> <![endif]-->
<!--[if IE 7]>
<html class="no-js lt-ie9 lt-ie8"> <![endif]-->
<!--[if IE 8]>
<html class="no-js lt-ie9"> <![endif]-->
<!--[if gt IE 8]><!-->
<#assign fmt=JspTaglibs["http://java.sun.com/jsp/jstl/fmt"]>
<#assign hst=JspTaglibs["http://www.hippoecm.org/jsp/hst/core"]>
<#assign ga=JspTaglibs["http://www.onehippo.org/jsp/google-analytics"]>

<@hst.defineObjects />

<#assign lang="${hstRequest.locale.language!}" />

<html class="no-js" lang="${lang}"><!--<![endif]-->
<head>
<@hst.headContributions categoryExcludes="css,jsInternal,jsExternal,scripts,headScripts"/>
    <meta charset="utf-8">
    <!--[if IE]><meta http-equiv='X-UA-Compatible' content='IE=edge,chrome=1'><![endif]-->
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="schema.DC" href="http://purl.org/dc/elements/1.1/" />
    <link rel="schema.DCTERMS" href="http://purl.org/dc/terms/" />
    <meta name="DC.keywords" content="<@fmt.message key="layout.webpage.metadckeywords"/>" />
    <meta name="description" content="<@fmt.message key="layout.webpage.metadescription"/>" />
    <meta name="DC.type" content="webpagina" scheme="DCMIType" />
    <meta name="DCTERMS.issued" content="2009-07-09T10:31" scheme="DCTERMS.W3CDTF" />
    <meta name="DCTERMS.available" content="2009-07-09T10:31" scheme="DCTERMS.W3CDTF" />
    <meta name="DC.title" content="<@fmt.message key="layout.webpage.metadctitle"/>" />
    <meta name="DC.language" content="${lang}" scheme="DCTERMS.RFC3066" />

<@hst.link var="css_revolution" path="/css/revolution_settings.css"/>
    <link rel="stylesheet" href="${css_revolution}">
<@hst.link var="css_bootstrap" path="/css/bootstrap.css"/>
    <link rel="stylesheet" href="${css_bootstrap}">
<@hst.link var="css_font_awesome" path="/css/font-awesome.css"/>
    <link rel="stylesheet" href="${css_font_awesome}">
<@hst.link var="css_axfont" path="/css/axfont.css"/>
    <link rel="stylesheet" href="${css_axfont}">
<@hst.link var="css_tipsy" path="/css/tipsy.css"/>
    <link rel="stylesheet" href="${css_tipsy}">
<@hst.link var="css_prettyPhoto" path="/css/prettyPhoto.css"/>
    <link rel="stylesheet" href="${css_prettyPhoto}">
<@hst.link var="css_isotop_animation" path="/css/isotop_animation.css"/>
    <link rel="stylesheet" href="${css_isotop_animation}">
<@hst.link var="css_animate" path="/css/animate.css"/>
    <link rel="stylesheet" href="${css_animate}">
<@hst.link var="stylecss" path="/css/style.css"/>
    <link href='${stylecss}' rel='stylesheet' type='text/css'>
<@hst.link var="css_responsive" path="/css/responsive.css"/>
    <link href='${css_responsive}' rel='stylesheet' type='text/css'>

    <!--DISABLED
    <script src="https://maps.googleapis.com/maps/api/js?v=3.exp&amp;sensor=false"></script>
    -->

    <!-- Fonts -->
<@hst.link var="fontOpenSans" path="/fonts/open-sans.css"/>
    <link href="${fontOpenSans}" rel='stylesheet' type='text/css'>
<@hst.link var="fontRaleway" path="/fonts/raleway.css"/>
    <link href="${fontRaleway}" rel='stylesheet' type='text/css'>

    <!--[if lt IE 9]>
    <@hst.link var="js_respond" path="/js/respond.js"/>
    <script type="text/javascript" src="${js_respond}"></script>
    <![endif]-->

    <#--DISABLED
        <@hst.link var="yuicss" path="/css/yui-css.css"/>
        <link rel="stylesheet" media="screen" type="text/css" href="${yuicss}"/>

        <@hst.link var="screencss" path="/css/screen.css"/>
        <link rel="stylesheet" media="screen" type="text/css" href="${screencss}"/>
    -->
        <#if loggedin>
        <@hst.link var="resellercss" path="/css/reseller.css"/>
        <link rel="stylesheet" media="screen" type="text/css" href="${resellercss}"/>
        </#if>

<#if hstRequest.requestContext.resolvedMount.mount.channelInfo.themeCss?has_content>
    <@hst.link var="themecss" path="/binaries${hstRequest.requestContext.resolvedMount.mount.channelInfo.themeCss}"/>
    <link rel="stylesheet" media="screen" type="text/css" href="${themecss}"/>
</#if>

<@hst.headContributions categoryIncludes="css"/>

<@hst.link var="jquery" path="/js/jquery-1.9.1.js"/>
    <script src="${jquery}" type="text/javascript"></script>

<@hst.link var="jquerymbbrowser" path="/js/jquery.mb.browser.min.js"/>
    <script src="${jquerymbbrowser}" type="text/javascript"></script>

<@hst.link var="jqueryuicore" path="/js/jquery.ui.core.js"/>
    <script src="${jqueryuicore}" type="text/javascript"></script>

<@hst.link var="jqueryuidatepicker" path="/js/jquery.ui.datepicker.js"/>
    <script src="${jqueryuidatepicker}" type="text/javascript"></script>

<@hst.link var="favicon" path="/images/favicon.ico"/>
    <link rel="icon" href="${favicon}" type="image/x-icon"/>
    <link rel="shortcut icon" href="${favicon}" type="image/x-icon"/>

<@hst.link var="appletouchicon" path="/images/apple-touch-icon.png"/>
    <link rel="apple-touch-icon" href="${appletouchicon}"/>

    <!--[if lt IE 9]>
    <@hst.link var="js_ie_fixes" path="/js/ie-fixes.js"/>
    <script type="text/javascript" src="${js_ie_fixes}"></script>
    <@hst.link var="css_ie_fixes" path="/css/ie-fixes.css"/>
    <link rel="stylesheet" href="${css_ie_fixes}">
    <![endif]-->

    <#--
        <@hst.link var="print" path="/css/print.css"/>
        <link rel="stylesheet" media="print" type="text/css" href="${print}">
        -->

<@hst.link var="rssHref" path="/rss" />
<@fmt.message var="rssTitle" key="standard.header.rss"/>
    <link rel="alternate" type="application/rss+xml" title="${rssTitle}" href="${rssHref}"/>

<@hst.link var="css_color_chooser" path="/css/color-chooser.css" />
    <link rel="stylesheet" href="${css_color_chooser}">

<@hst.headContributions categoryIncludes="headScripts"/>

</head>
<body<#if hstRequest.requestContext.resolvedMount.mount.channelInfo.boxed> class="bgpattern-${hstRequest.requestContext.resolvedMount.mount.channelInfo.boxedPattern}"</#if>>

<div id="wrapper"<#if hstRequest.requestContext.resolvedMount.mount.channelInfo.boxed> class="boxed"</#if>>
    <div class="top_wrapper">
    <@hst.include ref="header"/>
    </div>

    <!-- body / main -->
<@hst.include ref="main"/>

    <!-- footer -->
<@hst.include ref="footer"/>
</div>

<@hst.headContributions categoryIncludes="jsExternal"/>
<@hst.headContributions categoryIncludes="jsInternal"/>
<#if !preview>
    <@ga.accountId/>
    <@hst.link var="googleAnalytics" path="/resources/google-analytics.js"/>
<script src="${googleAnalytics}" type="text/javascript"></script>
</#if>

<@hst.link var="js_jqueryplaceholder" path="/js/_jquery.placeholder.js"/>
<script type="text/javascript" src="${js_jqueryplaceholder}"></script>
<@hst.link var="js_activeaxon_menu" path="/js/activeaxon_menu.js"/>
<script src="${js_activeaxon_menu}" type="text/javascript"></script>
<@hst.link var="js_bootstrap" path="/js/bootstrap.min.js"/>
<script src="${js_bootstrap}" type="text/javascript"></script>
<@hst.link var="js_jqappear" path="/js/jq.appear.js"/>
<script src="${js_jqappear}" type="text/javascript"></script>
<@hst.link var="js_jquerybase64" path="/js/jquery.base64.js"/>
<script src="${js_jquerybase64}" type="text/javascript"></script>
<@hst.link var="js_jquerycarouFredSel" path="/js/jquery.carouFredSel-6.2.1-packed.js"/>
<script src="${js_jquerycarouFredSel}" type="text/javascript"></script>
<@hst.link var="js_jquerycycle" path="/js/jquery.cycle.js"/>
<script src="${js_jquerycycle}" type="text/javascript"></script>
<@hst.link var="js_jquerycycle2carousel" path="/js/jquery.cycle2.carousel.js"/>
<script src="${js_jquerycycle2carousel}" type="text/javascript"></script>
<@hst.link var="js_jqueryeasing" path="/js/jquery.easing.1.3.js"/>
<script src="${js_jqueryeasing}" type="text/javascript"></script>
<@hst.link var="js_jqueryeasytabs" path="/js/jquery.easytabs.js"/>
<script src="${js_jqueryeasytabs}" type="text/javascript"></script>
<@hst.link var="js_jqueryinfinitescroll" path="/js/jquery.infinitescroll.js"/>
<script src="${js_jqueryinfinitescroll}" type="text/javascript"></script>
<@hst.link var="js_jqueryisotope" path="/js/jquery.isotope.js"/>
<script src="${js_jqueryisotope}" type="text/javascript"></script>
<@hst.link var="js_jqueryprettyPhoto" path="/js/jquery.prettyPhoto.js"/>
<script src="${js_jqueryprettyPhoto}" type="text/javascript"></script>
<@hst.link var="js_jQueryscrollPoint" path="/js/jQuery.scrollPoint.js"/>
<script src="${js_jQueryscrollPoint}" type="text/javascript"></script>
<@hst.link var="js_jquerythemepunch" path="/js/jquery.themepunch.plugins.min.js"/>
<script src="${js_jquerythemepunch}" type="text/javascript"></script>
<@hst.link var="js_jquerythemepunchrevolution" path="/js/jquery.themepunch.revolution.js"/>
<script src="${js_jquerythemepunchrevolution}" type="text/javascript"></script>
<@hst.link var="js_jquerytipsy" path="/js/jquery.tipsy.js"/>
<script src="${js_jquerytipsy}" type="text/javascript"></script>
<@hst.link var="js_jqueryvalidate" path="/js/jquery.validate.js"/>
<script src="${js_jqueryvalidate}" type="text/javascript"></script>
<@hst.link var="js_jQueryXDomainRequest" path="/js/jQuery.XDomainRequest.js"/>
<script src="${js_jQueryXDomainRequest}" type="text/javascript"></script>
<@hst.link var="js_kanzi" path="/js/kanzi.js"/>
<script src="${js_kanzi}" type="text/javascript"></script>

<@hst.headContributions categoryIncludes="scripts"/>
</body>
</html>
