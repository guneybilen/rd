class PostsController < ApplicationController
  before_filter :signed_in_user, only: [:create, :destroy]
  before_filter :correct_user, only: :destroy

  def posts_search_autocomplete
     keyword = params[:q]
     h = Array.new
     if (keyword.length > 1)
       @posts = Post.search(keyword)
       @posts.each do |post|
         @posts = h << ({:id => post.content, #this value goes into search_text parameter that is needed in search method in this class
                         :post => post.content.truncate(40, :separator => ' '),
                         :name => post.user.name})
       end
       @posts = @posts.sort_by { |k| k[:name] }

       respond_to do |format|
         format.js
         format.json { render json: @posts }  #autocomplete icin format.json { render json: @jobs} gerekiyor
       end
     end
   end


  def show
    if signed_in?
      @post = current_user.posts.build(params[:post])
    end

    @feed_items = []
    @feed_items << Post.find(params[:id])
    @comments = @feed_items[0].comments.paginate(page: params[:page])
  end

  def search
    if signed_in?
      @post = current_user.posts.build(params[:post])
    end
      @feed_items = Post.search(params[:search_text])
      @feed_items = @feed_items.paginate(page: params[:page])
      render 'static_pages/posts'
  end

  def create
    @post = current_user.posts.build(params[:post])
    if @post.save
      flash[:success] = "Post created!"
      redirect_to root_path
    else
      @feed_items = []

      # asagidaki line StaticPagesController'dan ve @feed_items = [] yerine
      # koydugunda testler break olmuyor. Neden kitap @feed_items = []
      # olani oneriyor anlamadim
      # Nedenini ogrendim (pg 474 - Footnote 11) asagidaki statement'i kullandiginda
      # will_paginate breaks. 'No route matches [GET] "/posts"' hatasi veriyor
      # o hatayi verirken url sunu gosteriyor: http://localhost:3000/posts?page=2
      # @feed_items = current_user.feed.paginate(page: params[:page])

      render 'static_pages/home'
    end
  end

  def destroy
    @post.destroy
    redirect_back_or root_path
  end

  private

  def correct_user
    @post = current_user.posts.find_by_id(params[:id])
    redirect_to root_path if @post.nil?
  end

end