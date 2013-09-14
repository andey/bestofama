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

class Ama < ActiveRecord::Base

  # Basic validations
  validates_presence_of :key, :permalink, :title, :user_id
  validates_uniqueness_of :key

  # has one "user" as the owner of the AMA
  belongs_to :user, :touch => true

  # has many "users", that are guest speakers
  has_and_belongs_to_many :users

  # can be tagged using "acts_as_taggable" gem
  acts_as_taggable

  # AMA 'comments'
  has_many :children, -> { where order: 'karma DESC' }, class_name: 'Comment', primary_key: :key, foreign_key: :parent_key

  # paper_trail gem to record changes to content attribute
  has_paper_trail :only => :content, :on => [:update, :destroy]

  # Update OP caches
  after_save :update_ops

  # Update tagging karma score
  after_save :update_taggings

  def to_param
    key
  end

  private

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
end
