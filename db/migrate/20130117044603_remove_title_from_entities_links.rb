class RemoveTitleFromEntitiesLinks < ActiveRecord::Migration
  def up
    remove_column :ops_links, :title
  end

  def down
    add_column :ops_links, :title, :string
  end
end
