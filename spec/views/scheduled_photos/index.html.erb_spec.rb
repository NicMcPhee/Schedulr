require 'spec_helper'

describe "/scheduled_photos/index.html.erb" do
  include ScheduledPhotosHelper

  before(:each) do
    assigns[:scheduled_photos] = [
      stub_model(ScheduledPhoto,
        :title => "value for title",
        :description => "value for description",
        :tags => "value for tags"
      ),
      stub_model(ScheduledPhoto,
        :title => "value for title",
        :description => "value for description",
        :tags => "value for tags"
      )
    ]
  end

  it "renders a list of scheduled_photos" do
    render
    response.should have_tag("tr>td", "value for title".to_s, 2)
    response.should have_tag("tr>td", "value for description".to_s, 2)
    response.should have_tag("tr>td", "value for tags".to_s, 2)
  end
end
