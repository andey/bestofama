class CommentsIndexingAgain < ActiveRecord::Migration
  def change
    remove_index :comments, 'everything'
    add_index :comments, :key
    add_index :comments, :parent_key
    add_index :comments, :relevant
    add_index :comments, :ama_id
  end
end
