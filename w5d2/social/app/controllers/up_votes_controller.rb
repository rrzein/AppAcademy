class UpVotesController < ApplicationController

  def create
    @vote = UpVote.new(:user_id => current_user.id, :post_id => params[:post_id])
    if @vote.save
      flash[:notice] = "Successfully voted."
      redirect_to feed_user_url(@vote.user)
    else
      flash[:notice] = @vote.errors.full_messages
      redirect_to feed_user_url(@vote.user)
    end
  end

  def destroy
    @vote = UpVote.find(params[:id])

    if @vote.destroy
      flash[:notice] = "Successfully unvoted."
      redirect_to feed_user_url(@vote.user)
    else
      flash[:notice] = "Unable to unvote."
      redirect_to feed_user_url(@vote.user)
    end
  end
end
