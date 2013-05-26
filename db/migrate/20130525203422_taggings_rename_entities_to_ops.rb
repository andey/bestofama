class TaggingsRenameEntitiesToOps < ActiveRecord::Migration
  def up
    Tagging.update_all(:taggable_type => 'Op')
    rename_column :ops_users, :entity_id, :op_id
  end

  def down
    Tagging.update_all(:taggable_type => 'Entity')
    rename_column :ops_users, :op_id, :entity_id
  end
end
