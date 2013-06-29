window.TD = {
	Models: {},
	Collections: {},
	Views: {},
	Routers: {},

	initialize: function($sidebar, $content, tasksData) {
		var tasks = new TD.Collections.Tasks(tasksData);

		this.installSidebar($sidebar, tasks);

		new TD.Routers.TasksRouter($content, tasks);
		Backbone.history.start();
	},

	installSidebar: function($sidebar, tasks) {
		var that = this;

		var tasksListView = new TD.Views.TasksListView({
			collection: tasks
		});

		$sidebar.html(tasksListView.render().$el);
	}
};