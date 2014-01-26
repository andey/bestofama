class AddUpdatedAtToTags < ActiveRecord::Migration
  def change
    add_column :tags, :updated_at, :timestamp, default: Time.now
  end
end
