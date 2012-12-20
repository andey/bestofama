class Entity < ActiveRecord::Base
  def to_param
    slug
  end

  attr_accessible :content, :name, :slug, :wikipedia_slug, :tag_list
  has_and_belongs_to_many :users
  acts_as_taggable

  validates_presence_of :name, :slug, :wikipedia_slug
  validates_uniqueness_of :slug, :wikipedia_slug
end
