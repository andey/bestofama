class RemoveTitleFromEntitiesLinks < ActiveRecord::Migration
  def up
    remove_column :entities_links, :title
  end

  def down
    add_column :entities_links, :title, :string
  end
end
