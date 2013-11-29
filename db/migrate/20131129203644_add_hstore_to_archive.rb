class AddHstoreToArchive < ActiveRecord::Migration
  def up
    add_column :archives, :json, :hstore
  end

  def down
    remove_column :archives, :json
  end
end