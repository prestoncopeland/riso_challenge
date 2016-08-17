$(document).ready(function() {
  $.getJSON("../../../test-users.json", function(data) {
    var registrantList = $("#registrant-list");

    $(data.guests).each(function(index,registrant) {
      registrantList.append($(document.createElement('li')).text(registrant.name + " (" + registrant.email + ")").addClass("list-group-item").attr("id", "list-item-" + index).prepend($(document.createElement('span')).addClass("glyphicon glyphicon-menu-hamburger")).append($(document.createElement('a')).addClass("close").attr("data-dismiss","alert").attr("data-target", "list-item-" + index).text("x")));
    });
  });
  $("#registrant-list").sortable();
});