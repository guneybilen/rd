# == Schema Information
#
# Table name: comments
#
#  id         :integer         not null, primary key
#  post_id    :integer         not null
#  user_id    :integer         not null
#  comment    :text(3000)
#  success    :integer         default(0)
#  failure    :integer         default(0)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class Comment < ActiveRecord::Base
  # Asagida :user_id'yi eklemeyi unutursan soyle bir hata aliyorsun: (Hic alakasiz bir hata! ve line numarasida yanlis.)
  #ActiveRecord::StatementInvalid (SQLite3::Exception: cannot use a closed statement: SELECT  "posts".* FROM "posts"  WHERE "posts"."id" = ? ORDER BY posts.created_at DESC LIMIT 1):
  #app/controllers/comments_controller.rb:10:in `create'
  attr_accessible :comment, :user_id, :post_id, :failure, :success

  belongs_to :post
  belongs_to :user

  validates :post_id, :presence => true
  validates :user_id, :presence => true
  validates :comment, :presence => true
  validates :success, :numericality => true
  validates :failure, :numericality => true

  default_scope order: "comments.created_at DESC"

end
