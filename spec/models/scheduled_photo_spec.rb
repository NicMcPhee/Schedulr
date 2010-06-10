require 'spec_helper'

describe ScheduledPhoto do
  before(:each) do
    @valid_attributes = {
      :title => "value for title",
      :description => "value for description",
      :tags => "value for tags",
      :upload_time => Time.now
    }
  end

  it "should create a new instance given valid attributes" do
    ScheduledPhoto.create!(@valid_attributes)
  end
end
