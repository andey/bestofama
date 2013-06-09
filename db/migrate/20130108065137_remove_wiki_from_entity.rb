class RemoveWikiFromEntity < ActiveRecord::Migration
  def up
    remove_column :ops, :wikipedia_slug
  end

  def down
    add_column :ops, :wikipedia_slug, :string
  end
end
