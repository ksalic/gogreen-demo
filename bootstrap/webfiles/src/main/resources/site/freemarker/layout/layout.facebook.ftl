<!DOCTYPE html>
<#--
  Copyright 2016 Hippo B.V. (http://www.onehippo.com)
-->

<#assign fmt=JspTaglibs["http://java.sun.com/jsp/jstl/fmt"]>
<#assign hst=JspTaglibs["http://www.hippoecm.org/jsp/hst/core"]>
<#assign ga=JspTaglibs["http://www.onehippo.org/jsp/google-analytics"]>

<@hst.defineObjects />

<#assign lang="${hstRequest.locale.language!}" />

<html lang="${lang}" xmlns:fb="http://ogp.me/ns/fb#">
  <head>
  <@hst.headContributions categoryExcludes="css,jsInternal,jsExternal"/>
    <meta charset="utf-8">
    <link rel="schema.DC" href="http://purl.org/dc/elements/1.1/"/>
    <link rel="schema.DCTERMS" href="http://purl.org/dc/terms/"/>
    <meta name="DC.keywords" content="<@fmt.message key="layout.webpage.metadckeywords"/>"/>
    <meta name="description" content="<@fmt.message key="layout.webpage.metadescription"/>"/>
    <meta name="DC.type" content="webpagina" scheme="DCMIType"/>
    <meta name="DCTERMS.issued" content="2009-07-09T10:31" scheme="DCTERMS.W3CDTF"/>
    <meta name="DCTERMS.available" content="2009-07-09T10:31" scheme="DCTERMS.W3CDTF"/>
    <meta name="DC.title" content="<@fmt.message key="layout.webpage.metadctitle"/>"/>
    <meta name="DC.language" content="${lang}" scheme="DCTERMS.RFC3066"/>

  <@hst.link var="yuicss" path="/css/yui-css.css"/>
    <link rel="stylesheet" media="screen" type="text/css" href="${yuicss}"/>

  <@hst.link var="stylecss" path="/css/style.css"/>
    <link rel="stylesheet" media="screen" type="text/css" href="${stylecss}"/>

  <@hst.link var="screencss" path="/css/facebook/screen.css"/>
    <link rel="stylesheet" media="screen" type="text/css" href="${screencss}"/>

  <@hst.headContributions categoryIncludes="css"/>

  <@hst.link var="jquery" path="/js/jquery-1.4.2.min.js"/>
    <script src="${jquery}" type="text/javascript"></script>

  <@hst.link var="favicon" path="/images/favicon.ico"/>
    <link rel="icon" href="${favicon}" type="image/x-icon"/>
    <link rel="shortcut icon" href="${favicon}" type="image/x-icon"/>

  <@hst.link var="appletouchicon" path="/images/apple-touch-icon.png"/>
    <link rel="apple-touch-icon" href="${appletouchicon}"/>

    <!--[if lte IE 7]>
    <@hst.link var="ie7css" path="/css/ie7.css"/>
    <link rel="stylesheet" media="screen" type="text/css" href="${ie7css}">
    <script type="text/javascript">ie7 = true;</script>
    <![endif]-->

  <@hst.link var="rssHref" path="/rss" />
  <@fmt.message var="rssTitle" key="standard.header.rss"/>
    <link rel="alternate" type="application/rss+xml" title="${rssTitle}" href="${rssHref}"/>

  </head>
  <body <#if preview>class="facebook-preview"</#if>>
    <div id="fb-root"></div>
    <script>(function (d, s, id) {
      var js, fjs = d.getElementsByTagName(s)[0];
      if (d.getElementById(id)) return;
      js = d.createElement(s);
      js.id = id;
      js.src = "//connect.facebook.net/${hstRequest.locale}/all.js#xfbml=1";
      fjs.parentNode.insertBefore(js, fjs);
    }(document, 'script', 'facebook-jssdk'));</script>
    <!-- document wrapper -->

    <div id="topbar">
      <div class="wrapper"></div>
    </div>
    <div id="header"></div>

  <@hst.include ref="main"/>

  <@hst.include ref="footer"/>
    <div id="ft-disclaimer">
    <@fmt.message key="layout.webpage.disclaimer">
      <@fmt.param><a href="http://www.onehippo.com/en/why-hippo-cms"></@fmt.param>
      <@fmt.param><a href="https://issues.onehippo.com/browse/GOGREEN"></@fmt.param>
      <@fmt.param></a></@fmt.param>
    </@fmt.message>
    </div>

  <@hst.headContributions categoryIncludes="jsExternal"/>
  <@hst.headContributions categoryIncludes="jsInternal"/>
  <#if !Request.preview>
    <@ga.accountId/>
    <@hst.link var="googleAnalytics" path="/resources/google-analytics.js"/>
    <script src="${googleAnalytics}" type="text/javascript"></script>
  </#if>
  </body>
</html>