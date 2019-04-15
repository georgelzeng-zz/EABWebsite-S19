Feature: General member search
  In order to find potential team members
  As a general member
  I want to be able to search for people

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

Scenario: all users displayed by default
  Given I am on the users page
  Then I should see all the users

Scenario: find user by first name happy path
  Given I am on the users page
  When I fill in "search" with "Nick"
  And I press "Search"
  Then I should see "Nick"

Scenario: find user by last name happy path
  Given I am on the users page
  When I fill in "search" with "zeng"
  And I press "Search"
  Then I should see "George"
  Then I should not see "Michael"

Scenario: find user by team name, alphabetical results happy path
  Given I am on the users page
  When I fill in "search" with "kiwi"
  And I press "Search"
  Then I should see that "Chau" is before "George"
  And I should see that "George" is before "Kyle"
  And I should see that "Kyle" is before "Mihir"

Scenario: find user by full name, case insensitive sad path
  Given I am on the users page
  When I fill in "search" with "nick cai"
  And I press "Search"
  Then I should see "Nick"

Scenario: find user by last name happy path
  Given I am on the users page
  When I fill in "search" with "zeng"
  And I press "Search"
  Then I should see "George"
  Then I should not see "Michael"

Scenario: find user by team name, alphabetical results happy path
  Given I am on the users page
  When I fill in "search" with "kiwi"
  And I press "Search"
  Then I should see that "Chau" is before "George"
  And I should see that "George" is before "Kyle"
  And I should see that "Kyle" is before "Mihir"

Scenario: find user by full name, case insensitive sad path
  Given I am on the users page
  When I fill in "search" with "nick cai"
  And I press "Search"
  Then I should see "Nick"
  And I should not see "Jason"

Scenario: blank input, sad path
  Given I am on the users page
  When I fill in "search" with " "
  And I press "Search"
  Then I should see "Chau"
  And I should see "George"
  And I should see "Jason"
  And I should see "Kyle"
  And I should see "Michael"
  And I should see "Mihir"
  And I should see "Nick"

Scenario: find user by full name, case insensitive reversed sad path
  Given I am on the users page
  When I fill in "search" with "van chau"
  And I press "Search"
  Then I should see "Chau"
  And I should not see "Kyle"

Scenario: find user by full name, case insensitive reversed sad path
  Given I am on the users page
  When I fill in "search" with "van chau"
  And I press "Search"
  Then I should see "Chau"
  And I should not see "Kyle"

Scenario: find user by full name and team, show exact result first then similar like fb
  Given I am on the users page
  When I fill in "search" with "mihir chitalia kiwi"
  And I press "Search"
  Then I should see "Mihir"
  Then I should see that "Mihir" is before "Chau"
  Then I should see that "Chau" is before "George"

Scenario: find user by team name, full name sad
  Given I am on the users page
  When I fill in "search" with "zeng george kiwi"
  And I press "Search"
  Then I should see "George"

Scenario: no input sad path
  Given I am on the users page
  And I press "Search"
  Then I should see "Chau"
  And I should see "George"
  And I should see "Jason"
  And I should see "Kyle"
  And I should see "Michael"
  And I should see "Mihir"
  And I should see "Nick"
