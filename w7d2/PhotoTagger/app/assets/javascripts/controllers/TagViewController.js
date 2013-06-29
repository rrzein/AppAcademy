PT.Views.TagView = (function(){
		function TagView(user, photo) {
			this.user = user;
			this.photo = photo;
			this.$el = $("<div></div>");
		};

		TagView.prototype.render = function() {

			var templateFn = JST['templates/tagsTemplate'];
			this.$el.html(templateFn({ user: this.user, photo: this.photo }));
			this.installHandlers();
			this.renderTags();

			return this.$el;
		};

		TagView.prototype.renderTags = function() {
			var that = this;
      _(this.photo.tags).each(function(tag) {
        var friend = PT.Models.User.find(tag.friend_id);
				var $tag = $("<div></div>").css({"position":"absolute","top":tag.y,"left":tag.x, "width": "50px", "height": "20px", "background-color": "white"}).text(friend.name);

				that.$el.append($tag);
      });

		}

		TagView.prototype.installHandlers = function() {
			var that = this;
			this.$el.find("img").on("click", function(event) {

				var offset = $(this).offset();
				var position = {
					left: event.clientX,
					top: event.clientY
				}

				var templateFn = JST['templates/taggingForm'];
				var $tagForm = $(templateFn({ user: that.user, photo: that.photo, position: position })).css({"position":"absolute","top":position.top,"left":position.left, "width": "15px", "height": "20px"});

				$($(this).parent()).append($tagForm);
				that.installTagHandlers();

			});
		};

		TagView.prototype.installTagHandlers = function() {
			var that = this;
			this.$el.find('input[type="submit"]').on("click", function(event) {
				console.log(event.target);
				event.preventDefault();

				var offset = $(this).offset();
				var position = {
					left: event.clientX,
					top: event.clientY
				}

				PT.Models.Tag.addTag(that.photo, $(this.form).serialize(), function(updatedPhoto){
					that.render();
				})

			});
		};

		return TagView;
	})();