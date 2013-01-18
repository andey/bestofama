# == Schema Information
#
# Table name: entities_links
#
#  id                     :integer          not null, primary key
#  entity_id              :integer
#  entities_links_icon_id :integer
#  link                   :string(255)      not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

require 'uri'
class EntitiesLink < ActiveRecord::Base
  attr_accessible :entity_id, :link, :entities_links_icon_id
  validates_format_of :link, :with => URI.regexp
  validates_presence_of :entity_id, :link, :entities_links_icon_id

  belongs_to :entity
  belongs_to :icon, :class_name => "EntitiesLinksIcon", :foreign_key => :entities_links_icon_id

  has_paper_trail

  before_validation :find_entities_links_icon

  private
  # Make sure the link submitted matches a REGEX of an icon.
  # If no match is found, self.entities_links_icon_id will not be assigned.
  # Therefore the validation will fail, rejecting the save
  def find_entities_links_icon
    EntitiesLinksIcon.all.each do |icon|
      reg = Regexp.new(icon.regex)
      if reg.match(self.link)
        self.entities_links_icon_id = icon.id
      end
    end
  end
end
