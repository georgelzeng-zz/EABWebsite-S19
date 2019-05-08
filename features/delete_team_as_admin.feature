Feature: allow admins to delete a team

As an admin of EAB
So that I may get rid of teams that no longer exist or for other reasons
I want to be able to delete the team

Background: members and teams have been added to the database
  Given the following users exist
  | first     | last       | email                      | team   | skillset | sid       | password | password_confirmation | code              |
  | George    | Zeng       | glz@berkeley.edu           | kiwi   | None     | 12345678  | 123456   | 123456                | registration_code |
  | Jason     | Bi         | jbi@berkeley.edu           | kiwi   | None     | 13371384  | 123456   | 123456                | registration_code |

Scenario: Team leader deletes the team
  Given I am logged in as "an admin"
  And I am on the "kiwi" team page
  When I press "Delete Team"
  Then I should be on the Team Database page
  And I should see "Team kiwi successfully deleted"
  When I go to the Database page
  And I go to the Team Database page
  Then I should not see "kiwi"

Scenario: Non-admin cannot see the team delete button
  Given I am logged in as "a regular user"
  When I go to the "kiwi" team page
  Then I should not see the button "Delete Team"
