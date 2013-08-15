class PostsController < ApplicationController
  before_filter :signed_in_user, only: [:create, :destroy]

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

  end

end