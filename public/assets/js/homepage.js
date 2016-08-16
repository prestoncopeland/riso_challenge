$(document).ready(function() {
  $.getJSON("assets/js/test-users.json", function(data) {
    var registrantList = []
    var registrants = data.guests;
    $.each( registrants, function(i, registrant) {
        registrantList.push( "<li id='registrant-" + i + "'>" + registrant.name + "</li>" );
      });

    $("<ul/>", { "class": "registrant-list", html: registrantList}).appendTo( ".registrants" );
  });
});