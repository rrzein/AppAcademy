SessionsTemplate.Views.GistForm = Backbone.View.extend({
  template: JST['gists/form'],

	events: {
		"click input[type='submit']": "submit",
		"click .create-gist-form": "createGistFile",
		"click .add-gist-file": "addGistFile"
	},

  render: function() {
    var renderedContent = this.template();
		this.$el.html(renderedContent);
		var firstGistFileForm = JST['gist_files/form_part']();
		this.$el.append(firstGistFileForm);
		return this;
  },

	submit: function(event) {
		var that = this;

		event.preventDefault();
		var gistFiles = new SessionsTemplate.Collections.GistFiles();

		$("form.form-gist-file").each(function(index, element) {
			console.log(element);
      var attrs = $(element).serializeJSON();
      gistFiles.add(attrs);
			console.log(attrs);
		});


		var attrs = $(event.target.form).serializeJSON();
		var gist = new SessionsTemplate.Models.Gist(attrs);

    var gistFilesArray = [];
    gistFiles.each(function(gistFile) {
    	gistFilesArray.push(gistFile.attributes);
			console.log(gistFile.attributes);
    });

		gist.attributes.gist_files_attributes = gistFilesArray;
		gist.save();
		SessionsTemplate.gists.add(gist);

    // SessionsTemplate.gists.sync();


		// Backbone.history.navigate("", true);
	},

	addGistFile: function(event) {
		event.preventDefault();
		var renderedContent = JST['gist_files/form_part']();
		this.$el.append(renderedContent);
		return this;
	}

});