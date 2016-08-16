$(document).ready(function() {
  $.getJSON("assets/js/test-users.json", function(data) {
    var registrantList = $("#registrant-list");

    $(data.guests).each(function(index,registrant) {
      registrantList.append($(document.createElement('li')).text(registrant.name + " (" + registrant.email + ")").addClass("list-group-item").prepend($(document.createElement('span')).addClass("glyphicon glyphicon-menu-hamburger")));
    });
  });
  $("#registrant-list").sortable();
});