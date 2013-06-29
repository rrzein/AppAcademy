PT.Models.Tag = (function() {
	function Tag(params) {
    this.setAttributes(params);
		this.baseUrl = "/tags/";
	}

	Tag.prototype.setAttributes = function(params) {
		var that = this;
		_(params).each(function(value, key) {
			that[key] = value;
		});
	};

	Tag.prototype.destroy = function(params) {
		var that = this;

		$.ajax({
			url: that.baseUrl + that.id,
			type: "delete",
			success: function(updatedTagsArray) {
				var photo = Photo.find(that.photo_id);

				photo.tags = updatedTagsArray;

				_(photo.tags).map(function (tagAttr) {
					return new Tag(tagAttr);
				});
			}
		});
	};

	Tag.addTag = function(photo, encodedTagData, callback) {

		$.ajax({
			url: "/photos/" + photo.id + "/tags/",
			type: "post",
			data: encodedTagData,
			success: function(updatedTagsArray) {
				photo.tags = updatedTagsArray;
				photo.tags = _(photo.tags).map(function (tagAttr) {
					return new Tag(tagAttr);
				});
			}
		})
	};

	return Tag;
})();