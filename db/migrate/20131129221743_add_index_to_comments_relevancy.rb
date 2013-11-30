class AddIndexToCommentsRelevancy < ActiveRecord::Migration
  def change
    add_index :comments, :relevant
  end
end
