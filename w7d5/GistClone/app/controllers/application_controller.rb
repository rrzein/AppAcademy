class ApplicationController < ActionController::Base
  protect_from_forgery

  include SessionsHelper

  # before_filter :authenticate_user

  def redirect_logged_in_user
    if logged_in?
      flash[:errors] ||= []
      flash[:errors] << "You are already logged in"
      redirect_to current_user
    end
  end
end
