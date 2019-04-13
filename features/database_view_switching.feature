Feature: allows admins to switch between an admin view and regular view

As an admin member
So that I can both quickly get emails and browse users via a pleasant UI
I should be able to switch database views

Scenario: If an Admin is on the Admin Database page, then he/she should see the link "Regular View"
  Given I am logged in as "an admin"
  When I go to the Admin Database page
  Then I should see the link "Regular View"

Scenario: If a regular user is on the Regular Database page, then he/she should not see the link "Admin View"
  Given I am logged in as "a regular user"
  When I go to the Database page
  Then I should not see the link "Admin View"

Scenario: If an admin is on the Regular Database page, then he/she should see the link "Admin View"
  Given I am logged in as "an admin"
  When I go to the Database page
  Then I should see the link "Admin View"

Scenario: If an admin follows the "Regular View" link, then he/she should be on the Regular Database page
  Given I am logged in as "an admin"
  When I go to the Admin Database page
  And I follow "Regular View"
  Then I should be on the Database page
