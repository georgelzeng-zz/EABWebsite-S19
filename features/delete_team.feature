Feature: allow leaders of a team to delete the team

As a leader of a team
So that I may get rid of my team
I want to be able to delete the team

Background: members and teams have been added to the database
  Given the following users exist
  | first     | last       | email                      | team   | skillset | sid       | password | password_confirmation | code              |
  | George    | Zeng       | glz@berkeley.edu           | kiwi   | None     | 12345678  | 123456   | 123456                | registration_code |
  | Jason     | Bi         | jbi@berkeley.edu           | kiwi   | None     | 13371384  | 123456   | 123456                | registration_code |

Scenario: Team leader deletes the team
  Given I am logged in as the user with email "glz@berkeley.edu"
  And I am on the "kiwi" team edit page
  When I press "Delete my team"
  Then I should be on the Team Database page
  And I should see "Team kiwi successfully deleted"
  And I should not be on a team
  When I go to the Database page
  And I go to the Team Database page
  Then I should not see "kiwi"

Scenario: Non-team leader cannot get to the team delete button
  Given I am logged in as the user with email "jbi@berkeley.edu"
  Then I should not see the link "Edit Team"
