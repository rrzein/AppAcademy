module ApplicationHelper
  def current_user
    session_token = session[:session_token]
    return nil if session_token.nil?
    User.find_by_session_token(session_token)
  end

    #verify user is a method that finds the user by the username, and matches its password to the params[:user][:password] passed. if they match up, the method returns the user. if not, then it returns nil.

  def verify_user!(username, password)
    user = User.find_by_username(username)
    if user && user.password == password
      user
    else
      nil
    end
  end

  def login_user!(user)
    user.session_token = SecureRandom::urlsafe_base64(16)
    user.save!

    session[:session_token] = user.session_token
  end

  def logout_user!(user)
    session[:session_token] = nil
    user.session_token = nil
    user.save!

    nil
  end
end
