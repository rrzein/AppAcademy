// dynamically inject creepy Andy Warhol photo
$("#content").append('<img src="http://upload.wikimedia.org/wikipedia/commons/2/2b/Andy_Warhol_by_Jack_Mitchell.jpg">');

function addElvis () {
  // a little too much Elvis
  $("#content").append('<img src="http://upload.wikimedia.org/wikipedia/en/b/be/Eight_Elvises.jpg">');
}

// repeatedly call addElvis once every second.
window.setInterval(addElvis, 1000);