// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require underscore
//= require_tree .

var App = {};

App.Models = {};

App.Models.TodoList = function (attrs) {
  this.setAttributes(attrs);
}

App.Models.TodoList.fetch = function (callback) {
  $.ajax({
    url: "/todo_lists.json",
    type: "get",
    success: function (todoListParams) {
      App.Models.TodoList._all =
        _(todoListParams).map(function (todoListParam) {
          return new App.Models.TodoList(todoListParam);
        });

      callback(App.Models.TodoList._all);
    }
  });
};

App.Models.TodoList.find = function (id) {
  return _(App.Models.TodoList._all).findWhere({ id: id });
};

App.Models.TodoList.prototype.addItem = function (encodedItem, callback) {
  var that = this;
  $.ajax({
    url: "/todo_lists/" + that.id + "/todo_items.json",
    type: "post",
    data: encodedItem,
    success: function (todoItemAttrs) {
      that.items.push(todoItemAttrs);
      
      if (callback) {
        callback(todoItemAttrs);
      }
    }
  });
};

App.Models.TodoList.prototype.asJSON = function () {
  return { id: this.id, title: this.title };
}

App.Models.TodoList.prototype.fetchItems = function (callback) {
  var that = this;
  $.ajax({
    url: "/todo_lists/" + that.id + "/todo_items.json",
    type: "get",
    success: function (todoItems) {
      // TODO: Could we parse todoItems to a TodoItem class?
      that.items = todoItems;
      
      callback(that.items);
    }
  });
};

App.Models.TodoList.prototype.setAttributes = function (params) {
  var that = this;
  _(params).each(function (value, key) {
    that[key] = value;
  });
};

App.Models.TodoList.prototype.update = function (callback) {
  var that = this;

  $.ajax({
    url: "/todo_lists/" + this.id + ".json",
    type: "put",
    data: {
      todo_list: that.asJSON()
    },
    success: function (updatedParams) {
      that.setAttributes(updatedParams);

      callback();
    }
  });
};

App.Views = {};

App.Views.TodoListsIndexView = function (todoLists) {
  this.todoLists = todoLists;
  this.$el = $("<div></div>");
};

App.Views.TodoListsIndexView.prototype.render = function () {
  var templateFn = _.template($("#todo-lists-template").html());
  var renderedContent = templateFn({ todoLists: this.todoLists });
  
  this.$el.html(renderedContent);
  this.installClickHandlers();

  return this.$el;
};

App.Views.TodoListsIndexView.prototype.installClickHandlers = function () {
  this.$el.find("a.todo-list").on("click", function (event) {
    event.preventDefault();

    var id = parseInt($(this).attr("data-id"));
    var todoList = App.Models.TodoList.find(id);

    todoList.fetchItems(function () {
      var todoListView = new App.Views.TodoListView(todoList);
      $("#content").html(todoListView.render());
    });
  });  
};

App.Views.TodoListView = function (todoList) {
  this.todoList = todoList;
  this.$el = $("<div></div>");
};

App.Views.TodoListView.prototype.render = function () {
  var templateFn = _.template($("#todo-list-template").html());

  this.$el.html(templateFn({ todoList: this.todoList }));
  this.installHandlers();

  return this.$el;
};

App.Views.TodoListView.prototype.installHandlers = function () {
  var that = this;

  this.$el.find('input[type="submit"]').on("click", function (event) {
    event.preventDefault();

    that.todoList.addItem($(this.form).serialize(), function (newItemAttrs) {
      that.render();
    });
  });
}

$(function () {
  App.Models.TodoList.fetch(function (todoLists) {
    var indexView = new App.Views.TodoListsIndexView(todoLists);
    $("#content").html(indexView.render());
  });
});
