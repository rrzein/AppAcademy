class UsersController < ApplicationController
  def new
    @user = User.new
    render :new
  end

  def show
    @user = User.find(params[:id])
    render :show
  end

  def create
    @user = User.new(params[:user])

    if @user.save
      redirect_to user_url(@user)
    else
      flash[:token] = "User unable to be created."
      render :new
    end
  end

  def feed
    @user = User.find(params[:id])
    render :feed

    #prefer
    #@circles = current_user.friend_circles.includes(:postings).includes(:user)
  end

end
