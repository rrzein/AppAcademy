class ProjectsController < ApplicationController
	def show
		@project = Project.find_by_id(params[:id])
		render :show
	end

	def new
		@project = Project.new
		render :new
	end

	def create
		@project = Project.new(params[:project])

		if @project.save
			notices << "Project successfully saved."
			redirect_to project_url(@project)
		else
			errors << "Error saving project:"
			errors += @project.errors.full_messages
			render :new
		end
	end

end
