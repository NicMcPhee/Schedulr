require 'spec_helper'

describe "/scheduled_photos/show.html.erb" do
  include ScheduledPhotosHelper
  before(:each) do
    assigns[:scheduled_photo] = @scheduled_photo = stub_model(ScheduledPhoto,
      :title => "value for title",
      :description => "value for description",
      :tags => "value for tags"
    )
  end

  it "renders attributes in <p>" do
    render
    response.should have_text(/value\ for\ title/)
    response.should have_text(/value\ for\ description/)
    response.should have_text(/value\ for\ tags/)
  end
end
