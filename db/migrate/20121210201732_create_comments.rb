class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :key, :null => false
      t.integer :user_id, :default => 0
      t.integer :ama_id, :default => 0
      t.timestamp :date
      t.text :content
      t.integer :parent_id
      t.string :parent_key, :null => false
      t.timestamps
    end
  end
end
