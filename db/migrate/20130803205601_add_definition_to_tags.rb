class AddDefinitionToTags < ActiveRecord::Migration
  def change
    add_column :tags, :description, :string
    add_column :tags, :wikipedia_url, :string
    add_column :tags, :meaningless, :boolean
  end
end
