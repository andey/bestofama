class Comment < ActiveRecord::Base
  attr_accessible :ama_id, :content, :date, :key, :parent_id, :parent_key, :user_id, :karma
  belongs_to :user
  validates_presence_of :ama_id, :key, :parent_key, :user_id
  validates_uniqueness_of :key
end
