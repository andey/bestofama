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

class EntitiesLink < ActiveRecord::Base
  attr_accessible :entity_id, :link, :title, :entities_links_icon_id
  validates_presence_of :entity_id, :link, :title, :entities_links_icon_id
  belongs_to :entity
  belongs_to :icon, :class_name => "EntitiesLinksIcon" ,:foreign_key => :entities_links_icon_id
  has_paper_trail
end
