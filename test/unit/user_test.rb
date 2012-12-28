# == Schema Information
#
# Table name: users
#
#  id                :integer          not null, primary key
#  username          :string(255)      not null
#  modhash           :string(255)
#  active            :boolean          default(FALSE)
#  comment_karma     :integer          default(0)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  link_karma        :integer          default(0)
#  persistence_token :string(255)
#

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
