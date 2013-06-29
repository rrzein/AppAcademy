// Models
//no need to explicitly define attributes
window.Wine = Backbone.Model.extend({
	//restful service endpoint to retrieve or persist Model data.
	//only needed when retrieving/persiting models that are NOT part of a collection.
	//if model is part of a collection, url attribute defined in the collection is enough.
	urlRoot: "../api/wines",
	//default values used when a new instance of the model is created. (OPTIONAL)
	//required to render an EMPTY wine model object in this case.
	defaults: {
		"id":null,
		"name":"",
		"grapes":"",
		"country":"USA",
		"region":"California",
		"year":"",
		"description":"",
		"picture":""
	}
});

window.WineCollection = Backbone.Collection.extend({
	//"model" indicates the things that make up the collection
	model: Wine,
	//url gives endpoints for restful API... allows Backbone's Model API to know how to retrieve, create, update, and delete
	url: "../api/wines"
});

//Views
window.WineListView = Backbone.View.extend({
	//this.$el is a ul, which will be appended with a bunch of li's which are the "views" for specific wine items
	tagName: 'ul',

	initialize: function() {
		this.model.bind("reset", this.render, this);
		var self= this;
		//make the wine automatically appear in the list.
		//bind the View to the add event of the WineListView model.
		//when event happens, a new instance of WineListItemView is created and added to the list.
		this.model.bind("add", function(wine) {
			$(self.el).append(new WineListItemView({model:wine}).render().el);
		});
	},
	//render iterates through the collection and instantiates a WineListItemView for each wine.
	//WineListItemView is then added to the wineList.
	render: function (eventName) {
		_.each(this.model.models, function(wine) {
			$(this.el).append(new WineListItemView({model: wine}).render().el);
		}, this);
		return this;
		}
	}
);

window.WineListItemView = Backbone.View.extend({
	//this.$el is an li... an li tag for each specific wine is going to be appended to the winelistview
	tagName: "li",

	template: _.template($('#tpl.wine-list-item').html()),

	//bind the view to the "change" event of the model--the second argument indicates that you want to execute the view's render function when you change the model.
	//same thing with binding to the "destroy" event of the model... you're gonna execute the function's "close" event when the model is destroyed.
	initialize:function() {
		this.model.bind("change", this.render, this);
		this.model.bind("destroy", this.close, this);
	}

	//merges model data into wine-list-item template.
	//separates the view for list items, which will make it easy to update or re-render a specific list item when the model changes, without re-rendering the whole list.

	render: function (eventName) {
		$(this.el).html(this.template(this.model.toJSON()));
		return this;
	}

	//to avoid memory leaks and firing events multiple times, unbind the the event listeners, then remove the list item from the DOM.
	close: function() {
		$(this.el).unbind();
		$(this.el).remove();
	}
});

//view for displaying specific wine details in the wine form.
window.WineView = Backbone.View.extend({
	template: _.template($('#tpl-wine-details').html()),

	initialize: function() {
		this.model.bind("change", this.render, this);
	},

	//render function merges model data for a specific wine into the wine-details template retrieved from index.html
	render: function (eventName) {
		$(this.el).html(this.template(this.model.toJSON()));
		return this;
	},

	events:{
		"change input": "change",
		"click .save": "saveWine",
		"click .delete": "deleteWine"
	},

	change: function(event) {
		var target = event.target;
		console.log('changing' + target.id + ' from: ' + target.defaultValue + ' to: ' + target.value);
	},

	//take values out of the input values of the form, set it to the model's attributes.
	saveWine: function() {
		this.model.set({
			name:$('#name').val(),
			grapes:$('#grapes').val(),
			country:$('#country').val(),
			region:$('#region').val(),
			year:$('#year').val(),
			description:$('#description').val()
		});
		// if the model is new (i.e. no id), that create the model within the wineList collection
		if (this.model.isNew()) {
			app.wineList.create(this.model);
		} else {
			//if it's not new(has an id), just save it.
			this.model.save();
		}
		return false;
	},

	//destroy the model.
	deleteWine: function() {
		this.model.destroy({
			success:function () {
				alert('Wine deleted successfully');
				window.history.back();
			}
		});
		return false;
	},

	//same deal as with the prior view. unbind the element, and empty it.
	close:function() {
		$(this.el).unbind();
		$(this.el).empty();
	}
});
//used to render composite UI components
//header view is a toolbar.
window.HeaderView = Backbone.View.extend({

	template: _.template($('#tpl-header').html()),

	initialize: function() {
		this.render();
	},

	render: function (eventName) {
		$(this.el).html(this.tempalate());
		return this;
	},
	//has a .new button that launches newWine
	events:{
		"click .new":"newWine"
	},

	//closes the wineView
	newWine: function (event) {
		//just navigate to the new route, specify "true" to trigger the router event.
		app.navigate("wines/new", true);
		return false;
	}
});

// Router
var AppRouter = Backbone.Router.extend({
	routes: {
		//entry points for application. deep-linkable urls.
		//default route
		"":"list",
		//new route for a new wine page
		"wines/new": "newWine",
		//details of specific wine in wine form.
		"wines/:id" : "wineDetails"
	},

	//creates a new instance of the header, renders it, and puts it into the #header div.
	initialize:function () {
		$('#header').html(new HeaderView().render().el);
	},

	//renders the sidebar from the main route
	list: function() {
		this.wineList = new WineCollection();
		var self = this;
		//fetch, then in the call back we render everything with the information we get.
		this.wineList.fetch({
			success: function() {
				//notice now that self.wineList is now populated.
				self.wineListView = new WineListView({model:self.wineList});
				$('#sidebar').html(self.wineListView.render().el);
				if (self.requestedId) self.wineDetails(self.requestedId);
			}
		})
	},

	//renders the specific details of the wine in the main content div
	wineDetails:function (id) {
		//if the collection has already been rendered
		if (this.wineList) {
			//just get the requested model with the id
			this.wine = this.wineList.get(id);
			if (this.wineView) this.wineView.close();
			this.wineView = new WineView({model: this.wine});
			$('#content').html(this.wineView.render().el);
			//if the collection has not already been rendered(i.e. we navigate here not from the main page)
		} else {
			//save the requested id in the attribute
			this.requestedId = id;
			//call list to render from the start (i.e. create a new Collection)
			this.list();
		}
	},

	newWine: function(){
		console.log('MyRouter newWine');
		//if there's a wineview open, close it.
		if (app.wineView) app.wineView.close();
		//create and render the new wine view
		app.wineView = new WineView({model: new Wine()});
		app.wineView.render();
	}

});

var app = new AppRouter();
Backbone.history.start();