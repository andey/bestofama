class AddOver18ToAmas < ActiveRecord::Migration[6.1]
  def change
    add_column :amas, :over_18, :boolean
  end
end