class AddUniqueConstraintToTagTaggings < ActiveRecord::Migration
  def change
    add_index :taggings, [ :tag_id, :taggable_id ], :unique => true
  end
end
