class AddAvatarToEntity < ActiveRecord::Migration
  def up
    add_attachment :ops, :avatar
  end

  def down
    remove_attachment :ops, :avatar
  end
end
