# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  ama_id     :integer          not null
#  key        :string(255)      not null
#  user_id    :integer          not null
#  content    :text
#  parent_key :string(255)      not null
#  date       :datetime         not null
#  karma      :integer          default(0)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
