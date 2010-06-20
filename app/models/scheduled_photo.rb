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
    # I don't know why I need self in front of is_uploaded. It seems
    # that I should be able to just refer to is_uploaded as a field
    # and it would work, but that doesn't seem to be happening :-(.
    self.is_uploaded = true
    save!
  end

  protected

  def self.upload_as_needed
    # TODO I bet I can do this with filter or some such
    due_for_upload = scheduled_photos.select do |photo|
      photo.upload_time <= Time.now
    end
    due_for_upload.each { |photo| photo.upload }
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
