Feature: Manage scheduled_photos
  In order to schedule photos for upload
  I
  want to be able to add photos to the schedule queue and check their scheduled upload times
  
  Scenario: Register new scheduled_photo
    Given I am on the new scheduled_photo page
    When I fill in "Title" with "title 1"
    And I fill in "Description" with "description 1"
    And I fill in "Tags" with "tags 1"
    And I press "Create"
    Then I should see "title 1"
    And I should see "description 1"
    And I should see "tags 1"

  Scenario: Delete scheduled_photo
    Given the following scheduled_photos:
      |title|description|tags|upload_time|
      |title 1|description 1|tags 1|1 Jan 2010 3:15am|
      |title 2|description 2|tags 2|5 Feb 2010 15:15|
      |title 3|description 3|tags 3|25 June 2010 noon|
      |title 4|description 4|tags 4|25 June 2011 2pm|
    When I delete the 3rd scheduled_photo
    Then I should see the following scheduled_photos:
      |Title|Description|Tags|Upload time|
      |title 1|description 1|tags 1|2010-01-01 03:15|
      |title 2|description 2|tags 2|2010-02-05 15:15|
      |title 4|description 4|tags 4|2011-06-25 14:00|

  Scenario: Schedule my first photo
    Given that I've never scheduled or posted a photo
    When I schedule the following photo:
      |title|description|tags|
      |My photo|A photo I took|this, that|
    Then the scheduled upload time for "My photo" should be now
