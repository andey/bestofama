class CreateTrashes < ActiveRecord::Migration
  def change
    create_table :trashes do |t|
      t.string :key, :null => false
      t.timestamps
    end
    add_index :trashes, :key, :unique => true
  end
end
