Feature: allow users to login to the service

As a existing user
So that I may log into the app


 Scenario: User is not signed up
    Given I do not exist as a user
    When I sign in with valid credentials
    Then I should be signed out

  Scenario: User is not logged in
    Given I am not logged in
    When I return to the site
    Then I should see I am not logged in

  Scenario: User signs in successfully
    Given I exist as a user
    When I sign in with valid credentials
    Then I see a successful sign in message
    When I return to the site
    Then I should be signed in

  Scenario: User enters wrong email
    Given I exist as a user
    When I sign in with a wrong email
    Then I should be signed out

  Scenario: User enters wrong password
    Given I exist as a user
    When I sign in with a wrong password
    Then I should be signed out
