Feature: allow members to start teams

As a member of EAB
So that I may perform recruit members for my team
I want to be able to make a team


Scenario: User creates a team
  Given I am on the team creation page
  And I am logged in as "a regular user"
  When I create a team with valid fields
  Then I should see "Poppy"

Scenario: User tries to create a team when already in a team
  Given the following users exist
  | first   | last     | email                      | team  | skillset | sid      | password | password_confirmation | code              |
  | George  | Zeng     | glz@berkeley.edu           | kiwi  | None     | 12345678 | 123456   | 123456                | registration_code |
  And I am logged in as the user with email "glz@berkeley.edu"
  And I am on the team creation page
  When I create a team with valid fields
  Then I should see "You can only be in one team!"
