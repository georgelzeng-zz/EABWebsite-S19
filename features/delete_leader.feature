Feature: Allow admins to delete team-leaders (bug)

As an admin
So that I can remove a user
Given that I am on a user's profile page
I want to be able to remove that user (even if they are a leader)

Background: members and teams have been added to the database
  Given the following users exist
  | first     | last       | email                      | team   | skillset | sid       | password | password_confirmation | code              |
  | George    | Zeng       | glz@berkeley.edu           | kiwi   | None     | 12345678  | 123456   | 123456                | registration_code |
  | Jason     | Bi         | jbi@berkeley.edu           | kiwi   | None     | 13371384  | 123456   | 123456                | registration_code |

Scenario: Admin deletes a leader of a team with another member in it
    Given I am logged in as "an admin"
    And I am on the profile page for the user with email "glz@berkeley.edu"
    When I press "Delete User"
    And I go to the Database page
    Then I should not see "George"
    When I go to the Team Database page
    Then I should see "kiwi"
    And I should see "Jason"

Scenario: Admin deletes a leader of a team with no other member in it
    Given I am logged in as "an admin"
    And I am on the profile page for the user with email "glz@berkeley.edu"
    And I press "Delete User"
    When I go to the profile page for the user with email "jbi@berkeley.edu"
    And I press "Delete User"
    And I go to the Database page
    Then I should not see "Jason"
    When I go to the Team Database page
    Then I should not see "kiwi"
