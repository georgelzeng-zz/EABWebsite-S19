Feature: allow people to leave teams

As a team member, 
I want to be able to leave a team, 
so that I can join another team

Background: members and teams have been added to the database
  Given the following users exist
  | first     | last       | email                      | team   | skillset | sid       | password | password_confirmation | code              |
  | George    | Zeng       | glz@berkeley.edu           | kiwi   | None     | 12345678  | 123456   | 123456                | registration_code |
  | Jason     | Bi         | jbi@berkeley.edu           | cs169  | None     | 13371384  | 123456   | 123456                | registration_code |


Scenario: Regular user leaves a team
  Given I am logged in as "a regular user"
  And I am on the "kiwi" team page
  When I fill in "password" with "123456"
  And I press "Join Team"
  Then I should be a member of Team "kiwi"
  And I should see "Welcome to the team!"
  Then I am on the Database page
  And I follow "More"
  And I follow "View Profile"
  And I press "Leave Team"
  Then I should not see "kiwi"

Scenario: Team admin tries to leave a team
  Given I am on the team creation page
  And I am logged in as "a regular user"
  When I create a team with valid fields
  Then I should see "Poppy"
  Then I am on the Database page
  And I follow "More"
  And I follow "View Profile"
  And I press "Leave Team"
  Then I should see "Poppy"
