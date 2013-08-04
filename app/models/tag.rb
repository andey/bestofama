# == Schema Information
#
# Table name: tags
#
#  id            :integer          not null, primary key
#  name          :string(255)
#  description   :string(255)
#  wikipedia_url :string(255)
#  meaningless   :boolean
#

class Tag < ActiveRecord::Base
  has_many :taggings
end
