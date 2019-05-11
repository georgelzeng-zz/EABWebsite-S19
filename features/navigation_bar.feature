Feature: navigate using navbar options

As a user
So I may quickly navigate between pages
I want to be able to use navigation bar tabs

Scenario: navigate to database homepage from viewing members
  Given I am logged in as "a regular user"
  When I view users
  And I follow "Dashboard"
  Then I should be on the dashboard page

Scenario: navigate to database homepage from admin database
  Given I am logged in as "an admin"
  When I go to the Admin Database page
  And I follow "Dashboard"
  Then I should be on the dashboard page

Scenario: navigate to profile page from users database
  Given I am logged in as "a regular user"
  When I go to the Database page
  And I follow "More"
  And I follow "View Profile"
  Then I should see "Skills"
  And I should see "Testy McUserton"
  And I should not see "SID"

Scenario: navigate to profile page from admin database
  Given I am logged in as "an admin"
  When I go to the Admin Database page
  And I follow "View Profile"
  Then I should see "Skills"
  And I should see the link "Edit Account"
  And I should see "example@example.com"
  Then I should see the button "Delete User"

Scenario: navigate to home from profile page
  Given I am logged in as "a regular user"
  When I go to the Database page
  And I follow "More"
  And I follow "View Profile"
  And I follow "Dashboard"
  Then I should be on the dashboard page
