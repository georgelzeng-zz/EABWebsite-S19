Feature: navigate to homepage with logo and profile with profile image

As a user
So I may quickly navigate to the homepage and profile
I want to be able to quickly navigate between pages

Scenario: navigate to homepage from users database
  Given I am logged in as "a regular user"
  When I view users
  And I follow "Entrepreneurs @ Berkeley"
  Then I should see "Hello"

