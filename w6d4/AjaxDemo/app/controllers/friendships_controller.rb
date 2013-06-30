class FriendshipsController < ApplicationController

  def create
    @friendship = current_user.friendships.new(:hero_id => params[:id])

    if @friendship.save
      render :json => true
    else
      render :json => false
    end
  end

  def destroy
    @friendship = current_user.friendships.find_by_hero_id(params[:id])
    @friendship.destroy
    render :json => true

  end

end
