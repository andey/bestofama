class AddParentKeyIndexToComments < ActiveRecord::Migration
  def change
    add_index :comments, :parent_key
  end
end
