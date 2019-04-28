Feature: User can view teams in existence

As a user
So I can view project teams and information
I want to be able to see projects and their pages

Background:
  Given I am on the team creation page
  And I am logged in as "a regular user"
  When I create a team with valid fields
  Then I should see "Poppy"
  And I should see "More about Poppy"

Scenario: General member views project teams
  Given I am on the users page
  When I follow "Teams"
  Then I should see "All Teams"
  And I should see "Poppy"
  And I should see the link "Create Team"
  When I follow "Poppy"
  Then I should see "Teams"
