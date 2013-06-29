// app/assets/javascript/views/new_task_view.js
TD.Views.NewTaskView = Backbone.View.extend({
  events: {
    "click button.submit": "submit",
    "click button.cancel": "cancel"
  },
  
  render: function () {
    var that = this;
    
    var renderedContent = JST["tasks/new"]();
    that.$el.html(renderedContent);
    return that;
  },
  
  submit: function () {
    var that = this;
    
    var task = new TD.Models.Task({
      title: that.$("input[name=task\\[title\\]]").val()
    });
    
    that.collection.add(task);
    task.save();
    Backbone.history.navigate("#/");
  },
  
  cancel: function () {
    Backbone.history.navigate("#/");
  }
});
