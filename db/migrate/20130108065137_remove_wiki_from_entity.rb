class RemoveWikiFromEntity < ActiveRecord::Migration
  def up
    remove_column :entities, :wikipedia_slug
  end

  def down
    add_column :entities, :wikipedia_slug, :string
  end
end
