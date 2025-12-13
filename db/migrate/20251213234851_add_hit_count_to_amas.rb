class AddHitCountToAmas < ActiveRecord::Migration[6.1]
  def change
    add_column :amas, :hit_count, :bigint, default: 0
  end
end
