// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require backbone-rails
//
//= require journal
//= require_tree ./models
//= require_tree ./collections
//= require_tree ./routers
//= require_tree ./views
//= require_tree ../templates
//= require_tree .

$(function() {
	App.Store.posts = new App.Collections.Posts();
	App.Store.posts.fetch({
		success: function(collection, response, options) {
			App.Store.router = new App.Router($('body'));
			Backbone.history.start();
		}
	});

	App.Store.csrfToken = $('[name="csrf-token"]').attr('content');
});