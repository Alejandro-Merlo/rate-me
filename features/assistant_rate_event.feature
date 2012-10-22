Feature: As an assistant I want to rate the event to give feedback to the speaker

        Scenario: Successful rating of an event
          Given the "great event" exists for "2012-10-19" 
          And I am in the event "great event" rate event page
          Then I should see "great event"
          When I choose "Positive"
          And I press "Send"
          Then I should see "score was sent"
