Feature: Allow admins to delete other users


As an admin
So that I can remove a user
Given that I am on a user's profile page
I want to be able to remove that user 


   Scenario: Admin has option to delete user
      Given I exist as a user
      Given I exist as an admin
      When I sign in as an admin
      When I view users
      And follow "More about Testy"
      Then I should see "Delete User"

    Scenario: User does not have option to delete user
      Given I exist as a user 
      And I sign in with valid credentials
      When I view users
      When I follow "More about Testy"
      Then I should not see "Delete User"

      

    Scenario: Admin deletes user
      Given I exist as a user
      Given I exist as an admin
      And I sign in as an admin
      When I view users
      And I follow "More about Testy"
      Then I should see "Delete User"
      And I press "Delete User"







