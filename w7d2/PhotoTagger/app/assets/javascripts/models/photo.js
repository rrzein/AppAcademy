PT.Models.Photo = (function () {

	function Photo(params) {
		this.setAttributes(params);
		this.baseUrl = "/photos/";
	}

	Photo.prototype.save = function() {

	}

	Photo.prototype.setAttributes = function(params) {
		var that = this;
		_(params).each( function (value, key) {
			that[key] = value;
		});
	};

	Photo.addPhoto = function(encodedItem, callback){
		var that = this;
		$.ajax({
			url: "/photos/",
			type: "POST",
			data: encodedItem,
			success: function(photoAttrs) {
				var newPhoto = new Photo(photoAttrs);
				PT.Models.User._currentUser.photos.push(newPhoto);

				if (callback) {
					callback(newPhoto);
				}
			}
		});
	};

	Photo.prototype.addTag = function(encodedItem, callback) {
		var that = this;
		$.ajax({
			url: that.baseUrl + that.id + "/tags",
			type: "post",
			data: encodedItem,
			success: function(tagAttrs) {
				var newTag = new Tag(tagAttrs);
				that.tags.push(newTag);
			}
		});
	};

	Photo.prototype.asJSON = function() {
		return { id: this.id, url: this.url, user_id: this.user_id };
	};

	Photo.prototype.update = function(callback) {
		var that = this;
		$.ajax({
			url: that.baseUrl + that.id,
			type: "put",
			data: {
				photo: that.asJSON()
			},
      success: function(updatedParams) {

				that.setAttributes(updatedParams);

				if (callback) { callback(that); }
      }
		});
	};

	Photo.prototype.destroy = function(callback) {
		var that = this;

		$.ajax({
			url: that.baseUrl + that.id,
			type: "delete",
      success: function(updatedPhotosArray) {
				_(Photo._all).map(function (photo) {
					return new PT.Models.Photo(photo);
				});

 			if (callback) { callback(Photo._user); }
      }
		});
	};

	Photo.prototype.fetchTags = function(callback) {
		var that = this;
		$.ajax({
			url: that.baseUrl + that.id + "/tags.json",
			type: "get",
			success: function (tags) {
				var JSTags = _(tags).map( function (tagAttrs) {
					return new PT.Models.Tag(tagAttrs);
				});
				that.tags = JSTags;
				if (callback) {
					callback();
				}
			}
		});
	};

	Photo.find = function(id) {
		return _(PT.Models.Photo._all).findWhere({ id: id });
	};

	// Photo._all = PT.Models.User._currentUser.photos;
	//
	// Photo._user = PT.Models.User._currentUser;

	return Photo;

})();