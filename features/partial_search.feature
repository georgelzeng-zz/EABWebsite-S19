Feature: Partial search
  In order to find potential team members
  As a user
  I want to be able to search for people with attributes I am unsure of

Background: members have been added to database
  Given I exist as a user
  When I sign in with valid credentials
  Given the following users exist
  | first     | last       | email                      | team   | skillset | sid       | password | password_confirmation | code              |
  | George    | Zeng       | glz@berkeley.edu           | kiwi   | None     | 12345678  | 123456   | 123456                | registration_code |
  | Chau      | Van        | cv@berkeley.edu            | kiwi   | None     | 69420420  | 123456   | 123456                | registration_code |
  | Jason     | Bi         | jbi@berkeley.edu           | cs169  | None     | 13371384  | 123456   | 123456                | registration_code |
  | Nick      | Cai        | ncai@yahoo.com             | cs169  | None     | 12342342  | 123456   | 123456                | registration_code |
  | Kyle      | Ngo        | kylengo@berkeley.edu       | kiwi   | None     | 87654321  | 123456   | 123456                | registration_code |
  | Michael   | Wu         | michaelwu@berkeley.edu     | exec   | None     | 42042069  | 123456   | 123456                | registration_code |
  | Mihir     | Chitalia   | mihirchitalia@berkeley.edu | kiwi   | None     | 12345679  | 123456   | 123456                | registration_code |

  And I am on the users page
  Then 7 seed users should exist

Scenario: search for an attribute that starts with keyword as member
  Given I am on the users page
  When I fill in "search" with "mi"
  And I press "Search"
  Then I should see "Michael"
  And I should see "Mihir"

Scenario:
  Given I am logged in as "an admin"
  When I go to the Admin Database page
  And I fill in "search" with "@example"
  And I press "Search"
  Then I should see "Testy"
