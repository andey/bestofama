class CreateArchives < ActiveRecord::Migration
  def change
    create_table :archives do |t|
      t.integer :ama_id
      t.timestamps
    end
  end
end
