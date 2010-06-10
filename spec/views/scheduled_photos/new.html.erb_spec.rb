require 'spec_helper'

describe "/scheduled_photos/new.html.erb" do
  include ScheduledPhotosHelper

  before(:each) do
    assigns[:scheduled_photo] = stub_model(ScheduledPhoto,
      :new_record? => true,
      :title => "value for title",
      :description => "value for description",
      :tags => "value for tags"
    )
  end

  it "renders new scheduled_photo form" do
    render

    response.should have_tag("form[action=?][method=post]", scheduled_photos_path) do
      with_tag("input#scheduled_photo_title[name=?]", "scheduled_photo[title]")
      with_tag("textarea#scheduled_photo_description[name=?]", "scheduled_photo[description]")
      with_tag("textarea#scheduled_photo_tags[name=?]", "scheduled_photo[tags]")
    end
  end
end
