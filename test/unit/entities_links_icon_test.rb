# == Schema Information
#
# Table name: entities_links_icons
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  source     :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  regex      :string(255)
#

require 'test_helper'

class EntitiesLinksIconTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
