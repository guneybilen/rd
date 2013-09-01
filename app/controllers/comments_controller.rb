class CommentsController < ApplicationController

  # NoMethodError (undefined method `stringify_keys' for "298":String):
  # app/controllers/comments_controller.rb:9:in `create'
  # hatasi aliyorsan parametreyi su sekilde
  # gecir: .create(comment: params[:comment])

  def create
    if signed_in?
      @post = Post.find(params[:feed_item_id])
      @comment = @post.comments.create(comment: params[:comment])
      @feed_items = current_user.feed.paginate(page: params[:page])
      @hash = Hash.new
      @feed_items.each do |feed_item|
      feed_item.comments.each do |comment|
          @hash["#{feed_item}"] = feed_item.comments.to_a
        end
      end

      flash[:success] = "Comment created!"

      respond_to do |format|
        format.html { redirect_to root_path }
        format.js
      end

    else
      redirect_to signin_path
    end
  end

end
