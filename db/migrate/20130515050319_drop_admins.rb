class DropAdmins < ActiveRecord::Migration
  def up
    drop_table :admins
  end

  def down
    create_table :admins do |t|
      t.integer :user_id, :null => false
      t.timestamps
    end
  end
end
