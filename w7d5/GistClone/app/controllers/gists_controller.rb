# { gist: {title: 'a', body: 'b'}}


# { title: 'a', body: 'b'}

# Controller name
# Model Name = Gist
# Gist's attr_accessible
# Add to params: gist: { title: 'a', body: 'b'}

# params = { gist: {title: 'a', body: 'b'}}
# params[:gist] = { title: 'a', body: 'b'}


class GistsController < ApplicationController

  def index
    @gists = current_user.gists
    render :json => @gists.to_json(:include => :favorites)
  end

  def show
    @gist = Gist.find(params[:id])
    render :json => @gist
  end

  def new
    @gist = Gist.new
    render :json => @gist
  end

  def create
    @gist = current_user.gists.new(params[:gist])
    if @gist.save
      render :json => @gist
    else
      render :json => @gist.errors.full_messages
    end
  end

  def edit
    @gist = Gist.find(params[:id])
    render :json => @gist
  end

  def update
    @gist = Gist.find(params[:id])
    if @gist.update_attributes
      render :json => @gist
    else
      render :json => @gist.errors.full_messages
    end
  end

  def destroy
    @gist = Gist.find(params[:id])
    @gist.destroy
    render :json => nil
  end

end
