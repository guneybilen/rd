class CommentsController < ApplicationController

  # NoMethodError (undefined method `stringify_keys' for "298":String):
  # app/controllers/comments_controller.rb:9:in `create'
  # hatasi aliyorsan parametreyi su sekilde
  # gecir: .create(comment: params[:comment])

  def create
    if signed_in?
      @post = Post.find(params[:feed_item_id])
      @i_is_for_comments_partial = params[:i]
      @comment = @post.comments.create(comment: params[:comment])
      @feed_item = @post
      puts "<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< #{@post.id}"
      @feed_items = current_user.feed.paginate(page: params[:page])
      #@feed_items = @feed_items.reload
      @hash = Hash.new
      @feed_items.each do |feed_item|
        #puts "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ #{@hash[293].nil?}"
        #if feed_item.id.to_s == '293'
        feed_item.comments.each do |comment|
          puts feed_item
          @hash["#{feed_item}"] = feed_item.comments.to_a
        end
          #end
      end
      puts "$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ #{@feed_item.id}"

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
