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
      |title|description|tags|
      |title 1|description 1|tags 1|
      |title 2|description 2|tags 2|
      |title 3|description 3|tags 3|
      |title 4|description 4|tags 4|
    When I delete the 3rd scheduled_photo
    Then I should see the following scheduled_photos:
      |Title|Description|Tags|
      |title 1|description 1|tags 1|
      |title 2|description 2|tags 2|
      |title 4|description 4|tags 4|

  Scenario: Schedule my first photo
    Given that I've never scheduled or posted a photo
    When I schedule the following photo:
      |title|description|tags|
      |My photo|A photo I took|this, that|
    Then the scheduled upload time for "My photo" should be the maximum delay
    And there should be 1 scheduled photos
    And there should be 0 uploaded photos

  Scenario: Schedule my first four photos
    Given that I've never scheduled or posted a photo
    When I schedule the following photos:
      |title|description|tags|
      |First photo|The first photo I took|this, that|
      |Second photo|The second photo I took|this, that, the other|
      |Third photo|The third photo I took|this, that, some stuff|
      |Fourth photo|The fourth photo I took|a_tag|
    Then there should be 4 scheduled photos
    And there should be 0 uploaded photos
    And the scheduled upload time for "First photo" should be in 0.25 times the maximum delay
    And the scheduled upload time for "Second photo" should be in 0.5 times the maximum delay
    And the scheduled upload time for "Third photo" should be in 0.75 times the maximum delay
    And the scheduled upload time for "Fourth photo" should be the maximum delay

  Scenario: Schedule and upload my first photo
    Given that I've never scheduled or posted a photo
    And I've connected to Flickr
    When I schedule the following photo:
      |title|description|tags|
      |My photo|A photo I took|this, that|
    And wait the maximum delay
    And I visit the upload page
    Then there should be 0 scheduled photos
    And there should be 1 uploaded photos
    And "My photo" should be uploaded

  Scenario: Schedule and upload several photos
    Given that I've never scheduled or posted a photo
    When I schedule the following photo:
      |title|description|tags|
      |First photo|The first photo I took|this, that|
      |Second photo|The second photo I took|this, that, the other|
      |Third photo|The third photo I took|this, that, some stuff|
      |Fourth photo|The fourth photo I took|a_tag|
    And wait 0.6 times the maximum delay
    And I visit the upload page
    Then there should be 2 scheduled photos
    And there should be 2 uploaded photos
    And "First photo" should be uploaded
    And "Second photo" should be uploaded
