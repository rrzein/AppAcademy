class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def create
    @user = User.create(params[:user])
    redirect_to user_url(@user)
  end

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
    @secret = current_user.authored_secrets.new
  end
end
