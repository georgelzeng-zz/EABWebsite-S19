Feature: allow leaders of a team to edit the team attributes

As a leader of a team
So that I may update my team's info
I want to be able to edit the team attributes

Background: members and teams have been added to the database
  Given the following users exist
  | first     | last       | email                      | team   | skillset | sid       | password | password_confirmation | code              |
  | George    | Zeng       | glz@berkeley.edu           | kiwi   | None     | 12345678  | 123456   | 123456                | registration_code |
  | Jason     | Bi         | jbi@berkeley.edu           | cs169  | None     | 13371384  | 123456   | 123456                | registration_code |

Scenario: Team leader changes the name, bio, and password for the team
  Given I am logged in as the user with email "glz@berkeley.edu"
  And I am on the "kiwi" team edit page
  When I fill in "team_name" with "kiwiPlus"
  And I fill in "team_description" with "Beepbop"
  And I fill in "team_password" with "secret"
  And I press "Update Team"
  Then my team's "name" should be "kiwiPlus"
  And my team's "description" should be "Beepbop"
  And my team's "password" should be "secret"

Scenario: Team leader tries to change the name to the name of a different team
  Given I am logged in as the user with email "glz@berkeley.edu"
  And I am on the "kiwi" team edit page
  When I fill in "team_name" with "cs169"
  And I press "Update Team"
  Then I should see "A team with name cs169 already exists!"
