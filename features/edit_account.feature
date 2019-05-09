Feature: Allow users to edit their own profile

As a user
So that I can update my profile
Given that I am on my user's profile
I want to be able to edit the information

Scenario: User can edit their profile info
    Given I exist as a user
    And I sign in with valid credentials
    And I follow "More"
    And I follow "View Profile"
    Then I should see the link "Edit Account"
    When I follow "Edit Account"
    Then I should see "New password"
    And I should see "needed to make changes to email or password"
    When I fill in "user_linkedinLstring" with "reddit.com"
    And I press "Update"
    Then I should see "Your account has been updated successfully."


Scenario: User cannot edit their password without current password
    Given I exist as a user
    And I sign in with valid credentials
    And I follow "More"
    And I follow "View Profile"
    Then I should see the link "Edit Account"
    When I follow "Edit Account"
    Then I should see "New password"
    And I should see "needed to make changes to email or password"
    When I fill in "user_password" with "123456"
    And I fill in "user_password_confirmation" with "123456"
    And I press "Update"
    Then I should see "Current password can't be blank"


Scenario: User can edit their password with current password
    Given I exist as a user
    And I sign in with valid credentials
    And I follow "More"
    And I follow "View Profile"
    Then I should see the link "Edit Account"
    When I follow "Edit Account"
    Then I should see "New password"
    And I should see "needed to make changes to email or password"
    When I fill in "user_password" with "123456"
    And I fill in "user_password_confirmation" with "123456"
    And I fill in "user_current_password" with my password
    And I press "Update"
    Then I should see "Your account has been updated successfully."

