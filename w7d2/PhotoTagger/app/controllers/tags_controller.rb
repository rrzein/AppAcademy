class TagsController < ApplicationController

  def create
    @photo = Photo.find(params[:id])
    @tag = @photo.tags.create!(params[:tag])

    render :json => @photo.tags
  end

  def destroy
    @tag = Tag.find(params[:id])
    @tag.delete
    render :json => @tag.photo
  end

  def index
    @photo = Photo.find(params[:id])

    render :json => @photo.tags
  end
end
