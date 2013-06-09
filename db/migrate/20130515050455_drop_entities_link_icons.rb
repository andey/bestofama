class DropEntitiesLinkIcons < ActiveRecord::Migration
  def up
    drop_table :entities_links_icons
  end

  def down
     create_table :entities_links_icons do |t|
       t.string :name, :null => false
       t.string :source, :null => false
       t.timestamps
     end
     add_index :entities_links_icons, :name, :unique => true
   end
end
