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

def check_upload_time(offset_time, photo_title)
  photo = ScheduledPhoto.find_by_title(photo_title)
  photo.upload_time.should be_close(Time.now + offset_time, ACCEPTABLE_TIME_GAP)
end

Then /^the scheduled upload time for "([^\"]*)" should be the maximum delay$/ do |photo_title|
  check_upload_time(MAXIMUM_UPLOAD_DELAY, photo_title)
end

Then /^the scheduled upload time for "([^\"]*)" should be now$/ do |photo_title|
  check_upload_time(0.days, photo_title)
end

Then /^the scheduled upload time for "([^\"]*)" should be in (\d*\.?\d+) days/ do |photo_title, offset_days|
  offset_time = offset_days.to_f.days
  check_upload_time(offset_time, photo_title)
end
