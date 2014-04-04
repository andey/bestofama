class BetterIndexingOnComments < ActiveRecord::Migration
  def change
    remove_index :comments, :key
    remove_index :comments, :parent_key
    remove_index :comments, :relevant
    add_index :comments, [:ama_id, :key, :user_id, :parent_key, :karma, :relevant ], name: 'index_comments_on_everything'
  end
end
