class AddRelevantToComments < ActiveRecord::Migration
  def change
    add_column :comments, :relevant, :boolean, :default => false
  end
end
