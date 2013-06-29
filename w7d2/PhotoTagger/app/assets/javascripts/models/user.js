PT = {};

PT.Models = {};

PT.Models.User = (function() {
	function User(params) {
    this.setAttributes(params);
		this.baseUrl = "/users/";
	};

	User.fetchCurrentUser = function(callback) {
    var that = this;
		$.ajax({
    	url: "/users/",
			type: "get",
			success: function(userParams) {
				User._currentUser = new User(userParams);
				PT.Models.Photo._all = User._currentUser.photos;
				callback(User._currentUser);
			}
    });
	};

	User.prototype.setAttributes = function(params) {
		var that = this;
		_(params).each(function (value, key) {
			that[key] = value;
		});
		this.createJSPhotos();
		this.createJSFriends();
	};

	User.prototype.createJSPhotos = function(callback) {
		var that = this;
		that.photos = _(that.photos).map(function (photo) {
			return new PT.Models.Photo(photo);
		});

	};

	User.prototype.createJSFriends = function(callback) {
		var that = this;
		that.friends = _(that.friends).map(function (friend) {
			return new PT.Models.User(friend);
		});

	};

	User.find = function(id) {
    return _(User._currentUser.friends).findWhere({ id: id });

	};

	return User;

})();