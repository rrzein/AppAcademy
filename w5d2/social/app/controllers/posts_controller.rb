class PostsController < ApplicationController
  def index
    @user = current_user
    render :index
  end

  def new
    @audience_circles = current_user.friend_circles
    @post = Post.new
    render :new_post
  end

  def show
    @post = Post.find(params[:id])
    render :show_post
  end

  def create
    @post = Post.new(params[:post])
    @post.user = current_user
    #prefer
    # @post = current_user.posts.new(params[:post])

    if @post.save
      flash[:notice] = "Post created."
      redirect_to post_url(@post)
    else
      flash[:notice] = "Post couldn't be created."
      render :new_post
    end
  end
end
