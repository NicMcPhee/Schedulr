class ScheduledPhoto < ActiveRecord::Base
  after_create :update_upload_times

  protected
  
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
    return true
  end
end
