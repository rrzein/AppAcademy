App.Views.PostListView = Backbone.View.extend({
	initialize: function(){
		var that = this;
		this.listenTo(this.collection, "remove", this.render);
		this.listenTo(this.collection, "add", this.render);
		this.listenTo(this.collection, "change", this.render);
	},

	tagName: 'ul',

	events: {
		'click button.delete': 'deletePost',
	},

	render: function() {
		var that = this;
		this.$el.empty();
		this.collection.forEach(function(post){
			var $postLI = $('<li>');
			var $postLink = $('<a>').attr('href',"/#/posts/" + post.id)
															.text(post.escape('title'));
			var $button = $('<button>').addClass('delete')
																 .attr('data-id', post.id)
																 .text('Delete');
			$postLI.append($postLink).append($button);
			that.$el.append($postLI);
		});
		var $newPostLink = $('<a>').attr('href', '#posts/new').text('New post');
		that.$el.append($newPostLink);
		return this;
	},

	deletePost: function(event) {
		var that = this;
		var id = $(event.target).data('id');
		var model = this.collection.get(id);
		model.destroy({
			success: function() {
			}
		});
	}
});