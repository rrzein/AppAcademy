class SessionsController < ApplicationController
  def new
    render :new
  end

  def create
    @user = User.find_by_username(params[:user][:username])
    @password = params[:user][:password]

    if @user.verify_password(@password)
      @user.generate_session_token
      session[:session_token] = @user.session_token
      redirect_to user_url(@user)
    else
      render :json => "Invalid username and/or password."
    end
  end

  def destroy
    @user = User.find_by_session_token(session[:session_token])
    session[:session_token] = nil
    @user.clear_session_token

    redirect_to new_session_url
  end

end
