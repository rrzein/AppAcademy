class SubscriptionPlansController < ApplicationController
	def index
	end

	def show
		@plan = SubscriptionPlan.find_by_id(params[:id])
		render :show
	end

	def new
		@plan = SubscriptionPlan.new
		@newspaper = Newspaper.find_by_id(params[:newspaper_id])
		render :new
	end

	def create
		@plan = SubscriptionPlan.new(params[:subscription_plan])
		@newspaper = Newspaper.find_by_id(params[:newspaper_id])
		@plan.newspaper = @newspaper

		if @plan.save
			notices << "Plan created successfully."
			redirect_to subscription_plan_url(@plan)
		else
			errors << "Could not create plan."
			errors << @plan.errors.full_messages
			render :new
		end
	end

	def edit
	end

	def update
	end

	def destroy
	end

end
