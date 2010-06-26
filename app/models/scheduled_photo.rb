class ScheduledPhoto < ActiveRecord::Base
  after_create :update_upload_times

  def self.scheduled_photos
    ScheduledPhoto.find_all_by_is_uploaded(false)
  end

  def self.uploaded_photos
    ScheduledPhoto.find_all_by_is_uploaded(true)
  end

  def upload
    # TODO upload to Flickr!
    # Turn this puts into some sort of log message.
    # puts "About to upload:"
    # pp self
    flickr.upload_photo path, :title => title, :description => description
    # I don't know why I need self in front of is_uploaded. It seems
    # that I should be able to just refer to is_uploaded as a field
    # and it would work, but that doesn't seem to be happening :-(.
    self.is_uploaded = true
    save!
  end

  def self.due_for_upload
    # puts "Scheduled photos in due_for_upload"
    # pp scheduled_photos
    ready = scheduled_photos.select do |photo|
      photo.upload_time <= Time.now
    end
    # puts "Ready for upload"
    # pp ready
    return ready
  end

  protected

  def self.upload_as_needed
    due = due_for_upload
    due.each { |photo| photo.upload }
  end

  include ScheduledPhotosHelper

  def update_upload_times
    scheduled = ScheduledPhoto.find(:all)
    num_scheduled = scheduled.size
    interval = MAXIMUM_UPLOAD_DELAY / num_scheduled
    delay = interval
    scheduled.each do |photo|
      photo.upload_time = Time.now + delay
      photo.save!
      delay += interval
    end
    self.is_uploaded = false
    save!
    return true
  end
end
