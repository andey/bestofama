class IncreaseOpDescriptionLength < ActiveRecord::Migration
  def up
    change_column :ops, :content, :text
  end
  def down
    # This might cause trouble if you have strings longer
    # than 255 characters.
    change_column :ops, :content, :string
  end
end
