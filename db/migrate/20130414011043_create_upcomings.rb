class CreateUpcomings < ActiveRecord::Migration
  def change
    create_table :upcomings do |t|
      t.string :title
      t.datetime :date
      t.string :description
      t.string :url, :unique => true

      t.timestamps
    end
  end
end
