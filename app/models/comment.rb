class Comment < ActiveRecord::Base
  attr_accessible :comment, :failure, :post_id, :success

  belongs_to :post

  validates :post_id, :presence => true
  validates :comment, :presence => true
  validates :success, :numericality => true
  validates :failure, :numericality => true

  default_scope order: "comments.created_at DESC"
end
