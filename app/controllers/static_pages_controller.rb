class StaticPagesController < ApplicationController

  def home
    if signed_in?
      @post = current_user.posts.build if signed_in?
      @feed_items = current_user.feed.paginate(page: params[:page])
      @hash = Hash.new
      @feed_items.each do |feed_item|
      feed_item.comments.each do |comment|
          @hash["#{feed_item}"] = feed_item.comments.to_a
      end
    end
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
    @hash = Hash.new
    @feed_items.each do |feed_item|
      feed_item.comments.each do |comment|
          @hash["#{feed_item}"] = feed_item.comments.to_a
      end
    end
  end

end
