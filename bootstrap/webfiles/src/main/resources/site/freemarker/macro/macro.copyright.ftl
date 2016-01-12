<#include "../include/imports.ftl">
<#--
  Copyright 2016 Hippo B.V. (http://www.onehippo.com)
-->
<#macro copyright document>
  <#if document??>

    <#assign copyright=document.copyright/>

    <#if copyright?? && copyright.description?? && copyright.url??>
    <p class="copyright">
      &copy;
    ${copyright.description?html}
      <#if copyright.description?? || copyright.url??><br/></#if><#if copyright.url??><a href="${copyright.url}">${copyright.url?html}</a>
      <#--    <@c.url var="link" value=copyright.url?html/>
          <#if truncate?? && copyright.url?length gt truncate>
            <@c.url var="text" value=copyright.url?substring(truncat?length)+"..."/>
          </#if>
        <#else>
          <@c.url var="text" value=copyright.url/>
          -->
      </#if>
    </p>
    </#if>
  </#if>
</#macro>
