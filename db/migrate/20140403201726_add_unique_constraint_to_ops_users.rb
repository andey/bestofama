class AddUniqueConstraintToOpsUsers < ActiveRecord::Migration
  def change
    add_index :ops_users, [ :op_id, :user_id ], :unique => true
  end
end
