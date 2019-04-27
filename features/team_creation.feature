Feature: allow members to start teams

As a member of EAB
So that I may perform recruit members for my team
I want to be able to make a team


    Scenario: User creates a team
      Given I am on the team creation page
      And I am logged in as "a regular user"
      When I create a team with valid fields
      Then I should see "Poopy"
