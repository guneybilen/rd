class CommentsController < ApplicationController

  # NoMethodError (undefined method `stringify_keys' for "298":String):
  # app/controllers/comments_controller.rb:9:in `create'
  # hatasi aliyorsan parametreyi su sekilde
  # gecir: .create(comment: params[:comment])

  def create
    sleep 2
    if signed_in?
      if params[:comment].blank?
        flash.now[:error] = "Comment cannot be blank!"
      else
        flash.now[:success] = "Comment created!"
      end
      @post = Post.find(params[:feed_item_id])
      @i_is_for_comments_partial = params[:i]
      @comment = @post.comments.create(comment: params[:comment], user_id: params[:user_id])
      @feed_items = current_user.feed.paginate(page: params[:page])
      @hash = Hash.new
      @feed_items.each do |feed_item|
        feed_item.comments.each do |comment|
          @hash["#{feed_item}"] = feed_item.comments.to_a
        end
      end

      respond_to do |format|
        format.html { redirect_to root_path }
        format.js
      end

    else

      redirect_to signin_path

    end
  end

  def destroy
      @post = Comment.find(params[:id]).post
      Comment.find(params[:id]).destroy

      respond_to do |format|
        format.js
      end
  end
end
