class LinksController < ApplicationController
  before_filter :require_user!
  before_filter :require_owner!, :only => [:edit, :update]

  def create
    @link = current_user.links.build(params[:link])
    if @link.save
      redirect_to link_url(@link)
    else
      render :new
    end
  end
  
  def edit
    @link = Link.find(params[:id])
  end
  
  def new
    @link = Link.new
  end
  
  def show
    @link = Link.find(params[:id])
  end
  
  def update
    @link = Link.find(params[:id])
    if @link.update_attributes(params[:link])
      redirect_to link_url(@link)
    else
      render :new
    end
  end
  
  private
  def require_owner!
    @link = Link.find(params[:id])
    
    return if @link.nil?
    unless @link.owner == current_user
      render :text => "Unauthorized", :status => 403
    end
  end
end
