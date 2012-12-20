class CreateEntities < ActiveRecord::Migration
  def change
    create_table :entities do |t|
      t.string :name, :null => false
      t.string :slug, :null => false
      t.string :wikipedia_slug
      t.text :content
      t.timestamps
    end
  end
end
