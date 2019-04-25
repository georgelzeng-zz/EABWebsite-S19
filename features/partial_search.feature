Feature: Partial search
  In order to find potential team members
  As a user
  I want to be able to search for people with attributes I am unsure of

Background: members have been added to database
  Given I exist as a user
  When I sign in with valid credentials
  Given the following users exist
  | first     | last       | email                      | team       | skillset | sid       | password | password_confirmation | code              |
  | George    | Zeng       | glz@berkeley.edu           | kiwi       | None     | 12345678  | 123456   | 123456                | registration_code |
  | Chau      | Van        | cv@berkeley.edu            | kiwi       | None     | 69420420  | 123456   | 123456                | registration_code |
  | Jason     | Bi         | jbi@berkeley.edu           | cs169      | None     | 13371384  | 123456   | 123456                | registration_code |
  | Nick      | Cai        | ncai@yahoo.com             | cs169      | None     | 12342342  | 123456   | 123456                | registration_code |
  | Kyle      | Ngo        | kylengo@berkeley.edu       | kiwi       | None     | 87654321  | 123456   | 123456                | registration_code |
  | Michael   | Wu         | michaelwu@berkeley.edu     | exec       | None     | 42042069  | 123456   | 123456                | registration_code |
  | Mihir     | Chitalia   | mihirchitalia@berkeley.edu | kiwi       | None     | 12345679  | 123456   | 123456                | registration_code |
  | Jennifer  | White      | jennifer123@gmail.com      | blue team  | None     | 42042029  | 123456   | 123456                | registration_code |
  | Jonathan  | Hill       | jonhill@gmail.com          | red team   | None     | 12341679  | 123456   | 123456                | registration_code |

  And I am on the users page
  Then 9 seed users should exist

Scenario: search for an attribute that starts with keyword as member
  Given I am on the users page
  When I fill in "search" with "mi"
  And I press "Search"
  Then I should see "Michael"
  And I should see "Mihir"

Scenario: search for an attribute that starts with keyword as admin
  Given I am logged in as "an admin"
  When I go to the Admin Database page
  And I fill in "search" with "@example"
  And I press "Search"
  Then I should see "Testy"

Scenario: search for part of a phrase, ie. team name
  Given I am on the users page
  When I fill in "search" with "red"
  And I press "Search"
  Then I should see "Jonathan"

  When I fill in "search" with "team"
  And I press "Search"
  Then I should see "Jennifer"
  And I should see "Jonathan"

Scenario: search for phrase, see similar matches
  Given I am on the users page
  When I fill in "search" with "Mihir NICK"
  And I press "Search"
  Then I should see "Mihir"
  And I should see "Nick"

Scenario: search for phrase, see similar matches, part 2
  Given I am on the users page
  When I fill in "search" with "red team"
  And I press "Search"
  Then I should see "Jonathan"
  And I should see "Jennifer"
