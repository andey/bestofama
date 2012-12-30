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

class Entity < ActiveRecord::Base
  before_save { |entity| entity.slug = entity.slug.parameterize }

  def to_param
    slug
  end

  attr_accessible :content, :name, :slug, :wikipedia_slug, :tag_list
  has_and_belongs_to_many :users
  acts_as_taggable

  validates_presence_of :name, :slug, :wikipedia_slug
  validates_uniqueness_of :slug, :wikipedia_slug
end
