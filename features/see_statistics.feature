Feature: As a speaker I want to see the event qualifications to have statistics

        Scenario: Successful access to an event statistics
          Given the user "Jose" exists
          And the "talk 2" of "Jose" exists for "2012-11-26"
          And I am in the event "talk 2" statistics page
          Then I should see "talk 2"
          And I should see "Scores summary"
