class SessionsController < ApplicationController
  def new
    render :new
  end

  def create
    @user = User.find_by_name(params[:user][:name])
    if @user && @user.verify_password(params[:user][:password])
      login(@user)
      redirect_to photos_url(@user)
    else
      render :new
    end
  end

  def destroy
    if current_user
      logout
    end
    render :new
  end

end
