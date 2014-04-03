class AddIndexToDateOnAmas < ActiveRecord::Migration
  def change
    add_index :amas, :date
  end
end
