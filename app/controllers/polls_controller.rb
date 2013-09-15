class PollsController < ApplicationController

def index
  puts "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ #{params[:after].to_i}"
  @poll_posts = Post.where("created_at > ?", Time.at(params[:after].to_i))
end

end
