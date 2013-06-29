class FriendCirclesController < ApplicationController
  def index

  end

  def new
    @current_user = current_user
    @users = User.where("id != ?", @current_user.id)
    #could also do User.all - [current_user]
    @circle = FriendCircle.new
    render :new_friend_circle
  end

  def create
    @circle = FriendCircle.new(params[:friend_circle])
    @circle.user = current_user
    #prefer -- 1 line instead of 2.
    # @circle = current_user.friend_circles.build(params[:circle])

    if @circle.save
      flash[:notice] = "Friend circle created."
      redirect_to friend_circle_url(@circle)
    else
      flash[:notice] = "Unable to create friend circle."
      render :new
    end
  end

  def show
    @circle = FriendCircle.find(params[:id])
    @circle.user = current_user
    render :show_friend_circle
  end

  def edit
    @current_user = current_user
    @users = User.where("id != ?", @current_user.id)
    @circle = FriendCircle.find(params[:id])

    render :edit_friend_circle
  end

  def update
    @circle = FriendCircle.find(params[:id])
    if @circle.update_attributes(params[:friend_circle])
      flash[:notice] = "Friend circle updated successfully."
      redirect_to friend_circle_url(@circle)
    else
      flash[:notice] = "Unable to update friend circle."
      render :edit_friend_circle
    end
  end

end
