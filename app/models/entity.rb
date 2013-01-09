# == Schema Information
#
# Table name: entities
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  content    :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  slug       :string(255)      not null
#

class Entity < ActiveRecord::Base
  before_save { |entity| entity.slug = entity.slug.parameterize }

  def to_param
    slug
  end

  has_attached_file :avatar, :styles => { :medium => "230x230#", :thumb => "100x100#" }
  attr_accessible :content, :name, :slug, :tag_list, :avatar
  has_and_belongs_to_many :users
  has_many :entities_links
  acts_as_taggable

  validates_presence_of :name, :slug
  validates_uniqueness_of :slug
end
