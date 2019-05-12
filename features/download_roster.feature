Feature: admins can download an XLSX file with every user

As and admin of the club
So that I may have a file containing info on all the users
I want to be able to download an XLXS file of the user's table

Scenario: Admin goes to Admin Database page and clicks the download link
  Given I am logged in as "an admin"
  And I am on the Admin Database page
  When I press "Export Members as XLSX"
  Then I should be on the spreadsheet page

Scenario: Regular user goes to Regular Database page and should not see the download link
  Given I am logged in as "a regular user"
  And I am on the Database page
  Then I should not see the button "Export Members as XLSX"
