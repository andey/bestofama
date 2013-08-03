# == Schema Information
#
# Table name: tags
#
#  id   :integer          not null, primary key
#  name :string(255)
#

class Tag < ActiveRecord::Base
  has_many :taggings
end
