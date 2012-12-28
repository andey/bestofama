# == Schema Information
#
# Table name: users
#
#  id                :integer          not null, primary key
#  username          :string(255)      not null
#  modhash           :string(255)
#  active            :boolean          default(FALSE)
#  comment_karma     :integer          default(0)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  link_karma        :integer          default(0)
#  persistence_token :string(255)
#

class User < ActiveRecord::Base
  def to_param
    username
  end

  def is_admin?
    Admin.exists?(self)
  end

  acts_as_authentic do |c|
    c.login_field = :username
  end

  attr_accessible :active, :comment_karma, :link_karma, :modhash, :username, :persistence_token
  has_and_belongs_to_many :entities
  has_many :comments
  has_many :amas

  validates_presence_of :username
  validates_uniqueness_of :username
end
