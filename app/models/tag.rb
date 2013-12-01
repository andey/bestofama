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
  has_attached_file :image, :styles => { :medium => "230x140#", :thumb => "140x140#" }
  scope :popular, -> { select('tags.*, COUNT(*) AS count_all').joins(:taggings).group('tags.id').order('count_all, tags.id').reverse_order }

  before_validation :download_image, :merge
  # When the avatar source is changed, download the image
  def download_image
    if self.image_source_changed? && !self.image_source.empty?
      self.image = open(self.image_source)
    end
  end

  def merge
    if self.redirect_tag_name_changed?
      new_tag = Tag.find_by_name(self.redirect_tag_name)
      self.redirect_tag_id = new_tag.id
      self.taggings.update_all(tag_id: new_tag.id)
    end
  end
end