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
#

class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :ama
  belongs_to :parent, :class_name => 'Comment', :primary_key => :key, :foreign_key => :parent_key
  has_many :children, :class_name => 'Comment', :primary_key => :parent_key, :foreign_key => :key, :order => 'karma DESC'

  validates_presence_of :ama_id, :key, :parent_key, :user_id
  validates_uniqueness_of :key

  # paper_trail gem to record changes to content attribute
  has_paper_trail :only => :content, :on => [:update, :destroy]

  def which_label?
    if self.user_id == self.ama.user_id
      return 'label label-info'
    elsif self.ama.users.include?(self.user)
      return 'label label-warning'
    else
      return ''
    end
  end
end
