class AddWikipediaToUpcomings < ActiveRecord::Migration
  def change
    add_column :upcomings, :wikipedia, :string
    add_column :upcomings, :name, :string
  end
end
