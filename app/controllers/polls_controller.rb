class PollsController < ApplicationController

def index
  puts "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ #{params[:after].to_i}"
  @poll_posts = Post.where("created_at > ?", Time.at(params[:after].to_i + 50))

  unless current_user.nil?
    i=0
    @result =[]
    puts @poll_posts.nil?
    @poll_posts.each do |poll_post|
    @result[i] = current_user.posts.include?(poll_post)
    puts "################################################### " + @result[i].to_s
    i += 1
    end

    if @result.last == true
     @hide_poll = true
   end
  end

end
end
