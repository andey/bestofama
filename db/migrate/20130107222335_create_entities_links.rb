class CreateEntitiesLinks < ActiveRecord::Migration
  def change
    create_table :entities_links do |t|
      t.integer :entity_id
      t.integer :entities_links_icon_id
      t.string :title, :null => false
      t.string :link, :null => false
      t.timestamps
    end
  end
end
