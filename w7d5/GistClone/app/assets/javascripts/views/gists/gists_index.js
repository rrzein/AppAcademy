SessionsTemplate.Views.GistsIndex = Backbone.View.extend({

  template: JST['gists/index'],

	tagName: "ul",

	events: {
		"click .form": "renderForm",
	},

  initialize: function() {
		var that = this;
		console.log(that.collection);
		var events = ["sync", "add", "remove", "change"];
		_(events).each(function(e) {
	    that.listenTo(that.collection, e, that.render);
		});
  },

	render: function() {
		var that = this;
		var renderedContent = that.template({ gists: that.collection });
		that.$el.html(renderedContent);

		that.collection.each(function(gist) {
			var gistContent = new SessionsTemplate.Views.GistDetail({ model: gist });
			that.$el.append(gistContent.render().$el);
		});
		var $link = $("<a>", {href: "/#/gists/new", text: "Create form", class: "form"});
		console.log($link);
		that.$el.append($link);
		return that;
	},

});
