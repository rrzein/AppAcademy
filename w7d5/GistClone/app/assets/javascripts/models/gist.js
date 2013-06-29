SessionsTemplate.Models.Gist = Backbone.Model.extend({
	parse: function(resp, options) {
		var favorite = new SessionsTemplate.Models.Favorite(resp.favorites);
		favorite.urlRoot = "/gists/" + resp.id + "/favorite";
		resp.favorites = favorite;
		return resp;
	},

	toJSON: function() {
    if (this.attributes.favorites) {
	    var favorite = this.attributes.favorites;
			favorite.save();
			delete this.attributes.favorites;
    }

		return _.clone(this.attributes);
	},
	urlRoot: "/gists"
});
