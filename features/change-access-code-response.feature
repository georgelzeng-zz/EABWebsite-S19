Feature: admins are notified when trying to change an access code

As an admin
So that I may know whether I successfully changed an access code
I want to be able to see an appropriate notification

Background: I am an admin and access codes already have a value
  Given I am logged in as "an admin"
  And the current "regular access code" is "regular"
  And the current "admin access code" is "admin"
  And I am on the Admin Database page

Scenario: Admin tries to change the Regular Access code to the same value as the Admin Access code
  When I change the "Regular Access Code" to "admin"
  Then I should see "Code-change failed: Access codes must be different from each other."

Scenario: Admin tries to change the Admin Access code to the same value as the Regular Access code
  When I change the "Admin Access Code" to "regular"
  Then I should see "Code-change failed: Access codes must be different from each other."

Scenario: Admin tries to change the Regular Access code to its same value
  When I change the "Regular Access Code" to "regular"
  Then I should see "Regular Code is already 'regular'"

Scenario: Admin tries to change the Admin Access code to its same value
  When I change the "Admin Access Code" to "admin"
  Then I should see "Admin Code is already 'admin'"

Scenario: Admin tries to change the Regular Access code to a new valid value
  When I change the "Regular Access Code" to "regular new"
  Then I should see "Regular Code successfully changed from 'regular' to 'regular new'"

Scenario: Admin tries to change the Admin Access code to a new valid value
  When I change the "Admin Access Code" to "admin new"
  Then I should see "Admin Code successfully changed from 'admin' to 'admin new'"
