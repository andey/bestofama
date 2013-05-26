class MigrateOpLinks < ActiveRecord::Migration
  def change
    rename_column :ops_links, :entity_id, :op_id
    rename_column :ops_links, :entities_links_icon_id, :site_id
  end
end
