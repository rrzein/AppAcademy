class ListsController < ApplicationController

	def index
		@lists = current_user.lists.includes(:items)
	end

	def new
		@list = current_user.lists.new
		render :new
	end

	def create
		@list = current_user.lists.create!(params[:list])

		respond_to do |format|
			format.json { render :json => @list }
		end
	end

end
