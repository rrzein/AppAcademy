class ApplicationController < ActionController::Base
  #all the shit you included in here would probably be better
  #in the ApplicationHelper module
  #WRITE the methods in ApplicationHelper, then to use them here,
  #use 'include ApplicationHelper'

  protect_from_forgery

  def current_user
  	return nil if session[:session_token].nil?
  	@current_user ||= User.find_by_session_token(session[:session_token])
  end
  #better way of writing the above, in the applicationhelper
  # def current_user
  #   session_token = session[:session_token]
  #   return nil if session_token.nil?
  #   User.find_by_session_token(session_token)
  # end

  def logged_in?
  	!!current_user
  end

  def authenticate_user
  	redirect_to new_session_url unless logged_in?
  end
end
