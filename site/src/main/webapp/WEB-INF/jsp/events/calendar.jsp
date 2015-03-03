<%--

    Copyright 2010-2013 Hippo B.V. (http://www.onehippo.com)

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

            http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.

--%>

<%@include file="../includes/tags.jspf" %>
<jsp:useBean id="now" class="java.util.Date" />

<div class="sidebar-block">
    <div class="sidebar-content calendar">
        <h2><fmt:message key="events.calendar.title"/></h2>
        <div class="navigation">
            <nav>
                <h4><c:out value="${calendar.monthName}"/>&nbsp;<c:out value="${calendar.year}"/></h4>
                <hst:link var="prev">
                    <hst:param name="month" value="${calendar.prevMonth}"/>
                    <hst:param name="year" value="${calendar.prevMonthYear}"/>
                </hst:link>
                <span class="nav prev">
                    <a href="${prev}">
                        <i class="icon-arrow-left"></i>
                        <fmt:message key="events.calendar.previous"/>
                    </a>
                </span>
                <hst:link var="next">
                    <hst:param name="month" value="${calendar.nextMonth}"/>
                    <hst:param name="year" value="${calendar.nextMonthYear}"/>
                </hst:link>
                <span class="nav next">
                    <a href="${next}">
                        <fmt:message key="events.calendar.next"/>
                        <i class="icon-arrow-right"></i>
                    </a>
                </span>
            </nav>
        </div>
        <table class="table">
            <thead>
                  <tr>
                      <th><fmt:message key="events.calendar.monday"/></th>
                      <th><fmt:message key="events.calendar.tuesday"/></th>
                      <th><fmt:message key="events.calendar.wednesday"/></th>
                      <th><fmt:message key="events.calendar.thursday"/></th>
                      <th><fmt:message key="events.calendar.friday"/></th>
                      <th><fmt:message key="events.calendar.saturday"/></th>
                      <th><fmt:message key="events.calendar.sunday"/></th>
                  </tr>
            </thead>
            <c:forEach var="week" items="${calendar.weeks}">
                <tr>
                    <c:forEach var="day" items="${week.days}">
                        <c:choose>
                            <c:when test="${day.dummy}"><td class="disabled"></td></c:when>
                            <c:when test="${day.numberOfEvents > 0}">
                                <td class="event box">
                                    <a href="#" rel="<c:out value="${day.dayOfMonth}"/>">
                                        <c:out value="${day.dayOfMonth}"/>
                                        <i class="icon-pinboard"></i>
                                    </a>
                                </td>
                            </c:when>
                            <c:otherwise><td><c:out value="${day.dayOfMonth}"/></td></c:otherwise>
                        </c:choose>
                    </c:forEach>
                </tr>
            </c:forEach>
        </table>
    </div>
</div>

<c:forEach var="week" items="${calendar.weeks}">
    <c:forEach var="day" items="${week.days}">
        <c:choose>
            <c:when test="${day.dummy}"><td class="disabled"></td></c:when>
            <c:when test="${day.numberOfEvents > 0}">
                <div class="sidebar-block calendar-item day-<c:out value="${day.dayOfMonth}"/>">
                    <h3 class="h3-sidebar-title sidebar-title">
                        <c:out value="${day.dayOfMonth}"/>&nbsp;<c:out value="${calendar.monthName}"/>&nbsp;<c:out value="${calendar.year}"/>
                    </h3>
                    <div class="sidebar-content">
                        <ul class="posts-list">
                            <c:forEach var="event" items="${day.events}" begin="0" end ="1">
                                <li>
                                    <hst:link var="eventLink" hippobean="${event}" />
                                    <div class="posts-list-thumbnail">
                                        <a href="${eventLink}">
                                            <img src="<hst:link hippobean="${event.firstImage.smallThumbnail}"/>" alt="${doc.firstImage.alt}" class="img-responsive" width="54"/>
                                        </a>
                                    </div>
                                    <div class="posts-list-content">
                                        <a href="${eventLink}"><c:out value="${event.title}"/></a>
                                    </div>
                                </li>
                            </c:forEach>
                        </ul>
                    </div>
                </div>
            </c:when>
        </c:choose>
    </c:forEach>
</c:forEach>

<script text="text/javascript">
    // Hide all calendar items on load
    $(".calendar-item").hide();

    // Show calendar items on hover
    $(".calendar .event a").hover(function() {
        var day = $(this).attr('rel');
        var $events = $(".calendar-item.day-" + day);
        if($events.length > 0 && !$events.hasClass('visible')){
          $(".calendar-item").hide().removeClass('visible');
          $events.fadeIn();
          $events.addClass('visible');
        }
    });

    // Toggle calendar items on click
    $(".calendar .event a").click(function() {
        event.preventDefault();
    });
</script>