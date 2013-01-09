class AddAvatarToEntity < ActiveRecord::Migration
  def up
    add_attachment :entities, :avatar
  end

  def down
    remove_attachment :entities, :avatar
  end
end
