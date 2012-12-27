class CreateMeta < ActiveRecord::Migration
  def change
    create_table :meta do |t|
      t.string :name, :null => false
      t.string :value, :null => false
      t.timestamps
    end
  end
end
