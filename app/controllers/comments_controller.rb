class CommentsController < ApplicationController

  def create
    if signed_in?
      @post = Post.find(params[:id])
      @comment = @post.comments.create(params[:comments])
      render 'users/show'
    else
      redirect_to signin_path
    end
  end
end
