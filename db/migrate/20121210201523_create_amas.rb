class CreateAmas < ActiveRecord::Migration
  def change
    create_table :amas do |t|
      t.string :key, :null => false
      t.timestamp :date
      t.string :title, :null => false
      t.text :content
      t.integer :karma, :default => 0
      t.integer :user_id, :default => 0
      t.string :permalink, :null => false
      t.integer :comments, :default => 0
      t.integer :responses, :default => 0
      t.timestamps
    end
  end
end
