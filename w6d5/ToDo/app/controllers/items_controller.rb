class ItemsController < ApplicationController
def create
	@item = Item.create!(params[:item])

	respond_to do |format|
		format.json {render :json => @item}
	end
	
end

def destroy
	@item = Item.find_by_id(params[:id])
	@item.destroy
	render :json => @item
end

end
