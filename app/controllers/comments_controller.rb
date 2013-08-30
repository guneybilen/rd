class CommentsController < ApplicationController

  def create
    if signed_in?
      @post = Post.find(params[:feed_item_id])
      @comment = @post.comments.create(comment: params[:comment])
      flash[:success] = "Comment created!"
      redirect_to root_path
    else
      redirect_to signin_path
    end
  end

end
