Feature: Allow users to delete their own accounts

As a club member
So that I can leave the club
I want to be able to delete my account

Background: members and teams have been added to the database
  Given the following users exist
  | first     | last       | email                      | team   | skillset | sid       | password | password_confirmation | code              |
  | George    | Zeng       | glz@berkeley.edu           | kiwi   | None     | 12345678  | 123456   | 123456                | registration_code |
  | Jason     | Bi         | jbi@berkeley.edu           | kiwi   | None     | 13371384  | 123456   | 123456                | registration_code |

Scenario: Team Leader deletes his account, while another member is on the team
    Given I am logged in as the user with email "glz@berkeley.edu"
    And I am on the edit page for the user with email "glz@berkeley.edu"
    When I press "Delete my account"
    Then I should not be logged in
    Given I am logged in as "a regular user"
    When I go to the Database page
    Then I should not see "George"
    When I go to the Team Database page
    Then I should see "kiwi"
    And I should see "Jason"

Scenario: Team Leader deletes his account, while no other member is on the team
    Given I am logged in as the user with email "glz@berkeley.edu"
    And I am on the edit page for the user with email "glz@berkeley.edu"
    And I press "Delete my account"
    Given I am logged in as the user with email "jbi@berkeley.edu"
    And I am on the edit page for the user with email "jbi@berkeley.edu"
    When I press "Delete my account"
    Then I should not be logged in
    Given I am logged in as "a regular user"
    When I go to the Database page
    Then I should not see "Jason"
    When I go to the Team Database page
    Then I should not see "kiwi"
