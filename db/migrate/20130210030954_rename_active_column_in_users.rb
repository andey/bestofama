class RenameActiveColumnInUsers < ActiveRecord::Migration
  def up
    User.update_all(:active => false)
    rename_column :users, :active, :banned
  end

  def down
    rename_column :users, :banned, :active
  end
end
