Feature: allow president to create a superadmin account in the service

As the top  member of EAB
So that I may perform super administrative duties for the club
I want to be able to make an superadmin account


    Scenario: User signs up with Superadmin-access-code
      Given I start signing up with valid user data
      And I register my "code" as "the superadmin code"
      When I sign up
      Then I should be a superadmin

    Scenario: User signs up with invalid superadmin-access-code
      Given I start signing up with valid user data
      And I register my "code" as "not the admin code"
      When I sign up
      Then I should see "Wrong access code"
