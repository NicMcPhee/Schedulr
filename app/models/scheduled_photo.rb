class ScheduledPhoto < ActiveRecord::Base
  before_create :compute_upload_time

  protected
  
  include ScheduledPhotosHelper

  def compute_upload_time
    # TODO Clean out the commented out print statements
    #pp "Setting upload time to " + Time.now.to_s
    #pp self
    self.upload_time ||= Time.now + MAXIMUM_UPLOAD_DELAY
    #pp self
  end
end
