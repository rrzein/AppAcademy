class PostsController < ApplicationController
  def create
    @post = Post.new(params[:post])
    if @post.save
      render json: @post
    else
      render json: { errors: @post.errors.full_messages }, status: 422
    end
  end

  def index
    @posts = Post.all
    respond_to do |format|
      format.html { render :index }
      format.json { render json: @posts }
    end
  end

  def update
    post = Post.find(params[:id])
    if post.update_attributes(params[:post])
      render json: post
    else
      render json: { errors: post.errors.full_messages }, status: 422
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    render json: @post
  end
end
