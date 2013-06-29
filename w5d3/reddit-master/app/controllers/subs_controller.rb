class SubsController < ApplicationController  
  before_filter :require_user!
  before_filter :require_moderator!, :only => [:edit, :update]
  
  def create
    @sub = current_user.subs.build(params[:sub])
    if @sub.save
      redirect_to sub_url(@sub)
    else
      render :new
    end
  end
  
  def edit
    @sub = Sub.find(params[:id])
  end
  
  def index
    @subs = Sub.all
    render :json => @subs
  end
  
  def new
    @sub = Sub.new
    5.times { @sub.links.build }
  end
  
  def show
    @sub = Sub.find(params[:id])
    
    render :json => @sub
  end
  
  def update
    @sub = Sub.find(params[:id])
    if @sub.update_attributes(params[:sub])
      redirect_to sub_url(@sub)
    else
      render :edit
    end
  end

  private
  def correct_user!
    @sub = Sub.find(params[:id])
    redirect_to root_url unless @sub.moderator == current_user
  end

  def require_moderator!
    @sub = Sub.find(params[:id])

    return if @sub.nil?
    unless @sub.moderator == current_user
      render :text => "Unauthorized", :status => 403
    end
  end
end
