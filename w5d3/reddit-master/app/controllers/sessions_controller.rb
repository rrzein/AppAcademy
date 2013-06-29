class SessionsController < ApplicationController
  def new
    @user = User.new
  end
  
  def create
    @user_params = User.new(params[:user])
    @user = login_user!(@user_params)
    
    if @user
      redirect_to user_url(@user)
    else
      @user = @user_params
      render :new
    end
  end
end
