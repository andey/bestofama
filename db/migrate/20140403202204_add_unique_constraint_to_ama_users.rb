class AddUniqueConstraintToAmaUsers < ActiveRecord::Migration
  def change
    add_index :amas_users, [:ama_id, :user_id], :unique => true
  end
end
