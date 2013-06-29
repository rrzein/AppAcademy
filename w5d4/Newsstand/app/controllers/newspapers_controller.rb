class NewspapersController < ApplicationController
	def show
		@newspaper = Newspaper.find_by_id(params[:id])
		render :show
	end

	def new
		@newspaper = Newspaper.new
		2.times { @newspaper.plans.build }
		render :new
	end

	def create
		@newspaper = Newspaper.new(params[:newspaper])
		@editor = User.find_by_name(params[:editor][:name])
		@newspaper.editor = @editor

		if @newspaper.save
			notices << "Newspaper created successfully."
			redirect_to newspaper_url(@newspaper)
		else
			hjl ;jkl
			(2 - @newspaper.plans.length).times do
				@newspaper.plans.build
			end
			notices << "Could not create newspaper."
			notices << @newspaper.errors.full_messages
			render :new
		end
	end

end
