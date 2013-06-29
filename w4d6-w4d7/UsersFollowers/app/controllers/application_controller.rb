class ApplicationController < ActionController::Base
  protect_from_forgery

  def current_user
    return nil if session[:session_token].nil?
    @current_user ||= User.find_by_session_token(session[:session_token])
  end

  def logged_in?
    !!current_user
  end

  def authenticate_user
    unless logged_in?
      redirect_to new_session_url
    end
  end

  def authorize_profile_page
    @user = User.find_by_id(params[:id])
    unless current_user == @user
      # @user.errors << "You are not authorized to view that page."
      render :json => { :errors => @user.errors.full_messages }
    end
  end

end
