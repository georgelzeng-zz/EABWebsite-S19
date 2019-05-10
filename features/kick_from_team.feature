Feature: allow leaders of a team to kick members from the team

As a leader of a team
So that I may get rid of pesky team members
I want to be able to kick the member from the team

Background: members and teams have been added to the database
  Given the following users exist
  | first     | last       | email                      | team   | skillset | sid       | password | password_confirmation | code              |
  | George    | Zeng       | glz@berkeley.edu           | kiwi   | None     | 12345678  | 123456   | 123456                | registration_code |
  | Jason     | Bi         | jbi@berkeley.edu           | kiwi   | None     | 13371384  | 123456   | 123456                | registration_code |

Scenario: Team leader deletes the team
  Given I am logged in as the user with email "glz@berkeley.edu"
  And I am on the "kiwi" team page
  When I press "Kick from Team"
  Then I should be on the profile page for the user with email "jbi@berkeley.edu"
  And I should not see "kiwi"
  When I go to the "kiwi" team page
  Then I should not see "Jason"

Scenario: Non-team leader cannot get to the team delete button
  Given I am logged in as the user with email "jbi@berkeley.edu"
  And I am on the "kiwi" team page
  Then I should not see the button "Kick from Team"
