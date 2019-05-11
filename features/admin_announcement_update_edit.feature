Feature: Admin can change announcement contents

As a club admin
So I may update an announcement with relevant information
I want to be able to edit and update announcements

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


Scenario: admin edit information
  Given I am logged in as "an admin"
  When I go to the dashboard page
  And I follow "View"
  Then I should see "World"
  And I should see the link "Edit"
