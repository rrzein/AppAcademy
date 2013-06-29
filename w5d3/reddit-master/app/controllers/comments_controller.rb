class CommentsController < ApplicationController
  def create
    @link = Link.find(params[:link_id])
    @comment = @link.comments.build(params[:comment])

    if @comment.save
      redirect_to link_url(@link)
    else
      render :new
    end
  end

  def index
    @link = Link.find(params[:link_id])
    @comments = @link.comments
  end

  def new
    @link = Link.find(params[:link_id])
    @comment = Comment.new
  end
end
