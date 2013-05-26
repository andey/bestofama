class RemoveAuthLogic < ActiveRecord::Migration
  def up
    remove_column :users, :persistence_token
    remove_column :users, :banned
    remove_column :users, :modhash
  end

  def down
    add_column :users, :persistence_token, :string
    add_column :users, :banned, :boolean, :default => false
    add_column :users, :modhash, :string
  end
end
