Feature: admins can download an XML file with every user

As and admin of the club
So that I may have a file containing info on all the users
I want to be able to download an XML file of the user's table

Scenario: Admin goes to Admin Database page and clicks the download link
  Given I am logged in as "an admin"
  And I am on the Admin Database page
  When I follow "Download Roster"
  Then I should receive a file: "EAB_roster.xml"

Scenario: Regular user goes to Regular Database page and should not see the download link
  Given I am logged in as "a regular user"
  And I am on the Database page
  Then I should not see the link "Download Roster"
