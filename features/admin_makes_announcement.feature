Feature: Admin can make announcements

In order to make a club-wide announcement
As a club admin
I want to be able to create a message

Background:
  Given I am logged in as "an admin"
  When I go to the dashboard page
  Then I should see the button "Make Announcement"
  When I press "Make Announcement"
  Then I should see "Title"
  And I should see "Description"

  When I fill in "Title" with "Hello"
  And I fill in "Description" with "World"
  And I press "Create Announcement"

  Then I should be on the dashboard page
  And I should see "Hello"

Scenario:
  Given I am logged in as "an admin"
  When I go to the dashboard page
  Then I should see "Hello"
  And I should see the link "View"
  When I follow "View"
  Then I should see "World"

Scenario: general member tries to make an announcement, sad path
  Given I am logged in as "a regular user"
  When I go to the dashboard page
  Then I should not see the button "Make Announcement"
  But I should see the link "View"
  When I follow "View"
  Then I should see "World"
