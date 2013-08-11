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
  validates :user_id, presence: true

  belongs_to :user
end

