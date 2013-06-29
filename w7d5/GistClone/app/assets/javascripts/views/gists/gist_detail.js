SessionsTemplate.Views.GistDetail = Backbone.View.extend({
	template: JST['gists/detail'],

	tagName: "li",

	className: "gist-detail",

	events: {
		"click .favorite": "favorite",
		"click .unfavorite": "unfavorite",
	},

  initialize: function() {
		var that = this;

		var events = ["sync", "add", "remove", "change"];
		_(events).each(function(e) {
	    that.listenTo(that.model, e, that.render);
		});
  },

	render: function() {
    var renderedContent = this.template({ gist: this.model });
		this.$el.html(renderedContent);
		return this;
	},

	favorite: function(event) {
    var that = this;
    var id = $(event.target).data("id");

		var favorite = new SessionsTemplate.Models.Favorite();

		favorite.save({ gist_id:id }, { wait: true,
		url: "/gists/" + id + "/favorite",
		success: function() {
			console.log("favorite created");
		} });

    return this;
	},

	unfavorite: function(event) {
		var that = this;
		var id = $(event.target).data("id");
		var favorite = this.model.attributes.favorites;
		console.log(favorite);

		favorite.destroy({ wait: true,
		success: function() {
			console.log("unfavorited");
		},
		error: function(model, xhr, options) {
			console.log(model);
			console.log(xhr);
			console.log(options);
		}});

		return this;
	},

});