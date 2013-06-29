App.Views.NewPostView = Backbone.View.extend({
	render: function() {
		var renderedContent = JST['new_post']({ post: this.model });
		this.$el.html(renderedContent);
		return this;
	},

	events: {
		'click #newPostButton': 'createPost'
	},

	createPost: function(event) {
		console.log(event);
		var postParams = $(event.target.form).serializeJSON();
		this.model.save(postParams, {wait: true,
			url: this.model.url + this.model.escape('id'),
			success: function(model, response) {
				App.Store.posts.add(model);
				App.Store.router.navigate("posts/" + model.attributes.id, true);
			},
			error: function(model, response) {
				var title = model.attributes.post.title;
				var body = model.attributes.post.body;
				var errors = JSON.parse(response.responseText).errors;

				$('#post_title').val(title);
				$('#post_body').val(body);
				$('#errors').html(errors);
			}});
	}

})