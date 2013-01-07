class Trash < ActiveRecord::Base
  attr_accessible :key
  validates_presence_of :key
  validates_uniqueness_of :key
end
