class CreateEntitiesLinksIcons < ActiveRecord::Migration
  def change
    create_table :entities_links_icons do |t|
      t.string :name, :null => false
      t.string :source, :null => false
      t.timestamps
    end
    add_index :entities_links_icons, :name, :unique => true
  end
end
