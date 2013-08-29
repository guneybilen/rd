class CommentsController < ApplicationController

  def create
    if signed_in?
      @post = Post.find(params[:feed_item_id])
      @comment = @post.comments.create(params[:post])
      redirect_to root_path
    else
      redirect_to signin_path
    end
  end

end
