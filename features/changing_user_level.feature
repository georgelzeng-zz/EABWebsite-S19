Feature: Allow superadmins to change positions of other members

As a superadmin
I want to be able to change the access levels of other members
so that I can maintain order of the website

Background: members and teams have been added to the database
  Given the following users exist
  | first     | last       | email                      | team   | skillset | sid       | password | password_confirmation | code              |
  | George    | Zeng       | glz@berkeley.edu           | kiwi   | None     | 12345678  | 123456   | 123456                | registration_code |
  | Jason     | Bi         | jbi@berkeley.edu           | kiwi   | None     | 13371384  | 123456   | 123456                | registration_code |

Scenario: Superadmin promotes to admin
    Given I am logged in as "a superadmin"
    And I go to the Database page
    Then I should see "George"
    When I follow "More about George"
    Then I should see "Standard User"
    And I should see the button "Make Admin"
    And I should not see the button "Make Superadmin"
    When I press "Make Admin"
    Then I should see "Admin"
    And I should not see the button "Make Admin"
    And I should see the button "Make Superadmin"

Scenario: Superadmin promotes someone to superadmin
    Given I am logged in as "a superadmin"
    And I go to the Database page
    When I follow "More about George"
    When I press "Make Admin"
    When I press "Make Superadmin"
    Then I should see "Superadmin"

Scenario: Admin demoting someone to regular user
    Given I am logged in as "a superadmin"
    And I go to the Database page
    When I follow "More about George"
    When I press "Make Admin"
    Then I should see the button "Make Regular"
    When I press "Make Regular"
    Then I should see "Standard User"

Scenario: Admin should not see any choices to promote people
  Given I am logged in as "an admin"
  And I go to the Database page
  When I follow "More about George"
  Then I should not see the button "Make Admin"


