class UsersController < ApplicationController
	def show
		@user = User.find_by_id(params[:id])
		render :show
	end

	def new
		@user = User.new
		render :new
	end

	def create
		@user = User.new(params[:user])

		if @user.save
			notices << "User saved successfully."
			redirect_to user_url(@user)
		else
			errors << "Could not create account."
			render :new
		end
	end

	def edit
		@user = User.find_by_id(params[:id])
		render :edit
	end

	def update
		@user = User.find_by_id(params[:id])

		if @user.update_attributes(params[:user])
			notices << "User updated successfully."
			redirect_to user_url(@user)
		else
			errors << "Could not update user."
			render :edit
		end
	end

end
