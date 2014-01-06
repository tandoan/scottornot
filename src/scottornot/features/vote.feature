Feature: Vote
  In order to blah bla
  As a user
  I want to be able to vote

  Scenario: Voting for the first time
    Given I am a normal user
    When I visit the voting page
    And I have not voted before
    Then I should see a picture to vote on
    And I should not see a prior vote
    And I should see a voting fom

  Scenario: Voting a second time
    Given I am a normal user
    And I visit the voting page
    And I have not voted before
    When I vote
    Then I should see a picture to vote on
    And I should see a voting fom
    And I should see my previous vote in the side bar