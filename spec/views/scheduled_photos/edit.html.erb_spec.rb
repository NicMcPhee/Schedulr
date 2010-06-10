require 'spec_helper'

describe "/scheduled_photos/edit.html.erb" do
  include ScheduledPhotosHelper

  before(:each) do
    assigns[:scheduled_photo] = @scheduled_photo = stub_model(ScheduledPhoto,
      :new_record? => false,
      :title => "value for title",
      :description => "value for description",
      :tags => "value for tags"
    )
  end

  it "renders the edit scheduled_photo form" do
    render

    response.should have_tag("form[action=#{scheduled_photo_path(@scheduled_photo)}][method=post]") do
      with_tag('input#scheduled_photo_title[name=?]', "scheduled_photo[title]")
      with_tag('textarea#scheduled_photo_description[name=?]', "scheduled_photo[description]")
      with_tag('textarea#scheduled_photo_tags[name=?]', "scheduled_photo[tags]")
    end
  end
end
