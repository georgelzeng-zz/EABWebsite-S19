Feature: Admin view search
  In order to view member personal information
  As a club admin
  I want to be able to search through all members' information

 Background: members have been added to database
  When I sign in with valid credentials as an admin
  Given the following users exist
  | first     | last       | email                      | team   | skillset | sid       | password | password_confirmation | code       |
  | George    | Zeng       | glz@berkeley.edu           | kiwi   | None     | 12345678  | 123456   | 123456                | Michael    |
  | Chau      | Van        | cv@berkeley.edu            | kiwi   | None     | 69420420  | 123456   | 123456                | Michael Wu |
  | Jason     | Bi         | jbi@berkeley.edu           | cs169  | None     | 13371384  | 123456   | 123456                | Michael    |
  | Nick      | Cai        | ncai@yahoo.com             | cs169  | None     | 12342342  | 123456   | 123456                | Michael    |
  | Kyle      | Ngo        | kylengo@berkeley.edu       | kiwi   | None     | 87654321  | 123456   | 123456                | Michael    |
  | Michael   | Wu         | michaelwu@berkeley.edu     | exec   | None     | 42042069  | 123456   | 123456                | Michael    |
  | Mihir     | Chitalia   | mihirchitalia@berkeley.edu | kiwi   | None     | 12345679  | 123456   | 123456                | Michael    |

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

Scenario: all users displayed by default
  Given I am on the users page
  And I follow "Admin View"
  Then I should be on admin page
  And I should see all the users

Scenario: find user by email
  Given I am on the admin page
  When I fill in "search" with "ncai@yahoo.com"
  And I press "Search"
  Then I should see "Nick"

Scenario: find user by sid
  Given I am on the admin page
  When I fill in "search" with "12345678"
  And I press "Search"
  Then I should see "George"
  Then I should not see "Michael"

