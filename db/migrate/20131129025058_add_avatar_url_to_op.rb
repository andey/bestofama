class AddAvatarUrlToOp < ActiveRecord::Migration
  def change
    add_column :ops, :avatar_source, :string
  end
end
