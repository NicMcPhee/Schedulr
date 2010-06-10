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

When /^I schedule the following photo:$/ do |table|
  table.hashes.each do |hash|
    ScheduledPhoto.create!(hash)
  end
end

Then /^the scheduled upload time for "([^\"]*)" should be now$/ do |photo_title|
  photo = ScheduledPhoto.find_by_title(photo_title)
  photo.upload_time.should be_close(Time.now, ACCEPTABLE_TIME_GAP)
end