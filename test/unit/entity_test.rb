# == Schema Information
#
# Table name: entities
#
#  id             :integer          not null, primary key
#  name           :string(255)      not null
#  wikipedia_slug :string(255)
#  content        :string(255)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  slug           :string(255)      not null
#

require 'test_helper'

class EntityTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
