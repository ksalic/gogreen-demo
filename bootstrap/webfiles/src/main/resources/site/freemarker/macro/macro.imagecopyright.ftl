<#include "../include/imports.ftl">
<#--
  Copyright 2016 Hippo B.V. (http://www.onehippo.com)
-->
<#macro imageCopyright image>

  <#if image??>
    <#assign copyright=image.copyright/>
    <#if copyright?? && copyright.description?? && copyright.url??>
    <p class="copyright">
      &copy;
    ${copyright.description}
      <#if copyright.description?? || copyright.url??><br/></#if>
      <#if copyright.url??>
      <#-- <@c.url var="link" value=copyright.url/>-->
        <a href="${copyright.url}">
        ${copyright.url}
        </a>
      </#if>
    </p>
    </#if>
  </#if>
</#macro>
