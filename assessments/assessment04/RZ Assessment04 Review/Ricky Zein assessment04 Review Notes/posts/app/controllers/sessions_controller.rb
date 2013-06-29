class SessionsController < ApplicationController
	def new
		render :new
	end

	def create
		@user = User.find_by_username(params[:user][:username])
		@password = params[:user][:password]

		if @user && @user.verify_password(@password)
			@user.reset_session_token
			session[:session_token] = @user.session_token
			redirect_to posts_url
		else
			redirect_to new_session_url
		end
	end

	def destroy
    #HAVE TO TAKE INTO ACCOUNT THE POSSIBILITY FOR THE USER TO BE NIL!!!
    #SHOULD HAVE PUT AN IF/ELSE STATEMENT THAT COVERS IF THE CURRENT USER IS NIL.
		@user = User.find_by_id(params[:user][:id])
		@user.logout
		session[:session_token] = nil
		redirect_to new_session_url

    # Neds solution
    # @user = @current_user
    # if @user.nil?
    #   redirect_to new_session_url
    #   return
    # else
    #   logout_user!(@user)
    #   redirect_to new_session_url
    # end

	end

end
