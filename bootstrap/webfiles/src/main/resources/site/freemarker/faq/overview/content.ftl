<#include "../../include/imports.ftl">
<#--
  Copyright 2016 Hippo B.V. (http://www.onehippo.com)
-->

<#-- @ftlvariable name="documents" type="java.util.List -->
<#if documents??>
<ul id="questions" class="list-group">
   <#-- @ftlvariable name="document" type="org.hippoecm.hst.content.beans.standard.HippoDocumentBean" -->
    <#list documents as document>
        <li class="list-group-item">
        <@hst.cmseditlink hippobean=document/>
        <h3>${document.question?html}</h3>
        <div><@hst.html hippohtml=document.answer/></div>
        </li>
    </#list>
</ul>
</#if>