# == Schema Information
#
# Table name: ops
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

class Op < ActiveRecord::Base
  before_validation :default_slug
  before_save { |op| op.slug = op.slug.parameterize }
  after_save :update_taggings

  # default id
  def to_param
    slug
  end

  #attr_accessible :content, :name, :slug, :tag_list, :avatar, :wikipedia_hits, :link_karma, :comment_karma, :entities_links_attributes
  attr_accessor :avatar
  validates_presence_of :name, :slug
  validates_uniqueness_of :slug

  # Associating OP social profile links
  has_many :links, :class_name => 'OpsLink'
  has_many :amas, through: :users
  has_many :comments, through: :users
  has_many :taggings, foreign_key: :taggable_id

  has_and_belongs_to_many :users
  #accepts_nested_attributes_for :entities_links, :reject_if => lambda { |a| a[:link].blank? }, :allow_destroy => true

  # can be tagged using "acts_as_taggable" gem
  acts_as_taggable

  # paper_trail gem to record changes
  has_paper_trail :ignore => [:updated_at, :wikipedia_hits, :comment_karma, :link_karma, :tag_list]

  # paperclip gem to store avatars, in the following sizes
  has_attached_file :avatar, :styles => {:medium => "230x230#", :thumb => "100x100#"}

  # Create a OP slug
  def default_slug
    if self.slug.nil? || self.slug.empty?
      self.slug = self.name
    end
  end

  # Update Tagging's karma
  def update_taggings
    self.taggings.each do |tagging|
      tagging.update_attribute(:karma, self.comment_karma)
    end
  end
end
