class PhotosController < ApplicationController

  def create
    @photo = current_user.photos.create!(params[:photo])
    render :json => @photo
  end

  def index
    @photos = current_user.photos

    respond_to do |format|
      format.html { render :index }
      format.json { render :json => @photos }
    end
  end

  def show
    @photo = Photo.find(params[:id])

    render :json => @photo
  end

  def destroy
    @photo = Photo.find(params[:id])
    @photo.destroy

    @photos = current_user.photos
    render :json => @photos
  end
end
