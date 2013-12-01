class AddImageSourceToTags < ActiveRecord::Migration
  def change
    add_column :tags, :image_source, :string
  end
end
