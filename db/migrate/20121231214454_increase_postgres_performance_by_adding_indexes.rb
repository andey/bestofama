class IncreasePostgresPerformanceByAddingIndexes < ActiveRecord::Migration
  def change
    #Add SQL Indexes to following tables/columns
    add_index :users, :username
    add_index :amas, :key, :unique => true
    add_index :comments, :key
    add_index :ops, :slug, :unique => true
    add_index :meta, :name, :unique => true
  end
end
