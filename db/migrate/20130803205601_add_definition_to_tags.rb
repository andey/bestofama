class AddDefinitionToTags < ActiveRecord::Migration
  def change
    add_column :tags, :definition, :string
    add_column :tags, :wikipedia_url, :string
  end
end
