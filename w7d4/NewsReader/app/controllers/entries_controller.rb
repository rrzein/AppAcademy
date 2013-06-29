class EntriesController < ApplicationController
  def index
    feed = Feed.find(params[:feed_id])
    feed.reload
    feed.save!
    render :json => feed.entries
  end
end
