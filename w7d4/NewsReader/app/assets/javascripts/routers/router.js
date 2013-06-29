NewReader.Router = Backbone.Router.extend({

	initialize: function($rootEl){
		this.$rootEl = $rootEl;
	},

	routes: {
		"": "index",
		"feeds/:id/entries": "showFeed",
		"feeds/:feed_id/entries/:id" : "showEntry"
	},

	index: function() {
		var that = this;
		NewReader.feeds.fetch({
			success: function() {
				var feedsIndex = new NewReader.Views.FeedsIndex({
					collection: NewReader.feeds,
				});
				that.$rootEl.html(feedsIndex.render().el);
			}
		});
	},

	showFeed: function(id) {
		var that = this;
		this._getFeeds(function() {
			var feed = NewReader.feeds.get(id);
			var feedView = new NewReader.Views.Feed({
				model: feed,
				collection: feed.get("entries"),
			});
		that.$rootEl.html(feedView.render().el);
		});
	},

	showEntry: function(feed_id, id) {
		var that = this;
		this._getFeeds(function() {
			var feed = NewReader.feeds.get(feed_id);
			var entry = feed.entries.get(id);
			var entryView = new NewReader.Views.Entry({
				model: entry
			})
			that.$rootEl.html(entryView.render().el);
		});
	},

	_getFeeds: function(callback) {
		if (!NewReader.feeds) {
		NewReader.feeds = new NewReader.Collections.Feeds();
		};
		NewReader.feeds.fetch({
			success: callback
		})
	}
})