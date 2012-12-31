class CreateAmasUsers < ActiveRecord::Migration
  def up
    create_table :amas_users, :id => false do |t|
      t.integer :ama_id
      t.integer :user_id
    end
  end

  def down
    drop_table :amas_users
  end
end
