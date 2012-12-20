class CreateEntitiesUsersJoinTable < ActiveRecord::Migration
  def change
    create_table :entities_users, :id => false do |t|
      t.integer :entity_id, :null => false
      t.integer :user_id, :null => false
    end
  end
end
