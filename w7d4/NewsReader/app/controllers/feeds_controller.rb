class FeedsController < ApplicationController
  def index
    respond_to do |format|
      format.html { render :index }
      format.json { render :json => Feed.all.to_json(:include => :entries) }
    end
  end

  def create
    feed = Feed.find_or_create_by_url(params[:feed][:url])
    if feed
      render :json => feed
    else
      render :json => { error: "invalid url" }, status: :unprocessable_entity
    end
  end

  def refresh
    feed = Feed.find_by_id(params[:id])
    feed.reload
    feed.save!
    render :json => feed.to_json(:include => :entries)
  end
end
