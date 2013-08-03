class AddKarmaToTaggings < ActiveRecord::Migration
  def change
    add_column :taggings, :karma, :integer
  end
end
