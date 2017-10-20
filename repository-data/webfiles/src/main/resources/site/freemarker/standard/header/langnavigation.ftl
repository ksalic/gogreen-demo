<#include "../../include/imports.ftl">
<#--
  Copyright 2016 Hippo B.V. (http://www.onehippo.com)
-->
<@hst.setBundle basename="messages,typenames"/>

<!-- lang navigation -->
<div class="col-sm-6 langnav">
  <nav>
    <ul class="" id="language">

      <li class="active">
        <i class="fa fa-ellipsis-h"></i> <span><@fmt.message key="standard.header.langnav.language.${Request.currentLocale}"/></span>
        <#if Request.translations??>
          <ul>
            <#list Request.translations as translation>
              <@hst.link var="link" link=translation.link/>
              <#assign title>
                <@fmt.message key="standard.header.langnav.language.${translation.language}"/>
              </#assign>
              <li>
                <a href="${link}">
                  ${title}
                </a>
              </li>
            </#list>
          </ul>
        </#if>
      </li>
    </ul>
  </nav>
</div>
