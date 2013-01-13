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
  attr_accessible :content, :date, :karma, :key, :permalink, :comments, :responses, :title, :user_id
  belongs_to :user
  validates_presence_of :key, :permalink, :title, :user_id
  validates_uniqueness_of :key
  has_and_belongs_to_many :users
  has_paper_trail :only => :content, :on => [:update, :destroy]
end
