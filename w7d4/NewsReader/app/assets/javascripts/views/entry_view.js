NewReader.Views.Entry = Backbone.View.extend({
	template: JST['entry'],

	render: function() {
		var renderedContent = this.template({entry: this.model});
		this.$el.html(renderedContent);
		return this;
	}

})