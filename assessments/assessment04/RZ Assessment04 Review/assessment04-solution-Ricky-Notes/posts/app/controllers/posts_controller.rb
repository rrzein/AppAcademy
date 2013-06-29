class PostsController < ApplicationController
  before_filter :assert_current_user!

  def index
    @posts = Post.where(:user_id => current_user.id)
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(params[:post])
    @post.user_id = current_user.id
    if @post.save
      redirect_to post_url(@post)
    else
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update_attributes(params[:post])
      redirect_to post_url(@post)
    else
      render :edit
    end
  end


  private
  def assert_current_user!
    unless current_user
      redirect_to new_session_url
    end
  end
end
