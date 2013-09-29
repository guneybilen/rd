class PollsController < ApplicationController

  def index
    #puts "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ #{params[:after].to_i}"
    @poll_posts = Post.where("created_at > ?", Time.at(params[:after].to_i + 50))
                      .paginate(page: params[:page])

    @poll_posts_count = @poll_posts.count

     unless current_user.nil?
      #puts "^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ #{@poll_posts.last.user.name}"
      @result = current_user.posts.include?(Post.first)
      #puts "################################################### " + @result.to_s
    end

  end
end
