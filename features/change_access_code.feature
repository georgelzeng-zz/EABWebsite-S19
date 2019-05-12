Feature: allow admins to change either access code

As an admin
So that I maintain the exclusivity of the club
I want to be able to change either access code necessary for registration

Background: Access codes have been changed
  Given I am not logged in
  Then I am logged in as "a superadmin"
  And the current "regular access code" is "regular"
  And the current "admin access code" is "admin"
  And the current "superadmin access code" is "superadmin"
  And I change the "Regular Access Code" to "regular new"
  And I change the "Admin Access Code" to "admin new"
  And I change the "Superadmin Access Code" to "superadmin new"
  Then I am not logged in

Scenario: User attempts to register with old regular access code
  Given I start signing up with valid user data
  When I register my "code" as "regular"
  And I sign up
  Then I should see "Wrong access code"

Scenario: User attempts to register with new regular access code
  Given I start signing up with valid user data
  When I register my "code" as "regular new"
  And I sign up
  Then I should be on the Database page

Scenario: User attempts to register with old admin access code
  Given I start signing up with valid user data
  When I register my "code" as "admin"
  And I sign up
  Then I should see "Wrong access code"

Scenario: User attempts to register with new admin access code
  Given I start signing up with valid user data
  When I register my "code" as "admin new"
  And I sign up
  Then I should be an admin

Scenario: User attempts to register with old superadmin access code
  Given I start signing up with valid user data
  When I register my "code" as "superadmin"
  And I sign up
  Then I should see "Wrong access code"

Scenario: User attempts to register with new admin access code
  Given I start signing up with valid user data
  When I register my "code" as "superadmin new"
  And I sign up
  Then I should be a superadmin
