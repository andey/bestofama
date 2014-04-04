class AddAmaIdIndexToArchives < ActiveRecord::Migration
  def change
    add_index :archives, :ama_id
  end
end
