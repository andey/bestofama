class RenameEntities < ActiveRecord::Migration
  def change
    rename_table :entities, :ops
    rename_table :entities_links, :ops_links
    rename_table :entities_users, :ops_users
  end
end
