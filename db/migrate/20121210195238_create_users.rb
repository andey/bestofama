class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username, :null => false
      t.string :modhash
      t.boolean :active, :default => false
      t.integer :link_karma, :default => 0
      t.integer :comment_karma, :default => 0
      t.string :persistence_token
      t.timestamps
    end
  end
end
