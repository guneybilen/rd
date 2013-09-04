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

require 'spec_helper'

describe Comment do
  pending "add some examples to (or delete) #{__FILE__}"
end
