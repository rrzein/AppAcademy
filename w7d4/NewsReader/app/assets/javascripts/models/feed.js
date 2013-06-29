NewReader.Models.Feed = Backbone.Model.extend({
	initialize: function() {
		this.entries = this.attributes.entries;
	},

	parse: function (resp, options) {
		var feedEntries = new NewReader.Collections.Entries();
		feedEntries.add(resp.entries);
		resp.entries = feedEntries;
		return resp;
	},

	// toJSON: function(options) {
	// 	var entryAttrs = [];
	// 	this.attributes.entries.each( function (entry) {
	// 		var attrs = entry.attributes;
	// 		entryAttrs.push(attrs);
	// 	});
	// 	this.attributes.entries = entryAttrs;
	// 	return _.clone(this.attributes);
	// },

	reload: function() {
		var that = this;
		console.log("getting into reload");
		console.log(this);

		$.ajax({
			url: "/feeds/" + this.id + "/entries",
			type: "get",
			success: function(data) {
				console.log("before change");
				console.log(that);
				that = new NewReader.Models.Feed(data);
				console.log("reloaded");
				console.log(that);
			},
		})
	},
})