# == Schema Information
#
# Table name: ops
#
#  id                  :integer          not null, primary key
#  name                :string(255)      not null
#  content             :text
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
#  avatar_source       :string(255)
#

class Op < ActiveRecord::Base
  include NestedUser

  # Hooks
  before_validation :default_slug, :download_avatar
  after_save :update_taggings

  # Validations
  attr_accessor :avatar #Paperclip
  validates_presence_of :name, :slug
  validates_uniqueness_of :slug

  # can be tagged using "acts_as_taggable" gem
  acts_as_taggable

  # paper_trail gem to record changes
  has_paper_trail :ignore => [:updated_at, :wikipedia_hits, :comment_karma, :link_karma, :tag_list]

  # paperclip gem to store avatars, in the following sizes
  has_attached_file :avatar, :styles => {:medium => "230x230#", :thumb => "100x100#"}

  # Basic Relations
  has_many :amas, through: :users
  has_many :participated, through: :users, source: :amas_participated
  has_many :comments, through: :users

  # Link Relations
  has_many :links, :class_name => 'OpsLink'
  accepts_nested_attributes_for :links, :allow_destroy => true, :reject_if => lambda { |l| l[:link].blank? }

  # When the avatar source is changed, download the image
  def download_avatar
    if self.avatar_source_changed? && !self.avatar_source.empty?
      self.avatar = open(self.avatar_source)
    end
  end

  # How to deal with link nested attributes
  def links_attributes=(links)
    links.values.each do |params|
      link = OpsLink.find_or_create_by(link: params[:link])
      params[:_destroy].to_i == 1 ? self.remove_link(link) : self.add_link(link)
    end
  end

  # Add an link to OP
  def add_link(link)
    self.links << link unless self.links.include?(link)
  end

  # Remove link from OP
  def remove_link(link)
    self.links.destroy(link)
  end

  # User Relations
  has_and_belongs_to_many :users
  accepts_nested_attributes_for :users, :allow_destroy => true, :reject_if => lambda { |l| l[:username].blank? }

  # default id
  def to_param
    slug
  end

  private

  # Create a OP slug
  def default_slug
    if self.slug.nil? || self.slug.empty?
      self.slug = self.name.parameterize
    end
  end

  # Update Tagging's karma
  def update_taggings
    self.taggings.each do |tagging|
      tagging.update_attribute(:karma, self.comment_karma)
    end
  end
end
