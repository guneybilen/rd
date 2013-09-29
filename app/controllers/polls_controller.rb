require 'will_paginate/array'

class PollsController < ApplicationController

  def index
    #puts "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ #{params[:whereabouts].to_s}"

    if params[:whereabouts].to_s == "home"
      puts "FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF"

      @poll_posts = []

      if current_user.followed_users.count == 1
        @poll_posts = Post.find_by_sql(["SELECT * FROM posts WHERE created_at > ? AND user_id = ?",
                  Time.at(params[:after].to_i + 50), current_user.followed_users ])
                  .paginate(page: params[:page])
        @poll_posts_count = @poll_posts.count
      end

      if current_user.followed_users.count > 1
      @poll_posts = Post.find_by_sql(["SELECT * FROM posts WHERE created_at > ? AND user_id IN (?)",
          Time.at(params[:after].to_i + 50), current_user.followed_users ])
          .paginate(page: params[:page])
      @poll_posts_count = @poll_posts.count
      end

        #if @poll_posts!=[[]]
        #  puts @poll_posts
        #  @poll_posts.paginate(page: params[:page])
        #  @poll_posts_count = @poll_posts.count
        #else
        #  @poll_posts = ""
        #end
    end

    if params[:whereabouts].to_s == "posts"
      @poll_posts = Post.where("created_at > ?", Time.at(params[:after].to_i + 50))
                      .paginate(page: params[:page])
      @poll_posts_count = @poll_posts.count
    end

     unless current_user.nil?
      #puts "^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ #{@poll_posts.last.user.name}"
      @result = current_user.posts.include?(Post.first)
      #puts "################################################### " + @result.to_s
     end

  end
end
