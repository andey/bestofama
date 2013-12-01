# == Schema Information
#
# Table name: archives
#
#  id         :integer          not null, primary key
#  ama_id     :integer
#  created_at :datetime
#  updated_at :datetime
#  json       :hstore
#

class Archive < ActiveRecord::Base
  belongs_to :ama
end
