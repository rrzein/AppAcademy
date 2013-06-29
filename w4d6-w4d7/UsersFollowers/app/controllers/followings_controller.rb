class FollowingsController < ApplicationController
  def index
    @user = User.find_by_id(params[:user_id])
    @all_users = User.where("id != ?", @user.id)
    render :index
  end

  def create
    @user = User.find_by_id(params[:user_id])
    @followee = User.find_by_id(params[:following][:user_id])
    @following = @user.follow_user(@followee)
    if @following.save
      redirect_to user_followings_url(@user)
    else
      render :json => "Could not follow user"
    end
  end

  # def show
  #   @user = User.find_by_id(params[:user_id])
  #   @following = Following.find_by_id(params[:id])
  #   render :show
  # end

  def destroy
    @user = User.find_by_id(params[:user_id])
    @following = Following.find_by_id(params[:id])
    @following.destroy
    redirect_to user_followings_url(@user)
  end

end
