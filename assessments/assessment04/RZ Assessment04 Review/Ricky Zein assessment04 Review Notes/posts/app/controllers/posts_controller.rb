class PostsController < ApplicationController
  #YOU CAN INCLUDE THE METHOD FOR AUTHENTICATING HERE IN THE POSTSCONTROLLER PAGE.
	before_filter :authenticate_user

	def index
    #here you can just set @posts to Post.where(:user_id => current_user.id)
    #you don't need to set the @user variable because the @current_user should already be set, you can just find the current user's posts by the aforementioned method.
		@user = User.find_by_session_token(session[:session_token])
		render :index
	end

	def show
		@post = Post.find_by_id(params[:id])
    #Author is really jsut @post.user.username. DONT YOU KNOW YOUR ACTIVERECORD SHIT.
    #dont have to find the author here. unnecessary.
		@author = User.find_by_id(@post.user_id)
		render :show
	end

	def new
		render :new
	end

	def edit
		@post = Post.find_by_id(params[:id])
		render :edit
	end

	def update
		@post = Post.find_by_id(params[:post][:id])
		if @post.update_attributes(params[:post])
			redirect_to post_url(@post)
		else
			redirect_to post_url(@post)
		end
	end

	def create
		@user = User.find_by_session_token(session[:session_token])
		@post = Post.new(params[:post])
		if @post.save
			redirect_to post_url(@post)
		else
			render :new
		end
	end

end
