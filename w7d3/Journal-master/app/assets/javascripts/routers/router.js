App.Router = Backbone.Router.extend({
	initialize: function($rootEl) {
		this.$rootEl = $rootEl;
		this.renderedSidebar = false;
	},

	routes: {
		"": "displayListView",
		"posts/new": "displayNewForm",
		"posts/:id/edit": "displayEditForm",
		"posts/:id": "displayPostView"
	},

	displayListView: function() {
		var listView = new App.Views.PostListView({collection: App.Store.posts});
		listView.render();
		this.$rootEl.find('#sidebar').html(listView.$el);
		this.renderedSidebar = true;
	},

	displayPostView: function(id) {
		if (this.renderedSidebar === false) {
			this.displayListView();
		}
		var post = App.Store.posts.get(id);
		var showView = new App.Views.PostShowView({model: post});
		showView.render();
		this.$rootEl.find('#content').html(showView.$el);
	},

	displayNewForm: function () {
		if (this.renderedSidebar === false) {
			this.displayListView();
		}
		var newPost = new App.Models.Post();
		var formView = new App.Views.NewPostView({model: newPost});
		formView.render();
		this.$rootEl.find("#content").html(formView.$el);
	},

	displayEditForm: function(id) {
		if (this.renderedSidebar === false) {
			this.displayListView();
		}
		var post = App.Store.posts.get(id);
		var editFormView = new App.Views.NewPostView({model: post});
		editFormView.render();
		this.$rootEl.find('#content').html(editFormView.$el);
	}
});