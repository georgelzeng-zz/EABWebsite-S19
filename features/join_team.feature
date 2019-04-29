Feature: allow users with no current team to join an existing team

As a member of EAB
So that I may collaborate with fellow club members
I want to be able to join a team

Background: members and teams have been added to the database
  Given the following users exist
  | first     | last       | email                      | team   | skillset | sid       | password | password_confirmation | code              |
  | George    | Zeng       | glz@berkeley.edu           | kiwi   | None     | 12345678  | 123456   | 123456                | registration_code |
  | Jason     | Bi         | jbi@berkeley.edu           | cs169  | None     | 13371384  | 123456   | 123456                | registration_code |

Scenario: A user without a current team inputs the correct password for joining team kiwi
  Given I am logged in as 'a regular user'
  And I am on the Team "kiwi" page
  When I fill in "password" with "123456"
  And I press "Join Team"
  Then I should be a member of Team "kiwi"
  And I should see "Welcome to the team!"

Scenario: A user without a current team inputs the wrong password for joining team kiwi
  Given I am logged in as 'a regular user'
  And I am on the Team "kiwi" page
  When I fill in "password" with "hedgehog"
  And I press "Join Team"
  Then I should not be on a team
  And I should see "Wrong password!"

Scenario: A user already on a different team tries to join team cs169
  Given I am logged in as the user with email "glz@berkeley.edu"
  And I am on the Team "cs169" page
  When I fill in "password" with "123456"
  And I press "Join Team"
  Then I should see be a member of Team "kiwi"
  And I should see "You can be part of only one team!"

Scenario: A member of team kiwi tries to join team kiwi
  Given I am logged in as the user with email "glz@berkeley.edu"
  And I am on the Team "kiwi" page
  When I fill in "password" with "123456"
  And I press "Join Team"
  Then I should see be a member of Team "kiwi"
  And I should see "You're already on this team!"
