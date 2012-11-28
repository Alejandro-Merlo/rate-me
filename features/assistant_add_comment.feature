Feature: As an assistant I want to discuss my qualification to give more details

        Scenario: Successful sending of a comment
          Given the "great event 2" exists for "2012/10/19"
          And I am in the event "great event 2" rate event page
          When I choose "Neutral"
          And I fill in "comment" with "That was good"
          And I press "Send"
          Then I should see "score was sent"
