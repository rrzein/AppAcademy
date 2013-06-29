class UsersController < ApplicationController
  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      login(@user)
      redirect_to photos_url(@user)
    else
      render :new
    end
  end

  def index
    @user = current_user.to_json(:include => [:photos, :friends])
    render :json => @user
  end

  def show
    @user = User.find(params[:id])
    render :json => @user
  end

end
