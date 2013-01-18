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

class EntitiesLinksIcon < ActiveRecord::Base
  attr_accessible :name, :source, :regex
  has_many :entities_links
end
