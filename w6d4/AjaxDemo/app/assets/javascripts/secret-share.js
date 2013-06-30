var SS = (function () {
  function Secret(id, text) {
    this.id = id;
    this.text = text;
  }

  Secret.prototype.save = function () {
    var that = this;

    $.post("/secrets.json", {
      secret: {
        id: that.id,
        text: that.text
      }
    }, function (response) {
      // TODO: We should handle potential errors.

      that.id = response.id;
      Secret.all.push(that);

      _(Secret.callbacks).each(function (callback) {
        callback();
      });
    });
  };

  Secret.all = [];
  Secret.callbacks = [];
  Secret.fetchAll = function () {
    $.getJSON(
      "/secrets.json",
      function (data) {
        Secret.all = [];
        _.each(data, function (datum) {
          Secret.all.push(new Secret(datum.id, datum.text));
        });

        _(Secret.callbacks).each(function (callback) {
          callback();
        });
      }
    );
  };

  function SecretsView(el) {
    var that = this;
    that.$el = $(el);

    Secret.callbacks.push(function () {
      that.render();
    });
  }

  SecretsView.prototype.render = function () {
    var that = this;

    var ul = $("<ul></ul>");
    _.each(Secret.all, function (secret) {
      ul.append($("<li></li>").text(secret.text));
    });

    that.$el.html(ul);
  };

  function SecretFormView(textField, button, callback) {
    this.$textField = $(textField);
    this.$button = $(button);
    this.callback = callback;
  }

  SecretFormView.prototype.bind = function () {
    var that = this;

    that.buttonClickHandler = function () {
      that.submit();
    };
    that.$button.click(that.buttonClickHandler);
  };

  // we would call this eif we wanted to remove the SecretFormView
  // from the DOM.
  SecretFormView.prototype.unbind = function () {
    var that = this;

    that.$button.off('click', buttonClickHandler);
    delete that.buttonClickHandler;
  }

  SecretFormView.prototype.submit = function () {
    var that = this;

    var newSecret = new Secret(null, that.$textField.val());
    // clear text field
    that.$textField.val("");

    that.callback(newSecret);
  };

  return {
    Secret: Secret,
    SecretsView: SecretsView,
    SecretFormView: SecretFormView
  };
})();
