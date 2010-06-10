class CreateScheduledPhotos < ActiveRecord::Migration
  def self.up
    create_table :scheduled_photos do |t|
      t.string :title
      t.text :description
      t.text :tags
      t.datetime :upload_time

      t.timestamps
    end
  end

  def self.down
    drop_table :scheduled_photos
  end
end
