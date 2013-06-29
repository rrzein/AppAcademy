class TodoListsController < ApplicationController
  def create
    @todo_list = TodoList.create!(params[:todo_list])
    render :json => @todo_list
  end

  def index
    @todo_lists = TodoList.all
    
    respond_to do |format|
      format.html { render :index }
      format.json { render :json => @todo_lists }
    end
  end

  def show
    @todo_list = TodoList.find(params[:id])
    render :json => @todo_list
  end
  
  def update
    @todo_list = TodoList.find(params[:id])
    @todo_list.update_attributes!(params[:todo_list])
    render :json => @todo_list
  end
end
