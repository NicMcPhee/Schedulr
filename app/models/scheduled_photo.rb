class ScheduledPhoto < ActiveRecord::Base
  before_save :compute_upload_time

  include ScheduledPhotosHelper

  protected
  
  def compute_upload_time
    # TODO Clean out the commented out print statements
    #pp "Setting upload time to " + Time.now.to_s
    #pp self
    self.upload_time ||= Time.now + MAXIMUM_UPLOAD_DELAY
    #pp self
  end
end