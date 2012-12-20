class Ama < ActiveRecord::Base
  attr_accessible :content, :date, :karma, :key, :permalink, :comments, :responses, :title, :user_id
  belongs_to :user
  validates_presence_of :key, :permalink, :title, :user_id
  validates_uniqueness_of :key
end
