Feature: navigate to homepage with logo and profile with profile image

As a user
So I may quickly navigate to the homepage and profile
I want to be able to quickly navigate between pages

Scenario: navigate to homepage from users database
  Given I am logged in as "a regular user"
  When I view users
  And I follow "Entrepreneurs @ Berkeley"
  Then I should be on the homepage

Scenario: navigate to homepage from admin database
  Given I am logged in as "an admin"
  When I go to the Admin Database page
  And I follow "Entrepreneurs @ Berkeley"
  Then I should be on the homepage

Scenario: navigate to profile page from users database
  Given I am logged in as "a regular user"
  When I go to the Database page
  And I follow "Testy McUserton"
  Then I should see "Profile"
  And I should see "Testy McUserton"
  Then I should see the link "Home"
  And I should not see "SID"
  And I should see "Email"
  And I should see the link "Edit User"

Scenario: navigate to profile page from admin database
  Given I am logged in as "an admin"
  When I go to the Admin Database page
  And I follow "Testy McUserton"
  Then I should see "Profile"
  And I should see the link "Edit User"
  And I should see "example@example.com"
  Then I should see the button "Delete User"
  
Scenario: navigate to home from profile page
  Given I am logged in as "a regular user"
  When I go to the Database page
  And I follow "Testy McUserton"
  And I follow "Entrepreneurs @ Berkeley"
  Then I should be on the homepage

Scenario: viewing others' profiles as member
  Given I am logged in as "a regular user"
  When I go to the Database page
  And I follow "More about Testy"
  Then I should not see "SID"
  Then I should not see the button "Delete User"
  Then I should not see "example@example.com"