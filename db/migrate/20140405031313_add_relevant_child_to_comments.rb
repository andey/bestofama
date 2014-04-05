class AddRelevantChildToComments < ActiveRecord::Migration
  def change
    add_column :comments, :relevant_child, :boolean, default: false
  end
end
