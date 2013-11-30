class AddIndexesToOps < ActiveRecord::Migration
  def change
    add_index :ops, [:wikipedia_hits, :comment_karma, :link_karma, :name], { name: 'ops_sortable_columns' }
  end
end
