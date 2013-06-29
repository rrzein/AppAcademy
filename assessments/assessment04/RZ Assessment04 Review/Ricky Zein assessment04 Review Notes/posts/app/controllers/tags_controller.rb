class TagsController < ApplicationController

	def create
		@tag = Tag.new(params[:tag])
		@post = Post.find_by_id(params[:tag][:post_id])
		if @tag.save
			redirect_to post_url(@post)
		else
			redirect_to post_url(@post)
		end
	end

	def destroy
		@tag = Tag.find_by_id(params[:id])
		@post = Post.find_by_id(@tag.post_id)
		@tag.destroy
    #you actually don't need to find the specific post, because even though TAG has been destroyed, you can still call @tag.post.
		redirect_to post_url(@post)
	end

end
