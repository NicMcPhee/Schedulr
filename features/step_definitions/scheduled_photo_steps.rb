include ScheduledPhotosHelper

ACCEPTABLE_TIME_GAP = 60 # seconds, or a minute

Given /^the following scheduled_photos:$/ do |scheduled_photos|
  ScheduledPhoto.create!(scheduled_photos.hashes)
end

When /^I delete the (\d+)(?:st|nd|rd|th) scheduled_photo$/ do |pos|
  visit scheduled_photos_path
  within("table tr:nth-child(#{pos.to_i+1})") do
    click_link "Destroy"
  end
end

Then /^I should see the following scheduled_photos:$/ do |expected_scheduled_photos_table|
  expected_scheduled_photos_table.diff!(tableish('table tr', 'td,th'))
end

Given /^that I've never scheduled or posted a photo$/ do
  ScheduledPhoto.delete_all
end

When /^I schedule the following photos?:$/ do |table|
  table.hashes.each do |hash|
    ScheduledPhoto.create!(hash)
  end
end

When /^wait the maximum delay$/ do
  Timecop.travel(MAXIMUM_UPLOAD_DELAY)
end

When /^wait (\d*\.\d+) times the maximum delay$/ do |proportion|
  Timecop.travel((proportion.to_f * MAXIMUM_UPLOAD_DELAY).to_i)
end

When /^I visit the upload page$/ do
  to_upload = ScheduledPhoto.due_for_upload
  to_upload.each do |photo|
    # puts "Marking #{photo.title} should be uploaded"
    flickr.should_receive(:upload_photo).with(photo.path, :title => photo.title, :description => photo.description)
  end
  # puts "***\n*** Done visiting the upload page"
  visit path_to('upload as needed')
end

Then /^there should be (\d+) scheduled photos$/ do |num_scheduled_photos|
  ScheduledPhoto.scheduled_photos.size.should == num_scheduled_photos.to_i
end

def check_upload_time(offset_time, photo_title)
  photo = ScheduledPhoto.find_by_title(photo_title)
  photo.upload_time.should be_close(Time.now + offset_time, ACCEPTABLE_TIME_GAP)
  photo.is_uploaded.should be_false
end

Then /^the scheduled upload time for "([^\"]*)" should be the maximum delay$/ do |photo_title|
  check_upload_time(MAXIMUM_UPLOAD_DELAY, photo_title)
end

Then /^the scheduled upload time for "([^\"]*)" should be in (\d*\.\d+) times the maximum delay$/ do |photo_title, proportion|
  offset_time = proportion.to_f * MAXIMUM_UPLOAD_DELAY
  check_upload_time(offset_time, photo_title)
end

Then /^there should be (\d+) uploaded photos$/ do |num_uploaded_photos|
  ScheduledPhoto.uploaded_photos.size.should == num_uploaded_photos.to_i
end

Then /^"([^\"]*)" should be uploaded$/ do |photo_title|
  photo = ScheduledPhoto.find_by_title(photo_title)
  photo.is_uploaded.should be_true
  # TODO And Flickr should have received the photo!
  # pending
  flickr.rspec_verify
  flickr.rspec_reset
end
