Feature: admins are notified when trying to change an access code

As an admin
So that I may know whether I successfully changed an access code
I want to be able to see an appropriate notification

Background: I am an admin and access codes already have a value
  Given spam
  Given I am logged in as "an admin"
  And the current "regular access code" is "regular"
  And the current "admin access code" is "admin"
  And the current "superadmin access code" is "superadmin"
  And I am on the Admin Database page

Scenario: Admin tries to change the Regular Access code to the same value as one of the other codes
  When I change the "Regular Access Code" to "admin"
  Then I should see "Code-change failed: Access codes must be different from each other."
  When I change the "Regular Access Code" to "superadmin"
  Then I should see "Code-change failed: Access codes must be different from each other."

Scenario: Admin tries to change the Admin Access code to the same value as as one of the other codes
  When I change the "Admin Access Code" to "regular"
  Then I should see "Code-change failed: Access codes must be different from each other."
  When I change the "Admin Access Code" to "superadmin"
  Then I should see "Code-change failed: Access codes must be different from each other."

Scenario: Superadmin tries to change the SuperAdmin Access code to the same value as as one of the other codes
  Given I am logged in as "a superadmin"
  When I change the "Superadmin Access Code" to "regular"
  Then I should see "Code-change failed: Access codes must be different from each other."
  When I change the "Superadmin Access Code" to "admin"
  Then I should see "Code-change failed: Access codes must be different from each other."

Scenario: Admin tries to change the Regular Access code to its same value
  When I change the "Regular Access Code" to "regular"
  Then I should see "Regular Code is already 'regular'"

Scenario: Admin tries to change the Admin Access code to its same value
  When I change the "Admin Access Code" to "admin"
  Then I should see "Admin Code is already 'admin'"

Scenario: Superadmin tries to change the Superadmin Access code to its same value
  Given I am logged in as "a superadmin"
  When I change the "Superadmin Access Code" to "superadmin"
  Then I should see "Superadmin Code is already 'superadmin'"

Scenario: Admin tries to change the Regular Access code to a new valid value
  When I change the "Regular Access Code" to "regular new"
  Then I should see "Regular Code successfully changed from 'regular' to 'regular new'"

Scenario: Admin tries to change the Admin Access code to a new valid value
  When I change the "Admin Access Code" to "admin new"
  Then I should see "Admin Code successfully changed from 'admin' to 'admin new'"

Scenario: Superadmin tries to change the Superadmin Access code to a new valid value
  Given I am logged in as "a superadmin"
  When I change the "Superadmin Access Code" to "superadmin new"
  Then I should see "Superadmin Code successfully changed from 'superadmin' to 'superadmin new'"
