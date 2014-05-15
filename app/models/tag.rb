# == Schema Information
#
# Table name: tags
#
#  id                 :integer          not null, primary key
#  name               :string(255)
#  description        :string(255)
#  wikipedia_url      :string(255)
#  meaningless        :boolean
#  image_file_name    :string(255)
#  image_content_type :string(255)
#  image_file_size    :integer
#  image_updated_at   :datetime
#  image_source       :string(255)
#  redirect_tag_name  :string(255)
#  redirect_tag_id    :integer
#  updated_at         :datetime         default(2014-01-26 03:27:52 UTC)
#  taggings_count     :integer          default(0)
#

class Tag < ActiveRecord::Base
  has_many :taggings
  has_attached_file :image, :styles => {:medium => "230x140#", :thumb => "140x140#"}
  scope :popular, -> { order(:taggings_count, :id).reverse_order }

  before_validation :download_image, :merge

  # When the avatar source is changed, download the image
  def download_image
    if self.image_source_changed? && !self.image_source.empty?
      self.image = open(self.image_source)
    end
  end

  # Removing a tag
  def merge
    if !self.redirect_tag_name.empty? && self.redirect_tag_name_changed?
      new_tag = Tag.find_by_name(self.redirect_tag_name)
      self.redirect_tag_id = new_tag.id

      self.taggings.each do |bad|
        if Tagging.find_by(tag_id: new_tag.id, taggable_id: bad.taggable_id)
          bad.destroy()
        else
          bad.update_attribute(:tag_id, new_tag.id)
        end
      end
    end
  end
end
