Feature: allow users to create an account in the service

As a new user 
So that I may create an account 
I want to input my information and Michael's code to make an account


    Scenario: User signs up with valid data
      Given I start signing up with valid user data
      And the current "regular access code" is "regular"
      And I register my "code" as "regular"
      And I sign up
      Then I should see a successful sign up message
      
    Scenario: User signs up with invalid email
      When I sign up with an invalid email
      Then I should see an invalid email message

    Scenario: User signs up without password
      When I sign up without a password
      Then I should see a missing password message

    Scenario: User signs up without password confirmation
      When I sign up without a password confirmation
      Then I should see a missing password confirmation message

    Scenario: User signs up with mismatched password and confirmation
      When I sign up with a mismatched password confirmation
      Then I should see a mismatched password message