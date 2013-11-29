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
require 'iron_worker_ng'

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
  has_many :children, -> { where order: 'karma DESC' }, class_name: 'Comment', primary_key: :key, foreign_key: :parent_key

  # AMA Archives
  has_many :archives

  # paper_trail gem to record changes to content attribute
  has_paper_trail :only => :content, :on => [:update, :destroy]

  # Update OP caches
  # after_save :update_ops

  # Update tagging karma score
  after_save :update_taggings, :build_cache

  # Moderation Queue
  scope :queue, -> { where('amas.id NOT IN ( SELECT taggable_id from taggings ) AND amas.user_id NOT IN ( SELECT user_id from ops_users )').order(:karma).reverse_order }

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

  # After an AMA is updated,
  # update all associated entities.
  # Which ultimately updates entity.cache_key
  def update_ops

    # Owner entity
    self.user.ops.each do |e|
      e.touch
    end

    # Entities participating
    self.users.each do |u|
      u.ops.each do |e|
        e.touch
      end
    end

  end

  # Update Tagging's karma
  def update_taggings
    self.taggings.each do |tagging|
      tagging.update_attribute(:karma, self.karma)
    end
  end

  # Rebuild view cache on update
  def build_cache
    begin
      if Rails.env != 'test'
        client = IronWorkerNG::Client.new(token: ENV['IRON_CACHE_TOKEN'], project_id: ENV['IRON_CACHE_PROJECT_ID'])
        client.tasks.create('build_cache', :ama => self.key)
      end
    end
  end


  # Is the username an OP or a notable participant?
  def is_op?(username)
    username == self.user.username || self.users.any? { |u| u.username == username }
  end

end
