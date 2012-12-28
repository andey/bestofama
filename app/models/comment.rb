# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  ama_id     :integer          not null
#  key        :string(255)      not null
#  user_id    :integer          not null
#  content    :text
#  parent_key :string(255)      not null
#  date       :datetime         not null
#  karma      :integer          default(0)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  parent_id  :integer
#

class Comment < ActiveRecord::Base
  attr_accessible :ama_id, :content, :date, :key, :parent_id, :parent_key, :user_id, :karma
  belongs_to :user
  validates_presence_of :ama_id, :key, :parent_key, :user_id
  validates_uniqueness_of :key
end
