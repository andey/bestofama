class AddRegexToEntitiesLinksIcons < ActiveRecord::Migration
  def change
    add_column :entities_links_icons, :regex, :string
  end
end
