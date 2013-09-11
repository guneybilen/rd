class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper
  before_filter :set_current_user

   # to get current user from Notifier.rb; gotten from Internet
   def set_current_user
     User.current = current_user
   end
   # see User.rb for its counterpart. 2 parts total.
   ############################################################

=begin
  before_filter :feed

  def feed
    if signed_in?
    @feed_items = current_user.feed.paginate(page: params[:page])
    @hash = Hash.new
    @feed_items.each do |feed_item|
    feed_item.comments.each do |comment|
        @item = feed_item.id
        @hash["#{feed_item}"] = feed_item.comments.to_a
      end
    end
    else
      redirect_to root_path
    end
  end
=end
end
