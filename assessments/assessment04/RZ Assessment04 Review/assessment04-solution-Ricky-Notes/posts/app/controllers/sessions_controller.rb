class SessionsController < ApplicationController
  def new
  end

  def create
    @user = verify_user!(
      params[:user][:username],
      params[:user][:password]
    )
    #verify user is a method that finds the user by the username, and matches its password to the params[:user][:password] passed. if they match up, the method returns the user. if not, then it returns nil.

    if @user
      login_user!(@user)
      redirect_to posts_url
    else
      #returns to sign-in on failure. pre-populate with log-in info?
      render :new
    end
  end

  def destroy
    @user = current_user
    if @user.nil?
      redirect_to new_session_url
      return
    else
      logout_user!(@user)
      redirect_to new_session_url
    end
  end
end
