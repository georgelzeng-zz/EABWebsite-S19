Feature: allow members to start projects

As a member of EAB
So that I may perform recruit members for my project
I want to be able to make a project


    Scenario: User creates a project
      Given I am on the project creation page
      And I am logged in as "a regular user"
      When I create a project with valid fields
      Then I should see "Poopy"
