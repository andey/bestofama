class AddEntityRankings < ActiveRecord::Migration
  def change
    add_column :entities, :wikipedia_hits, :integer, :default => 0
    add_column :entities, :link_karma, :integer, :default => 0
    add_column :entities, :comment_karma, :integer, :default => 0
  end
end
