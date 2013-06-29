class UsersController < ApplicationController
  before_filter :authenticate_user
  before_filter :authorize_profile_page, :only => [:show]

  def show
    puts current_user
    @user = User.find_by_id(params[:id])
    render :show
  end

  def new
    render :new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to user_url(@user)
    else
      redirect_to new_user_url
    end
  end

  def edit
  end

  def update
  end

  def destroy

  end


end
