<#assign hst=JspTaglibs["http://www.hippoecm.org/jsp/hst/core"]>
<#--
  Copyright 2016 Hippo B.V. (http://www.onehippo.com)
-->

<@hst.defineObjects/>

<#assign lang=hstRequest.locale.language/>
<@hst.link var="linkHome" siteMapItemRefId="home"/>

<#if Request.logo??>
<div class="col-xs-2 logo">
  <@hst.link var="imgLogo" hippobean=Request.logo.original />
  <a href="${linkHome}"><img src="${imgLogo}" alt="${Request.logo.alt!''}" height="${Request.logo.original.height}"/></a>
</div>
</#if>