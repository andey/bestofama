# == Schema Information
#
# Table name: taggings
#
#  id            :integer          not null, primary key
#  tag_id        :integer
#  taggable_id   :integer
#  taggable_type :string(255)
#  tagger_id     :integer
#  tagger_type   :string(255)
#  context       :string(128)
#  created_at    :datetime
#  karma         :integer
#

class Tagging < ActiveRecord::Base
  belongs_to :tag
  validates_uniqueness_of :tag_id, :scope => :taggable_id
end
