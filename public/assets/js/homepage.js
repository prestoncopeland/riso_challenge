$(document).ready(function() {
  $.getJSON("assets/js/test-users.json", function(data) {
    var registrantList = $("#registrant-list");
    $(data.guests).each(function(index, registrant) {
      registrantList.append($(document.createElement('li')).text(registrant.name));
    });
  });
  $("#registrant-list").sortable();
});