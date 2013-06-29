NewReader.Views.FeedsIndex = Backbone.View.extend({
	initialize: function() {
		this.listenTo(this.collection, "add", this.render);
	},

	template: JST['feeds_index'],

	className: "feeds",

	events: {
		"click input[type=submit]": "create"
	},

	render: function() {
		var renderedContent = this.template({feeds: this.collection});
		this.$el.html(renderedContent);
		return this;
	},

	create: function(event) {
		event.preventDefault();
		console.log($(event.target.form));
		var attrs = $(event.target.form).serializeJSON();
		this.collection.create(attrs, {wait: true});
	}

})