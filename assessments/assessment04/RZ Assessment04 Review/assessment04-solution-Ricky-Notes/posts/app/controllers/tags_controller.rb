class TagsController < ApplicationController
  def create
    tag = Tag.create!(params[:tag])
    
    redirect_to post_url(tag.post)
  end
  
  def destroy
    tag = Tag.find(params[:id])
    tag.destroy
    
    redirect_to post_url(tag.post)
  end
end
