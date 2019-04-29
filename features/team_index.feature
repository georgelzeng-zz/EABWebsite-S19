Feature: allow users to browse teams

As a member of EAB
So that I may search for a team I'd like to join
I want to be able to see all the teams on one page

Background: Users and Teams already exist
  Given the following users exist
  | first   | last     | email                      | team  | skillset | sid      | password | password_confirmation | code              |
  | George  | Zeng     | glz@berkeley.edu           | kiwi  | None     | 12345678 | 123456   | 123456                | registration_code |
  | Chau    | Van      | cv@berkeley.edu            | kiwi  | None     | 69420420 | 123456   | 123456                | admin_code        |
  | Jason   | Bi       | jbi@berkeley.edu           | cs169 | None     | 13371384 | 123456   | 123456                | registration_code |
  | Nick    | Cai      | ncai@yahoo.com             | cs169 | None     | 12342342 | 123456   | 123456                | registration_code |
  | Kyle    | Ngo      | kylengo@berkeley.edu       | kiwi  | None     | 87654321 | 123456   | 123456                | registration_code |
  | Michael | Wu       | michaelwu@berkeley.edu     | exec  | None     | 42042069 | 123456   | 123456                | registration_code |
  | Mihir   | Chitalia | mihirchitalia@berkeley.edu | kiwi  | None     | 12345679 | 123456   | 123456                | registration_code |

Scenario: Member is logged in
  Given I am logged in
  And I am on the Team Database page
  Then I should see "kiwi"
  And I should see "George Zeng"
  And I should see "4"
  And I should see "cs169"
  And I should see "Jason Bi"
  And I should see "2"
  And I should see "exec"
  And I should see "Michael Wu"
  And I should see "1"
  And I should not see "Chau Van"
  And I should not see "Nick Cai"
  And I should not see "Kyle Ngo"
  And I should not see "Mihir Chitalia"

Scenario: User is not logged in
  Given I am not logged in
  And I go to the Team Database page
  Then I should be on the login page
