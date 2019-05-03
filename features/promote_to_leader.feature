Feature: allow leaders of a team to promote other members of the team to leader

As a leader of a team
So that I may pass on my position to a new member
I want to be able to promote a member of the team to leader

Background: members and teams have been added to the database
  Given the following users exist
  | first     | last       | email                      | team   | skillset | sid       | password | password_confirmation | code              |
  | George    | Zeng       | glz@berkeley.edu           | kiwi   | None     | 12345678  | 123456   | 123456                | registration_code |
  | Jason     | Bi         | jbi@berkeley.edu           | kiwi   | None     | 13371384  | 123456   | 123456                | registration_code |

Scenario: Team leader promotes fellow member to team leader
  Given I am logged in as the user with email "glz@berkeley.edu"
  And I am on the "kiwi" team page
  When I press "Promote to Leader"
  Then I should not be the leader of Team "kiwi"
  And the leader of Team "kiwi" should be the user with email "jbi@berkeley.edu"

Scenario: Non-team leader should not see a "Promote to Leader" button
  Given I am logged in as the user with email "jbi@berkeley.edu"
  And I am on the "kiwi" team page
  Then I should not see the button "Promote to Leader"
