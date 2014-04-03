class AddIndexToDateOnUpcomings < ActiveRecord::Migration
  def change
    add_index :upcomings, :date
  end
end
