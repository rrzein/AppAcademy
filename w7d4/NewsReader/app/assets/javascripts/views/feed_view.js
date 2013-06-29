NewReader.Views.Feed = Backbone.View.extend({

	initialize: function() {
		var that = this;
		var actions = ["add", "change", "remove"];
		_(actions).each(function(action) {
			that.listenTo(that.model, action, that.render);
			that.listenTo(that.collection, action, that.render);
		});
	},

	events: {
		"click button.refresh": "reload"
	},

	render: function() {
		var renderedContent = JST['feed_view']({
			feed: this.model,
			entries: this.collection,
		});
		this.$el.html(renderedContent);
		return this;
	},

	reload: function() {
		this.model.reload();
		return this;
	}

})