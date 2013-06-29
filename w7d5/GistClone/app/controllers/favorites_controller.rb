class FavoritesController < ApplicationController

  def index
    @favorites = current_user.favorites
    render :json => @favorites
  end

  def create
    @favorite = current_user.favorites.new(:gist_id => params[:id])
    if @favorite.save
      render :json => @favorite
    else
      render :json => @favorite.error.full_messages
    end
  end

  def destroy
    @favorite = Favorite.find_by_gist_id(params[:id])
    @favorite.destroy
    render :json => nil
  end

end
