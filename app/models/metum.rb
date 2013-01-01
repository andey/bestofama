# == Schema Information
#
# Table name: meta
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  value      :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Metum < ActiveRecord::Base
  attr_accessible :name, :value
  validates_presence_of :name, :value
  validates_uniqueness_of :name
  validates_format_of :name, :with => /[-a-z0-9\-_]/
end
