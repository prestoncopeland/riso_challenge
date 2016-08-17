$(document).ready(function() {
  $.getJSON("../../../test-users.json", function(data) {
    var registrantList = $("#registrant-list");

    $(data.guests).each(function(index,registrant) {
      registrantList.append($(document.createElement('li')).text(registrant.name + " (" + registrant.email + ")").addClass("list-group-item").prepend($(document.createElement('span')).addClass("glyphicon glyphicon-menu-hamburger")).append($(document.createElement('a')).addClass("close").attr("data-dismiss","alert").text("x")));
    });
  });
  $("#registrant-list").sortable();
});