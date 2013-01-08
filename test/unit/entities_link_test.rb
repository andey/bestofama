# == Schema Information
#
# Table name: entities_links
#
#  id                     :integer          not null, primary key
#  entity_id              :integer
#  entities_links_icon_id :integer
#  title                  :string(255)      not null
#  link                   :string(255)      not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

require 'test_helper'

class EntitiesLinkTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
