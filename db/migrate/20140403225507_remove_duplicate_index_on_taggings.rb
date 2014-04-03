class RemoveDuplicateIndexOnTaggings < ActiveRecord::Migration
  def change
		remove_index :taggings, [ :tag_id, :taggable_id ]
  end
end
