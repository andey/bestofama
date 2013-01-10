# == Schema Information
#
# Table name: entities
#
#  id                  :integer          not null, primary key
#  name                :string(255)      not null
#  content             :string(255)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  slug                :string(255)      not null
#  avatar_file_name    :string(255)
#  avatar_content_type :string(255)
#  avatar_file_size    :integer
#  avatar_updated_at   :datetime
#  wikipedia_hits      :integer          default(0)
#  link_karma          :integer          default(0)
#  comment_karma       :integer          default(0)
#

require 'test_helper'

class EntityTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
