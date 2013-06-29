module SessionsHelper
  def login_user!(user_params)
    user = User.find_by_username(user_params.username)
    if user && user.verify_password(user_params.password)
      user.session_token = SecureRandom::urlsafe_base64(16)
      user.save!
      session[:session_token] = user.session_token
      
      user
    else
      nil
    end
  end
  
  def current_user
    return nil unless session[:session_token]
    User.find_by_session_token(session[:session_token])
  end
  
  def require_user!
    redirect_to new_session_url unless current_user
  end
end
