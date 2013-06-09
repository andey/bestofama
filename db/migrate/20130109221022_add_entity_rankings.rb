class AddEntityRankings < ActiveRecord::Migration
  def change
    add_column :ops, :wikipedia_hits, :integer, :default => 0
    add_column :ops, :link_karma, :integer, :default => 0
    add_column :ops, :comment_karma, :integer, :default => 0
  end
end
