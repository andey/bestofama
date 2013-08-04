# == Schema Information
#
# Table name: trashes
#
#  id         :integer          not null, primary key
#  key        :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Trash < ActiveRecord::Base
  validates_presence_of :key
  validates_uniqueness_of :key
end
