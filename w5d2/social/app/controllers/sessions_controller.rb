class SessionsController < ApplicationController
  def new
    render :new
  end

  def create
    @user = User.find_by_username(params[:user][:username])

    if @user && @user.verify_password(params[:user][:password])
      @user.reset_session_token!
      session[:session_token] = @user.session_token
      redirect_to feed_user_url(@user)
    else
      #you have to set flash[:errors] to or/equal an empty array
      flash[:notice] = "Unable to login"
      render :new
    end
  end

  def destroy
    if @current_user.nil?
      flash[:notice] = "No one is currently logged in."
      render :new
    else
      @current_user.logout
      session[:session_token] = nil
      render :new
    end
  end

end
