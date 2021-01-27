class CommentsController < ApplicationController
	before_action :authenticate_user!
	before_action :require_user, :only => [:destroy]

	def create
		@post = Post.find(params[:post_id])
	 	@comment = @post.comments.create(params[:comment].permit(:name, :comment))
		redirect_to post_path(@post)	
	end

	def destroy
		@post = Post.find(params[:post_id])
		@comment = @post.comments.find(params[:id])
		@comment.destroy
		redirect_to post_path(@post)
	end

	private 
  	def require_user
  		@post = Post.find(params[:post_id])
  		@comment = @post.comments.find(params[:id])
	    redirect_to root_url unless current_user.username == @comment.name
  	end
end
