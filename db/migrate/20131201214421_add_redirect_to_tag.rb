class AddRedirectToTag < ActiveRecord::Migration
  def change
    add_column :tags, :redirect_tag_name, :string
    add_column :tags, :redirect_tag_id, :integer
  end
end
