App.Collections.Posts = Backbone.Collection.extend({
	model: App.Models.Post,
	url: '/posts'
});