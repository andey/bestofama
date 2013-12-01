class AddImageColumnsToTags < ActiveRecord::Migration
  def self.up
    add_attachment :tags, :image
  end

  def self.down
    remove_attachment :tags, :image
  end
end