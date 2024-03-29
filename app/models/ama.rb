# == Schema Information
#
# Table name: amas
#
#  id         :integer          not null, primary key
#  key        :string(255)      not null
#  date       :datetime         not null
#  title      :string(255)      not null
#  content    :text
#  karma      :integer          default(0)
#  user_id    :integer          not null
#  permalink  :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  comments   :integer          default(0)
#  responses  :integer          default(0)
#

require 'api/reddit.com'

class Ama < ActiveRecord::Base
  include NestedUser
  include AmaProcessing

  # Basic validations
  validates_presence_of :key, :permalink, :title, :user_id
  validates_uniqueness_of :key

  # has one "user" as the owner of the AMA
  belongs_to :user, :touch => true

  # has many "users", that are guest speakers
  has_and_belongs_to_many :users
  accepts_nested_attributes_for :users, :allow_destroy => true, :reject_if => lambda { |l| l[:username].blank? }

  # can be tagged using "acts_as_taggable" gem
  acts_as_taggable

  # AMA 'comments'
  # These are expensive queries. Faster to run Comment.where(parent_key: comment.key, relevant: true).order(:karma).reverse_order
  has_many :children, -> { order('karma DESC') }, class_name: 'Comment', primary_key: :key, foreign_key: :parent_key
  has_many :relevant_children, -> { where(relevant: true).order('karma DESC') }, class_name: 'Comment', primary_key: :key, foreign_key: :parent_key

  # AMA Archives
  has_many :archives, :dependent => :destroy

  # Who's the OP who hosted?
  has_many :ops, through: :user

  # Who are the guest OPs?
  has_many :ops_participated, through: :users, source: :ops

  # paper_trail gem to record changes to content attribute
  has_paper_trail :only => :content, :on => [:update, :destroy]

  # Update tagging karma score
  after_save :update_taggings

  # Moderation Queue
  scope :queue, -> { where('amas.id NOT IN ( SELECT taggable_id from taggings ) AND amas.user_id NOT IN ( SELECT user_id from ops_users )') }

  # Tagless AMAs
  scope :tagless, -> { where 'amas.id NOT IN ( SELECT taggable_id from taggings )' }

  # Opless AMAs
  scope :opless, -> { where 'amas.user_id NOT IN ( SELECT user_id from ops_users )' }

  # Without Comments
  scope :responseless, -> { where 'amas.responses <= 0' }

  def to_param
    key
  end

  # Trash an AMA
  def trash
    Comment.where(:ama_id => self.id).destroy_all
    Trash.create(:key => self.key)
    self.destroy
  end

  protected

  # Update Tagging's karma
  def update_taggings
    self.taggings.each do |tagging|
      tagging.update_attribute(:karma, self.karma)
    end
  end

  # Is the username an OP or a notable participant?
  def is_op?(username)
    username == self.user.username || self.users.any? { |u| u.username == username }
  end

end
