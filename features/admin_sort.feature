Feature: Sort by column in admin view
  In order to view members in an orderly fashion
  As an admin
  I want to be able to sort by table column

Background: members have been added to database
  Given I am logged in as "an admin"
  Given the following users exist
  | first     | last       | email                      | team   | skillset | sid       | password | password_confirmation | code              |
  | George    | Zeng       | glz@berkeley.edu           | kiwi   | None     | 12345678  | 123456   | 123456                | registration_code |
  | Chau      | Van        | cv@berkeley.edu            | kiwi   | None     | 69420420  | 123456   | 123456                | registration_code |
  | Jason     | Bi         | jbi@berkeley.edu           | cs169  | None     | 13371384  | 123456   | 123456                | registration_code |
  | Nick      | Cai        | ncai@yahoo.com             | cs169  | None     | 12342342  | 123456   | 123456                | registration_code |
  | Kyle      | Ngo        | kylengo@berkeley.edu       | kiwi   | None     | 87654321  | 123456   | 123456                | registration_code |
  | Michael   | Wu         | michaelwu@berkeley.edu     | exec   | None     | 42042069  | 123456   | 123456                | registration_code |
  | Mihir     | Chitalia   | mihirchitalia@berkeley.edu | kiwi   | None     | 12345679  | 123456   | 123456                | registration_code |

  And I am on the Admin Database page
  Then 7 seed users should exist

Scenario: all users displayed, asc by first name by default
  Given I am on the Admin Database page
  Then I should see all the users
  And I should see that "Chau" is before "George"
  And I should see that "Mihir" is before "Nick"

Scenario: sort by first name
  Given I am on the Admin Database page
  When I follow "First"
  Then I should see that "Nick" is before "Chau"

  When I follow "First"
  Then I should see that "Chau" is before "Nick" 
