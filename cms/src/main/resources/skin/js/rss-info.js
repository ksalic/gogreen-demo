/*
 * Copyright 2012-2017 Hippo B.V. (http://www.onehippo.com)
 */
"use strict";
$(document).ready(function() {
  var addRandom = true;
  var randomAuthor = "author" + (addRandom ? randomWithZeros(20) : '');
  var randomEditor = "editor" + (addRandom ? randomWithZeros(20) : '');
  var randomAdmin = "admin" + (addRandom ? randomWithZeros(20) : '');
  $("#RandomAuthor").append(randomAuthor + " - " + randomAuthor);
  $("#RandomEditor").append(randomEditor + " - " + randomEditor);
  $("#RandomAdmin").append(randomAdmin + " - " + randomAdmin);
  function randomWithZeros(upperLimit) {
    var randomNumber = Math.ceil(Math.random() * upperLimit);
    return (randomNumber < 10) ? "0" + randomNumber : "" + randomNumber;
  }
  function fetchFeed(feed, name, limit) {
    $.ajax(feed, {
      accepts: {
        xml: "application/rss+xml"
      },
      dataType: "xml",
      success: function(data) {
        var counter = 0;
        $(data).find("item").each(function() {
          if (counter < limit) {
            appendEntry($(this), name);
            counter++;
          }
        });
      },
      error: function() {
        $("#" + name).hide();
      }
    });
  }
  fetchFeed("rss/?feed=http://www.onehippo.com/en/events-rss", "events", 1);
  fetchFeed("rss/?feed=http://www.onehippo.com/en/news-rss", "news", 1);
  fetchFeed("rss/?feed=http://www.onehippo.com/en/blogs-rss", "blogs", 3);
});
function appendEntry(el, containerId) {
  var container = $("#" + containerId);

  var title = '<h3>' + el.find("title").text() + '</h3>';
  var docDate = '<span>' + el.find("pubDate").text() + '</span>';
  var description = '<p>' + el.find("description").text() + '...</p>';
  var item = '<li><a href="' + el.find("link").text() + '">' + title + docDate + description + '</a></li>';
  container.append(item);
  $("#feeds").show();
}
