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
    Then I should see "Admin View"
    And follow "More about Testy"
    Then I should see the button "Delete User"

Scenario: User does not have option to delete user
    Given I exist as a user 
    And I sign in with valid credentials
    When I view users
    Then I should not see "Admin View"
    When I follow "More about Testy"
    Then I should not see the button "Delete User"

#Scenario: Admin deletes user
    #Given I exist as a user
    #Given I exist as an admin
    #And I sign in as an admin
    #When I view users
    #And I follow "More about Testy"
    #Then I should see the button "Delete User"
    #And I press the "Delete User" button with confirmation
    #Then I should see "User was successfully deleted"
    #Then I should not see "More about Testy"








