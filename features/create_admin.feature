Feature: allow special members to create an admin account in the service

As a special member of EAB
So that I may perform administrative duties for the club
I want to be able to make an admin account


    Scenario: User signs up with Admin-access-code
      Given I start signing up with valid user data
      And I register my "code" as "the admin code"
      When I sign up
      Then I should be an admin

    Scenario: User signs up with invalid admin-access-code
      Given I start signing up with valid user data
      And I register my "code" as "not the admin code"
      When I sign up
      Then I should see "Wrong access code"
