class SessionsController < ApplicationController
  def create
    user_attributes = params[:user]
    @user = login_user(
      user_attributes[:username],
      user_attributes[:password]
    )
    
    if @user
      redirect_to user_url(@user)
    else
      @user = User.new(user_attributes)
      render :new
    end
  end

  def new
    @user = User.new
  end
end
