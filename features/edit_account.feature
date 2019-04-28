Feature: Allow users to edit their own profile
  
As a user
So that I can update my profile
Given that I am on my user's profile
I want to be able to edit the information

Scenario: User can edit their profile info
    Given I exist as a user
    And I sign in with valid credentials
    When I follow "Testy"
    Then I should see the link "Edit Account"
    When I follow "Edit Account"
    Then I should see "leave blank if you don't want to change it"
    And I should see "we need your current password to confirm your changes"
