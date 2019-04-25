Feature: Hide log in and sign up buttons for already logged in users

As a existing user
When I log in, I should no longer see the log in and log out buttons


   Scenario: User signs in successfully
    Given I exist as a user
    When I sign in with valid credentials
    And I return to the site
    Then I should not see "Login"
    Then I should not see "Create New Account"


  Scenario: User is not logged in
    Given I am not logged in
    When I return to the site
    Then I should see "Login"
    Then I should see "Create New Account"