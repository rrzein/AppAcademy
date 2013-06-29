class ItemsController < ApplicationController
	def show
		@item = Item.find_by_id(params[:id])
		render :show
	end

	def new
		@item = Item.new
		render :new
	end

	def create
		@item = Item.new(params[:item])

		if @item.save
			notices << "Item successfully saved."
			redirect_to item_url(@item)
		else
			errors << "Failed to save item."
			errors << @item.errors.full_messages
			render :new
		end
	end

	def edit
		@item = Item.find_by_id(params[:id])
		render :edit
	end

	def update
		@item = Item.find_by_id(params[:id])

		if @item.update_attributes(params[:item])
			notices << "Item edited successfully."
			redirect_to item_url(@item)
		else
			errors << "Could not edit item."
			errors << @item.errors.full_messages
			redirect_to :edit
		end
	end

end
