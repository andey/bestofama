class RenameEntities < ActiveRecord::Migration
  def change
    rename_table :entities, :ops
    rename_table :ops_links, :ops_links
    rename_table :ops_users, :ops_users
  end
end
