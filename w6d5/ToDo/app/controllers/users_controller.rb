class UsersController < ApplicationController
  def create
    @user = User.create(params[:user])
    redirect_to user_url(@user)
  end

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end
end
