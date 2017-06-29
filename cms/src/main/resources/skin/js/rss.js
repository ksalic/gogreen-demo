/*
 * Copyright 2012-2017 Hippo B.V. (http://www.onehippo.com)
 */
"use strict";
$(document).ready(function() {
  var location = window.location;
  var path  = location.protocol + "//" + location.host + location.pathname;
  path = path.replace("console/","");
  var randomAuthor = "author" + randomWithZeros(20);
  var randomEditor = "editor" + randomWithZeros(20);
  var randomAdmin = "admin" + randomWithZeros(20);
  $("#RandomAuthor").append(randomAuthor + " - " + randomAuthor);
  $("#RandomEditor").append(randomEditor + " - " + randomEditor);
  $("#RandomAdmin").append(randomAdmin + " - " + randomAdmin);
  fetchFeed(path + "rss/?feed=https://www.bloomreach.com/en/events-rss", "events", 1);
  fetchFeed(path + "rss/?feed=https://www.bloomreach.com/en/news-rss", "news", 1);
  fetchFeed(path + "rss/?feed=https://www.bloomreach.com/en/blogs-rss", "blogs", 3);
});

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

function appendEntry(element, containerId) {
  var container = $("#" + containerId);

  var title = '<h3>' + element.find("title").text() + '</h3>';
  var docDate = '<span>' + element.find("pubDate").text() + '</span>';
  var description = '<p>' + element.find("description").text() + '...</p>';
  var item = '<li><a href="' + element.find("link").text() + '">' + title + docDate + description + '</a></li>';
  container.append(item);
  $("#feeds").show();
}
