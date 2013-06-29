class UsersController < ApplicationController
  def new
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      login_user!(@user)      
      redirect_to(posts_url)
    else
      render :new
    end
  end
end
