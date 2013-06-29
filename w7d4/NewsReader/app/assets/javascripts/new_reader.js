window.NewReader = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function() {
	  NewReader.feeds = new NewReader.Collections.Feeds();
		NewReader.router = new NewReader.Router($('#content'));
		Backbone.history.start();
  }
};

$(document).ready(function(){
  NewReader.initialize();
});
