$(document).ready(function() {
  $.getJSON("../../../test-users.json", function(data) {
    var registrantList = $("#registrant-list");

    $(data.guests).each(function(index,registrant) {
      registrantList.append($(document.createElement('li')).text(registrant.name + " (" + registrant.email + ")").addClass("list-group-item").attr("id", index).prepend($(document.createElement('span')).addClass("glyphicon glyphicon-menu-hamburger")).append('<form style="margin: 0; padding: 0; display: inline;" action="/' + registrant.email + '" method="post"><input style="display: inline;" type="hidden"' +
        'name="_method" value="delete">' + '<input style="display: inline;" class="close" type="submit" value="x">' +
        '</form>'));
    });
  });

  $("#registrant-list").sortable();
});