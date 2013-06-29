SessionsTemplate.Routers.Gists = Backbone.Router.extend({
  routes: {
  	"": "index",
		"gists/new": "new",
		"gists/:id": "detail",
  },

	initialize: function($rootEl) {
		this.$rootEl = $rootEl;
	},

	index: function() {
    var index = new SessionsTemplate.Views.GistsIndex({ collection: 								SessionsTemplate.gists });

    this.$rootEl.html(index.render().$el);
	},

	new: function() {
		var form = new SessionsTemplate.Views.GistForm();
		this.$rootEl.html(form.render().$el);
	}

});
