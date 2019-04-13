Feature: allows admins to switch between an admin view and regular view

As an admin member
So that I can both quickly get emails and browse users via a pleasant UI
I should be able to switch database views

Scenario: If an Admin is on the admin database page, then he/she should see the link "Regular View"
  Given I am logged in as "an admin"
  When I go to the admin database page
  Then I should see the link "Regular View"
