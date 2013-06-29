class SecretsController < ApplicationController
  def index
    respond_to do |format|
      format.html { render :index }
      format.json { render :json => Secret.all }
    end
  end

  def create
    @secret = Secret.create!(params[:secret])

    respond_to do |format|
      format.json { render :json => @secret }
    end
  end
end
