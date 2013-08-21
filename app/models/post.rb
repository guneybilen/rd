# == Schema Information
#
# Table name: posts
#
#  id         :integer         not null, primary key
#  content    :string(5000)
#  user_id    :integer
#  created_at :datetime        not null
#  updated_at :datetime        not null
#
class Post < ActiveRecord::Base
  attr_accessible :content

  validates :content, presence: true, length: { maximum: 5000 }
  validates :user_id, presence: true

  belongs_to :user

  default_scope order: "posts.created_at DESC"

  def self.from_users_followed_by(user)
    followed_user_ids = "SELECT followed_id FROM relationships
                         WHERE follower_id = :user_id"
    where("user_id IN (#{followed_user_ids}) OR user_id = :user_id", user_id: user.id)
  end

end

