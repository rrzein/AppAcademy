class SecretsController < ApplicationController
  def index
    respond_to do |format|
      format.html { render :index }
      format.json { render :json => Secret.all }
    end
  end

  def new
    @secret = current_user.authored_secrets.new
    render :new
  end

  def create
    @secret = current_user.authored_secrets.create!(params[:secret])

    respond_to do |format|
      format.json { render :json => @secret }
    end
  end
end
