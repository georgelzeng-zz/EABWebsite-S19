Feature: Allow superadmins to clear a roster at the end of the semester

As a superadmin
So that I can bring in a new batch of companies
I want to be able to clear a semester's teams

Background: members and teams have been added to the database
  Given the following users exist
  | first     | last       | email                      | team   | skillset | sid       | password | password_confirmation | code              |
  | George    | Zeng       | glz@berkeley.edu           | kiwi   | None     | 12345678  | 123456   | 123456                | registration_code |
  | Jason     | Bi         | jbi@berkeley.edu           | kiwi   | None     | 13371384  | 123456   | 123456                | registration_code |

Scenario: Superadmin clears all users
    Given I am logged in as "a superadmin"
    And I go to the Team Database page
    Then I should see "kiwi"
    When I go to the Admin Database page
    And I press "Delete All Regular Members"
    When I go to the Database page
    Then I should not see "George"
    And I should see "Testy"
    When I go to the Team Database page
    Then I should not see "kiwi"

Scenario: Admin cannot clear other users
    Given I am logged in as "an admin"
    When I go to the Admin Database page
    Then I should see the button "Export Members as XLSX"
    And I should not see the button "Delete All Regular Members"
