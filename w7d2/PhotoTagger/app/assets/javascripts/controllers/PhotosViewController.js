PT.Views = {};

PT.Views.PhotosIndexView = (function() {
	function PhotosIndexView(user) {
		this.user = user;
		this.photos = this.user.photos;
		this.$el = $("<div></div>");
	}

	PhotosIndexView.prototype.render = function() {
		var templateFn = JST['templates/Index'];
		var renderedTemplate = templateFn({ user: this.user });

		this.$el.html(renderedTemplate);
		this.installClickHandlers();

		return this.$el;
	};

	PhotosIndexView.prototype.installClickHandlers = function() {
		var that = this;
    this.$el.find("a.photo").on("click", function(event) {
      event.preventDefault();
			var id = parseInt($(this).attr("data-id"));
			var photo = PT.Models.Photo.find(id);

      photo.fetchTags(function() {

      	var tagView = new PT.Views.TagView(that.user, photo);
				$("#content").html(tagView.render());
      });
    });

		this.$el.find("input[type='submit']").on('click', function(event) {
			event.preventDefault();
			console.log(event.target);
			PT.Models.Photo.addPhoto($(this.form).serialize(), function() {
				that.render();
			})
		})
	};

	return PhotosIndexView;

})();