window.SessionsTemplate = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function() {

		SessionsTemplate.gists = new SessionsTemplate.Collections.Gists();

    SessionsTemplate.gists.fetch();
		var router = new SessionsTemplate.Routers.Gists($("#content"));

		Backbone.history.start();
  }
};

$(document).ready(function(){
  SessionsTemplate.initialize();
});
