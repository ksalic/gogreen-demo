<#-- @ftlvariable name="pageable" type="org.onehippo.cms7.essentials.components.paging.Pageable" -->
<#include "../include/imports.ftl">
<#if Request.pageable??>
<ul class="pagination">
    <li class="disabled"><a href="#">${Request.pageable.total} document(s)</a></li>
  <#if Request.pageable.totalPages gt 1>
    <#list Request.pageable.pageNumbersArray as pageNr>
        <@hst.renderURL var="pageUrl">
            <@hst.param name="page" value="${pageNr}"/>
            <@hst.param name="pageSize" value="${Request.pageable.pageSize}"/>
        </@hst.renderURL>
        <#if (pageNr_index==0 && Request.pageable.previous)>
            <@hst.renderURL var="pageUrlPrevious">
                <@hst.param name="page" value="${Request.pageable.previousPage}"/>
                <@hst.param name="pageSize" value="${Request.pageable.pageSize}"/>
            </@hst.renderURL>
            <li><a href="${pageUrlPrevious}">previous</a></li>
        </#if>
        <#if Request.pageable.currentPage == pageNr>
            <li class="active"><a href="#">${pageNr}</a></li>
        <#else >
            <li><a href="${pageUrl}">${pageNr}</a></li>
        </#if>

        <#if !pageNr_has_next && Request.pageable.next>
            <@hst.renderURL var="pageUrlNext">
                <@hst.param name="page" value="${Request.pageable.nextPage}"/>
                <@hst.param name="pageSize" value="${Request.pageable.pageSize}"/>
            </@hst.renderURL>
            <li><a href="${pageUrlNext}">next</a></li>
        </#if>
    </#list>
  </#if>
</ul>
</#if>