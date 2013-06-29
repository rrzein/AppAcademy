App.Views.PostShowView = Backbone.View.extend({
	initialize: function() {
		this.$el.addClass('background');
		var $errors = $('<div>').addClass('errors');
		this.$el.html($errors);
	},

	events: {
		'dblclick .editable': 'editField',
		'blur input': 'submitField'
	},

	render: function() {
		var renderedContent = JST['showPost']({ post: this.model });
		this.$el.html(renderedContent);
		return this;
	},

	editField: function(event) {
		var $field = $(event.target);
		var value = $field.text();
		var $input = $('<input>').val(value)
														 .attr({
															 'type': 'text',
															 'name': $field.attr('id')});
	  $field.replaceWith($input);
		$('.editable').removeClass('editable');
	},

	submitField: function(event) {
		var that = this;
		var input = $('input');
		var name = input.attr('name');
		var value = input.val();
		var attrs = {}; // can't say { name: value }
		attrs[name] = value;
		this.model.save(attrs, {
			url: this.model.url + this.model.id,
			error: function(model, xhr, options) {
				var $error = $('<p>').text('Failed to save')
				that.$el.find('#errors').html($error);
			},
			success: function(model, response, options) {
				that.render();
			}
		});
	}
});