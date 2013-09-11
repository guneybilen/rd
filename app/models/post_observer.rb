class PostObserver < ActiveRecord::Observer
  def after_create(post)
    Notifier.post_added(post).deliver if (Rails.env.production? || Rails.env.development?)
  end
end
