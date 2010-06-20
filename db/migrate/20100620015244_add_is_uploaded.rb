class AddIsUploaded < ActiveRecord::Migration
  def self.up
    add_column :scheduled_photos, :is_uploaded, :boolean
  end

  def self.down
    remove_column :scheduled_photos, :is_uploaded
  end
end
