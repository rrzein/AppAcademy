class UsersController < ApplicationController


	def new
		@user = User.new
		render :new
	end

	def create
		@user = User.new(params[:user])
		@password = params[:user][:password]

		if @user.save
      #watch out for this in the future. on this one, you are automatically
      #assigning the user a session token so he can log in once he creates
      #an account
			@user.reset_session_token
			session[:session_token] = @user.session_token
			redirect_to posts_url
		else
			flash[:errors] ||= []
			flash[:errors] << @user.errors.full_messages
			redirect_to new_user_url
		end
	end

end
