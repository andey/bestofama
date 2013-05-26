# == Schema Information
#
# Table name: users
#
#  id            :integer          not null, primary key
#  username      :string(255)      not null
#  comment_karma :integer          default(0)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  link_karma    :integer          default(0)
#

class User < ActiveRecord::Base

  def to_param
    username
  end

  #attr_accessible :active, :comment_karma, :link_karma, :modhash, :username, :persistence_token
  has_and_belongs_to_many :ops
  has_and_belongs_to_many :amas_participated, :class_name => "Ama", :foreign_key => :user_id
  has_many :comments
  has_many :amas

  validates_presence_of :username
  validates_uniqueness_of :username

end
