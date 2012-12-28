# == Schema Information
#
# Table name: admins
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class Admin::AdminTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
