class StaticPagesController < ApplicationController

  def home
    if signed_in?
      @post = current_user.posts.build if signed_in?
      @feed_items = current_user.feed.paginate(page: params[:page])
    else
      redirect_to signin_path
    end
  end

  def help
  end

  def about
  end

  def contact
  end

  def posts
    @post = current_user.posts.build if signed_in?
    @feed_items = Post.paginate(page: params[:page])

  end

end
