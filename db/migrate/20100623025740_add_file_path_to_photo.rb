class AddFilePathToPhoto < ActiveRecord::Migration
  def self.up
    add_column :scheduled_photos, :path, :string
  end

  def self.down
    remove_column :scheduled_photos, :path
  end
end
