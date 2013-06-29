class TodoItemsController < ApplicationController
  def create
    @todo_list = TodoList.find(params[:todo_list_id])
    @todo_item = @todo_list.todo_items.create!(
      params[:todo_item]
    )
    
    render :json => @todo_item
  end
  
  def index
    @todo_items = TodoItem.where(:todo_list_id => params[:todo_list_id])
    render :json => @todo_items
  end
end
