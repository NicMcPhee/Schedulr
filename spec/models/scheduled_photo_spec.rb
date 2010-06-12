require 'spec_helper'

describe ScheduledPhoto do
  before(:each) do
    @valid_attributes = {
      :title => "value for title",
      :description => "value for description",
      :tags => "value for tags"
    }
  end

  it "should create a new instance given valid attributes" do
    ScheduledPhoto.create!(@valid_attributes)
  end

  it "should create new instance with upload time not in the past" do
    ScheduledPhoto.create!(@valid_attributes)
    photo = ScheduledPhoto.find_by_title(@valid_attributes[:title])
    photo.upload_time.should_not be_in_the_past
  end
end
